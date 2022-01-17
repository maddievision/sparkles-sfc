require './lib/snes_builder'
require './lib/png_convert'

module Sparkles
  class GfxCore < SnesBuilder::AssemblyModule
    equate :vram_charset, 0
    equate :vram_bg1, 0x1000
    equate :vram_bg2, 0x1400
    equate :vram_bg3, 0x1800
    equate :vram_bg4, 0x1C00

    def_sub :load_font do
      php
      phx

      rep 0x10
      sep 0x20

      lda.b 0x80
      sta Snes.reg_VMAIN
      ldx.w GfxCore.vram_charset
      stx Snes.reg_VMADDL
      ldx.w 0

      rep 0x30

      label _ :loop
      lda.ax GfxCore.font
      sta Snes.reg_VMDATAL
      inx
      inx
      cpx.w 0x1000
      bne _ :loop

      plx
      plp
    end

    def_sub :load_palettes do
      php
      phx

      rep 0x10
      sep 0x20

      stz Snes.reg_CGADD

      ldx.w 0

      label _ :loop

        lda.ax GfxCore.palette
        sta Snes.reg_CGDATA
        inx
        cpx.w 0x8 * 2
        bcc _ :loop

      plx
      plp
    end

    def_data :palette, 0x8800 do
      data SnesBuilder::Util.snes_color_from_hex(0xFFFFFF)
      data SnesBuilder::Util.snes_color_from_hex(0xDBAD03)
      data SnesBuilder::Util.snes_color_from_hex(0xEFC624)
      data SnesBuilder::Util.snes_color_from_hex(0x9B50B7)

      data SnesBuilder::Util.snes_color_from_hex(0xFFFFFF)
      data SnesBuilder::Util.snes_color_from_hex(0x9B50B7)
      data SnesBuilder::Util.snes_color_from_hex(0xCB9D03)
      data SnesBuilder::Util.snes_color_from_hex(0xD677D8)
    end

    def_data :font, 0x9000 do
      data PngConvert.convert_to_2bpp("sparkles/data/font.png")
    end
  end
end
