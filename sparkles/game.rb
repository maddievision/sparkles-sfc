require './lib/snes_builder'

module Sparkles  
  class Game < SnesBuilder::AssemblyModule
    memory :var_joy, 2

    def_code :start do
      clc
      xce
      rep 0x10
      sep 0x20

      jsr GfxCore.load_palettes

      lda.b 0x80
      sta Snes.reg_INIDISP

      stz Snes.reg_BGMODE
      lda.b (Program.vram_bg1 >> 8)
      sta Snes.reg_BG1SC
      lda.b ((Program.vram_charset >> 12) | ((Program.vram_charset >> 8) & 0xF0))
      sta Snes.reg_BG12NBA

      jsr GfxCore.load_font
      jsr Draw.init

      lda.b 0x1
      sta Snes.reg_TM
      lda.b 0xF
      sta Snes.reg_INIDISP

      lda.b 0x81 # and controller
      sta Snes.reg_NMITIMEN

      jmp Game.game_loop
    end

    def_code :game_loop do
      rep 0x30

      wai

      lda Snes.reg_JOY1L
      sta Game.var_joy

      jmp _
    end

    def_code :vblank do
      rep 0x10
      sep 0x20
      phd
      pha
      phx
      phy

      lda Snes.reg_RDNMI
      jsr Draw.update

      ply
      plx
      pla
      pld
      rti
    end

    def_sub :joy do
      php
      phx

      rep 0x30

      lda Game.var_joy
      tax
      anda.w 0x100
      bne _ :right
      txa
      anda.w 0x200
      bne _ :left

      bra _ :vertical

    label _ :right
      lda Draw.var_curs_x
      inc
      anda.w 0x1F
      sta Draw.var_curs_x
      bra _ :vertical

    label _ :left
      lda Draw.var_curs_x
      dec
      anda.w 0x1F
      sta Draw.var_curs_x

    label _ :vertical

      txa
      anda.w 0x800
      bne _ :up
      txa
      anda.w 0x400
      bne _ :down

      bra _ :exit

    label _ :up
      lda Draw.var_curs_y
      dec
      bpl _ :overflow1
      lda.w 0x1B

    label _ :overflow1
      sta Draw.var_curs_y
      bra _ :exit

    label _ :down
      lda Draw.var_curs_y
      inc
      cmp.w 0x1C
      bcc _ :overflow2
      lda.w 0

    label _ :overflow2
      sta Draw.var_curs_y

    label _ :exit
      plx
      plp
    end
  end
end