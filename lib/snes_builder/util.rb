require 'pastel'
require './lib/snesasm'
require './lib/snes_builder/snes'
require 'bin_tools'

module SnesBuilder
  module Util
    def self.printstep(text, indent: 0, type: nil)
      pastel = Pastel.new
      indent_str = " " * indent * 4 + "#{pastel.blue("-")} "
      type_str = !type.nil? ? "#{pastel.blue("[")}#{pastel.yellow(type)}#{pastel.blue("]")} " : ""
      text_str = "#{indent_str}#{type_str}#{pastel.cyan(text)}"
      puts text_str
    end

    def self.offset_to_addr offset
      bank = offset / 0x8000 + 0x80
      addr = offset % 0x8000 + 0x8000
      (bank << 16) + addr
    end

    def self.offset_str offset
      addr = offset_to_addr(offset)
      "0x%02X (%02X:%04X)" % [offset, addr >> 16, addr & 0xFFFF]
    end

    def self.addr_str addr
      offset = addr_to_offset(addr)
      "0x%02X (%02X:%04X)" % [offset, addr >> 16, addr & 0xFFFF]
    end

    def self.addr_to_offset addr
      ((addr & 0x7F0000) >> 1) + (addr & 0x7FFF)
    end

    def self.word_to_str val
      (val & 0xFF).chr + (val >> 8).chr
    end

    def self.seek_addr(f, addr)
      f.seek addr_to_offset(addr)
    end

    def self.assemble(addr, vars={}, &blk)
      macro = Snesasm::Macro.new(vars) do
        align addr
      end
      macro.add_code(&blk)
      code = macro.call
      puts code.dump
      bytes = code.to_binary
      [bytes[2...(bytes.size)], vars.merge(code.labels)]
    end

    def self.patch_asm(f, name, indent, addr, vars={}, &blk)
      pastel = Pastel.new
      bin, vars = assemble(addr & 0xFFFF, vars, &blk)
      printstep "#{pastel.white(name)} (#{pastel.white("0x%X bytes" % bin.size)}) to #{pastel.white(addr_str(addr))}", type: "insert asm", indent: indent
      seek_addr f, addr
      f.write_str bin
      return vars.merge({
        name.to_sym => addr & 0xFFFF,
        "#{name}_long".to_sym => addr,
        "#{name}_end".to_sym => (addr + bin.size) & 0xFFFF,
        "#{name}_end_long".to_sym => (addr + bin.size),    
      })
    end

    def self.snes_color(r, g, b)
      color = (r & 0x1F) + ((g & 0x1F) << 5) + ((b & 0x1F) << 10)
      word_to_str(color)
    end

    def self.snes_color_from_hex(hex)
      r = ((hex >> 16) & 0xFF) >> 3
      g = ((hex >> 8) & 0xFF) >> 3
      b = (hex & 0xFF) >> 3
      snes_color(r, g, b)
    end


    def self.resolve_global_vars_chain(m)
      global_vars = []
      global_vars << m.globals
    
      m.imports.each do |im|
        global_vars += resolve_global_vars_chain(im.new)
      end
    
      global_vars
    end
    
    def self.get_globals(m)
      resolve_global_vars_chain(m).reverse.reduce({}) do |ha, obj|
        ha.merge(obj)
      end
    end
    
    def self.resolve_exports_chain(m)
      exports = []
      m.exports.each do |mex|
        rex = mex.merge({
          code: m.send(mex[:name])
        })
        exports << rex
      end
    
      m.imports.each do |im|
        exports += resolve_exports_chain(im.new)
      end
    
      exports
    end
    
    def self.get_exports(m)
      resolve_exports_chain(m)
    end
    
    def self.build_program(outfn, input_module)
      BinTools::Writer.open(outfn) do |fw|
        root_module = input_module.new
      
        root_globals = get_globals(root_module)
        root_exports = get_exports(root_module)
      
        v = {}.merge(SnesBuilder::Snes::Registers).merge(root_globals)
      
        fw.seek 0
        fw.write_str "\xFF" * root_globals[:rom_size_bytes]
      
        v = Util.patch_asm(fw, "main", 0, 0x808000, v) do
          root_exports.each do |mex|
            instance_exec(&mex[:code])
          end
        end
      
        puts "Exports:"
        root_exports.each do |x|
          if x[:align]
            puts "___(:#{x[:amod].name}, :#{x[:name]}) @ #{Util.addr_str(x[:align])}"
          else
            puts "___(:#{x[:amod].name}, :#{x[:name]})"
          end
        end
      end
    end
  end
end