require './lib/snes_builder'

module Sparkles
  class Draw < SnesBuilder::AssemblyModule
    def self.name
      "draw"
    end

    def globals
      vram_base = 0x1000
      text_x = 5; text_y = 18
      logo_x = 12; logo_y = 9

      {
        addr_pos: 0x100,
        addr_text_drawn: 0x102,
        addr_draw_wait: 0x104,
        addr_logo_drawn: 0x106,
        addr_tmp1: 0x200,
        addr_tmp2: 0x202,
        addr_tmp3: 0x204,
        addr_curs_x: 0x250,
        addr_curs_y: 0x252,
      
        wait_time: 0x2,
        text_base: vram_base + 32 * text_y + text_x,
        logo_base: vram_base + 32 * logo_y + logo_x,
        vram_base: vram_base,
        addr_logo_row: 0x106,
      }
    end

    def_sub :init do
      php
      rep 0x30
      stz addr_pos
      stz addr_text_drawn
      stz addr_logo_drawn
      lda.w 0x2
      sta addr_curs_x
      sta addr_curs_y
      lda.w wait_time
      sta addr_draw_wait
      plp
    end

    def_sub :update do
      php

      rep 0x30

      lda addr_draw_wait
      bne _(:exit)

      lda.w wait_time
      sta addr_draw_wait

      jsr __(:render_logo)
      jsr ___(:game, :joy)
      jsr __(:render_text)

    label _(:exit)

      dec.a addr_draw_wait

      plp
    end

    def_sub :render_logo do
      php
      phx

      lda addr_logo_drawn
      bne _(:exit)

      inc
      sta addr_logo_drawn
      stz addr_logo_row

    label _(:next_row)
      ldx.w 0

    label _(:next_col)
      lda addr_logo_row
      5.times { asl }
      clc
      adc.w logo_base
      sta addr_tmp1
      txa
    
      clc
      adc.a addr_tmp1
      sta rVMADDL

      lda addr_logo_row
      4.times { asl }
      clc
      adc.w 0x24A0
      sta addr_tmp1

      txa
      clc
      adc.a addr_tmp1
      sta rVMDATAL

      inx
      cpx.w 0x8
      bcc _(:next_col)

      lda addr_logo_row
      inc
      cmp.w 0x07
      bcs _(:exit)
      sta addr_logo_row
      bra _(:next_row)

    label _(:exit)
      plx
      plp
    end

    def_sub :render_text do
      php
      phx

      stz addr_tmp1
      lda addr_curs_y
      5.times { asl }
      clc
      adc.a addr_curs_x
      clc
      adc.w vram_base
      sta rVMADDL

      lda.w 0x2090
      sta rVMDATAL

      lda addr_text_drawn
      anda.w 0xFF
      bne _(:exit)

      lda addr_pos
      tax
      inc.a addr_pos
      clc
      adc.w text_base
      sta rVMADDL

      lda.ax __(:hello_str)
      anda.w 0xFF
      bne _(:draw_char)
      lda.w 0xFF
      sta addr_text_drawn
      bra _(:exit)

    label _(:draw_char)
      clc
      adc.w 0x2000
      sta rVMDATAL

    label _(:exit)
      plx
      plp
    end

    def_data :hello_str do
      data "\x90 ~hello, sparkles!~ \x90\x0"
    end
  end
end