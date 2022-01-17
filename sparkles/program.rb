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

    equate :vram_charset, 0
    equate :vram_bg1, 0x1000
    equate :vram_bg2, 0x1400
    equate :vram_bg3, 0x1800
    equate :vram_bg4, 0x1C00

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
