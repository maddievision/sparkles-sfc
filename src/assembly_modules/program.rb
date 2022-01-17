require './lib/snes_builder'
require "./src/assembly_modules/snes"
require "./src/assembly_modules/game"
require "./src/assembly_modules/draw"
require "./src/assembly_modules/gfx_core"
require "./src/assembly_modules/header"

module Sparkles
  module AssemblyModules
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
end
