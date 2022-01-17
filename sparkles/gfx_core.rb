require './lib/snes_builder'
require './lib/png_convert'

module Sparkles
  class GfxCore < SnesBuilder::AssemblyModule
    def self.name
      "gfx_core"
    end

    def_code :load_font do
      php
      phx

      rep 0x10
      sep 0x20

      lda.i8 0x80
      sta rVMAIN
      ldx.i16 vram_charset
      stx rVMADDL
      ldx.i16 0

      rep 0x30

      label _(:loop)
      lda.ax __(:font)
      sta rVMDATAL
      inx
      inx
      cpx.i16 0x1000
      bne _(:loop)

      plx
      plp
      rts
    end

    def_code :load_palettes do
      php
      phx

      rep 0x10
      sep 0x20

      stz rCGADD

      ldx.i16 0

      label _(:loop)

        lda.ax __(:palette)
        sta rCGDATA
        inx
        cpx.i16 0x8 * 2
        bcc _(:loop)

      plx
      plp
      rts
    end

    def_code :palette, 0x8800 do
      data SnesBuilder::Util.snes_color_from_hex(0xFFFFFF)
      data SnesBuilder::Util.snes_color_from_hex(0xDBAD03)
      data SnesBuilder::Util.snes_color_from_hex(0xEFC624)
      data SnesBuilder::Util.snes_color_from_hex(0x9B50B7)

      data SnesBuilder::Util.snes_color_from_hex(0xFFFFFF)
      data SnesBuilder::Util.snes_color_from_hex(0x9B50B7)
      data SnesBuilder::Util.snes_color_from_hex(0xCB9D03)
      data SnesBuilder::Util.snes_color_from_hex(0xD677D8)
    end

    def_code :font, 0x9000 do
      data PngConvert.convert_to_2bpp("sparkles/data/font.png")
    end
  end
end
