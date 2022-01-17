require './lib/snes_builder'

require "./sparkles/snes"
require "./sparkles/game"
require "./sparkles/draw"
require "./sparkles/gfx_core"
require "./sparkles/header"

module Sparkles
  class Program < SnesBuilder::AssemblyModule
    def imports
      [Snes, Game, Draw, GfxCore, Header]
    end

    SIZE_KB = 32      

    global_var :rom_size_bytes, SIZE_KB << 10
    global_var :memory_base, 0      
    equate :rom_size_exp, (Math.log(SIZE_KB) / Math.log(2)).to_i

    def_code :main, 0x8000 do
      jmp Game.start
    end

    def_code :nmi do 
      jmp Game.vblank
    end

    def_code :rti do
      rti
    end
  end
end
