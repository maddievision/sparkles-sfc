require './lib/snesasm'

module SnesBuilder
  module Util
    def self.offset_to_addr offset
      bank = offset / 0x8000
      addr = offset % 0x8000 + 0x8000
      (bank << 16) + addr
    end

    def self.offset_str offset
      addr = offset_to_addr(offset)
      "0x%X (%02X:%04X)" % [offset, addr >> 16, addr & 0xFFFF]
    end

    def self.addr_str addr
      offset = addr_to_offset(addr)
      "0x%X (%02X:%04X)" % [offset, addr >> 16, addr & 0xFFFF]
    end

    def self.addr_to_offset addr
      ((addr & 0x7F0000) >> 1) + (addr & 0x7FFF)
    end

    def self.addr_add addr, add
      offset_to_addr(addr_to_offset(addr) + add)
    end

    def self.word_to_str val
      (val & 0xFF).chr + (val >> 8).chr
    end

    def self.seek_addr(f, addr)
      f.seek addr_to_offset(addr)
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
  end
end