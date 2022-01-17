require './lib/snes_builder'

module Sparkles
  class Draw < SnesBuilder::AssemblyModule
    vram_base = 0x1000
    text_x = 5; text_y = 18
    logo_x = 12; logo_y = 9

    memory :var_pos, 2
    memory :var_pos, 2
    memory :var_text_drawn, 2
    memory :var_draw_wait, 2
    memory :var_logo_drawn, 2
    memory :var_tmp1, 2
    memory :var_tmp2, 2
    memory :var_tmp3, 2
    memory :var_curs_x, 2
    memory :var_curs_y, 2
    memory :var_logo_row, 2
  
    equate :const_wait_time, 0x2
    equate :vram_text_base, vram_base + 32 * text_y + text_x
    equate :vram_logo_base, vram_base + 32 * logo_y + logo_x
    equate :vram_base, vram_base

    def_sub :init do
      php
      rep 0x30
      stz Draw.var_pos
      stz Draw.var_text_drawn
      stz Draw.var_logo_drawn
      lda.w 0x2
      sta Draw.var_curs_x
      sta Draw.var_curs_y
      lda.w Draw.const_wait_time
      sta Draw.var_draw_wait
      plp
    end

    def_sub :update do
      php

      rep 0x30

      lda Draw.var_draw_wait
      bne _ :exit

      lda.w Draw.const_wait_time
      sta Draw.var_draw_wait

      jsr Draw.render_logo
      jsr Game.joy
      jsr Draw.render_text

    label _ :exit

      dec.a Draw.var_draw_wait

      plp
    end

    def_sub :render_logo do
      php
      phx

      lda Draw.var_logo_drawn
      bne _ :exit

      inc
      sta Draw.var_logo_drawn
      stz Draw.var_logo_row

    label _ :next_row
      ldx.w 0

    label _ :next_col
      lda Draw.var_logo_row
      5.times { asl }
      clc
      adc.w Draw.vram_logo_base
      sta Draw.var_tmp1
      txa
    
      clc
      adc.a Draw.var_tmp1
      sta Snes.reg_VMADDL

      lda Draw.var_logo_row
      4.times { asl }
      clc
      adc.w 0x24A0
      sta Draw.var_tmp1

      txa
      clc
      adc.a Draw.var_tmp1
      sta Snes.reg_VMDATAL

      inx
      cpx.w 0x8
      bcc _ :next_col

      lda Draw.var_logo_row
      inc
      cmp.w 0x07
      bcs _ :exit
      sta Draw.var_logo_row
      bra _ :next_row

    label _ :exit
      plx
      plp
    end

    def_sub :render_text do
      php
      phx

      stz Draw.var_tmp1
      lda Draw.var_curs_y
      5.times { asl }
      clc
      adc.a Draw.var_curs_x
      clc
      adc.w Draw.vram_base
      sta Snes.reg_VMADDL

      lda.w 0x2090
      sta Snes.reg_VMDATAL

      lda Draw.var_text_drawn
      anda.w 0xFF
      bne _ :exit

      lda Draw.var_pos
      tax
      inc.a Draw.var_pos
      clc
      adc.w Draw.vram_text_base
      sta Snes.reg_VMADDL

      lda.ax Draw.hello_str
      anda.w 0xFF
      bne _ :draw_char
      lda.w 0xFF
      sta Draw.var_text_drawn
      bra _ :exit

    label _ :draw_char
      clc
      adc.w 0x2000
      sta Snes.reg_VMDATAL

    label _ :exit
      plx
      plp
    end

    def_data :hello_str do
      data "\x90 ~hello, sparkles!~ \x90\x0"
    end
  end
end