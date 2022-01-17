module SnesBuilder
  class Builder
    def self.resolve_memory_chain(m, memory_base)
      memory_vars = []
      m.memory_vars.each do |name, size, fixed_addr|
        if fixed_addr
          addr = fixed_addr
        else
          addr = memory_base
          memory_base += size
        end
        m.register_memory name, addr
        memory_vars << {
          amod: m.class,
          name: name,
          addr: addr,
        }
      end

      m.imports.each do |im|
        new_memory_vars, memory_base = resolve_memory_chain(im.new, memory_base)
        memory_vars += new_memory_vars
      end

      [memory_vars, memory_base]
    end

    def self.register_memory(m, memory_base = 0)
      resolve_memory_chain(m, memory_base)
    end


    def self.resolve_globals_chain(m)
      global_vars = []
      global_vars << m.globals

      m.imports.each do |im|
        global_vars += resolve_globals_chain(im.new)
      end

      global_vars
    end

    def self.get_globals(m)
      resolve_globals_chain(m).reverse.reduce({}) do |ha, obj|
        ha.merge(obj)
      end
    end

    def self.resolve_exports_chain(m)
      exports = [] + m.exports

      m.imports.each do |im|
        exports += resolve_exports_chain(im.new)
      end

      exports
    end

    def self.get_exports(m)
      resolve_exports_chain(m)
    end

    def self.build_program(outfn, input_module)
      File.open(outfn, 'wb') do |f|
        root_module = input_module.new
      
        root_globals = get_globals(root_module)
        root_exports = get_exports(root_module)
            
        f.seek 0
        f.write "\xFF" * root_globals[:rom_size_bytes]
      
        root_memory, memory_base = register_memory(root_module, root_globals[:memory_base])

        addr = 0x8000

        macro = Snesasm::Macro.new(root_globals) do
          align addr
        end

        root_exports.each do |mex|
          macro.add_code(&mex[:pre_code])
          macro.add_code(&mex[:code])
          macro.add_code(&mex[:post_code]) if mex[:post_code]

        end

        code = macro.call

        puts code.dump
        bytes = code.to_binary
        bin = bytes[2...(bytes.size)]
        labels = code.labels

        Util.seek_addr f, addr

        f.write bin

        end_addr = Util.addr_add(addr, bin.size)
      
        lmod = nil
        root_exports.each do |x|
          amod = x[:amod].module_name
          if lmod != amod
            lmod = amod
            puts
          end
          display_type = x[:meta][:block_type].to_s
          if x[:meta][:block_type] == :code
            display_type += "[#{x[:meta][:code_type]}]"
          end
          display_type = "%-16s" % display_type
          display_addr = "%20s" % Util.addr_str(labels[x[:full_name].to_sym])
          puts "#{display_type} #{display_addr} #{amod}.#{x[:name]}"
        end
        puts
        puts "%-16s %20s" % ["end rom", Util.addr_str(end_addr)]

        root_memory.each do |x|
          amod = x[:amod].module_name
          if lmod != amod
            lmod = amod
            puts
          end
          addr = x[:addr]
          display_type = "%-16s" % "var"
          display_addr = "%20s" % Util.addr_str(addr)
          puts "#{display_type} #{display_addr} #{amod}.#{x[:name]}"
        end
        puts
        puts "%-16s %20s" % ["end vars", Util.addr_str(memory_base)]
        puts
        puts "Written to: #{outfn}"
      end
    end
  end
end