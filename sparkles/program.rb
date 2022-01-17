require './lib/snes_builder'

require "./sparkles/game"
require "./sparkles/draw"
require "./sparkles/gfx_core"
require "./sparkles/header"

module Sparkles
  class Program < SnesBuilder::AssemblyModule
    def self.name
      "program"
    end

    def imports
      [Sparkles::Game, Sparkles::Draw, Sparkles::GfxCore, Sparkles::Header]
    end

    def globals
      {
        vram_charset: 0x0,
        vram_bg1: 0x1000,
        vram_bg2: 0x1400,
        vram_bg3: 0x1800,
        vram_bg4: 0x1C00
      }
    end

    def_code :main, 0x8000 do
      jmp ___(:game, :start)
    end

    def_code :nmi do 
      jmp ___(:game, :vblank)
    end

    def_code :rti do
      rti
    end
  end
end
