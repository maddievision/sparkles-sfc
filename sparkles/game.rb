require './lib/snes_builder'

module Sparkles  
  class Game < SnesBuilder::AssemblyModule
    def self.name
      "game"
    end

    def globals
      { addr_joy: 0x1500 }
    end

    def_code :start do
      clc
      xce
      rep 0x10
      sep 0x20

      jsr ___(:gfx_core, :load_palettes)

      lda.i8 0x80
      sta rINIDISP

      stz rBGMODE
      lda.i8 (vram_bg1 >> 8)
      sta rBG1SC
      lda.i8 ((vram_charset >> 12) | ((vram_charset >> 8) & 0xF0))
      sta rBG12NBA

      jsr ___(:gfx_core, :load_font)
      jsr ___(:draw, :init)

      label __(:enable_display)

        lda.i8 0x1
        sta rTM
        lda.i8 0xF
        sta rINIDISP

        lda.i8 0x81 # and controller
        sta rNMITIMEN

      jmp __(:game_loop)
    end

    def_code :game_loop do
      rep 0x30

      wai

      lda rJOY1L
      sta addr_joy

      jmp _
    end

    def_code :vblank do
      rep 0x10
      sep 0x20
      phd
      pha
      phx
      phy

      lda rRDNMI
      jsr ___(:draw, :update)

      ply
      plx
      pla
      pld
      rti
    end

    def_code :joy do
      php
      phx

      rep 0x30

      lda addr_joy
      tax
      anda.i16 0x100
      bne _(:right)
      txa
      anda.i16 0x200
      bne _(:left)

      bra _(:vertical)

      label _(:right)
      lda addr_curs_x
      inc
      anda.i16 0x1F
      sta addr_curs_x
      bra _(:vertical)

      label _(:left)
      lda addr_curs_x
      dec
      anda.i16 0x1F
      sta addr_curs_x

      label _(:vertical)

      txa
      anda.i16 0x800
      bne _(:up)
      txa
      anda.i16 0x400
      bne _(:down)

      bra _(:exit)

      label _(:up)
      lda addr_curs_y
      dec
      bpl _(:overflow1)
      lda.i16 0x1B

      label _(:overflow1)
      sta addr_curs_y
      bra _(:exit)

      label _(:down)
      lda addr_curs_y
      inc
      cmp.i16 0x1C
      bcc _(:overflow2)
      lda.i16 0

      label _(:overflow2)
      sta addr_curs_y

      label _(:exit)

      plx
      plp
      rts
    end
  end
end