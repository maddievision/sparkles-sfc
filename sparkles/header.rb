require './lib/snes_builder'

module Sparkles
  class Header < SnesBuilder::AssemblyModule
    def self.name
      "header"
    end

    def globals
      size_kb = 32      
      {
        rom_size_kb: size_kb,
        rom_size_exp: (Math.log(size_kb) / Math.log(2)).to_i,
        rom_size_bytes: size_kb << 10,
      }
    end

    def_data :rom_name, 0xFFC0 do
      data "SPARKLES"
    end

    def_data :rom_info, 0xFFD5 do
      data [0x30, 0, rom_size_exp, 0]
      data 0xAAAA
      data 0x5555
    end    

    def_data :vectors_native, 0xFFE0 do
      data [0, 0]
      data [0, 0]
      data ___(:program, :rti)
      data ___(:program, :rti)
      data ___(:program, :rti)
      data ___(:program, :nmi)
      data ___(:program, :main)
      data ___(:program, :rti)
    end

    def_data :vectors_emulation, 0xFFF0 do
      data [0, 0]
      data [0, 0]
      data ___(:program, :rti)
      data [0, 0]
      data ___(:program, :rti)
      data ___(:program, :nmi)
      data ___(:program, :main)
      data ___(:program, :rti)
    end
  end
end
