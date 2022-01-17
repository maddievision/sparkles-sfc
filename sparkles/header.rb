require './lib/snes_builder'

module Sparkles
  class Header < SnesBuilder::AssemblyModule
    def_data :rom_name, Snes.addr_rom_name do
      data "SPARKLES"
    end

    def_data :rom_info, Snes.addr_rom_info do
      data [0x30, 0, Program.rom_size_exp, 0]
      data 0xAAAA
      data 0x5555
    end    

    def_data :vectors_native, Snes.addr_vectors_native do
      data [0, 0]
      data [0, 0]
      data Program.rti
      data Program.rti
      data Program.rti
      data Program.nmi
      data Program.main
      data Program.rti
    end

    def_data :vectors_emulation, Snes.addr_vectors_emulation do
      data [0, 0]
      data [0, 0]
      data Program.rti
      data [0, 0]
      data Program.rti
      data Program.nmi
      data Program.main
      data Program.rti
    end
  end
end
