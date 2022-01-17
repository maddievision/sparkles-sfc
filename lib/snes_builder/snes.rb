module SnesBuilder
  module Snes
    Registers = {
      rINIDISP:          0x2100,   # Screen Display Register   single   write   any time
      rOBSEL:            0x2101,   # Object Size and Character Size Register   single   write   f-blank, v-blank
      rOAMADDL:          0x2102,   # OAM Address Registers (Low)   single   write   f-blank, v-blank
      rOAMADDH:          0x2103,   # OAM Address Registers (High)   single   write   f-blank, v-blank
      rOAMDATA:          0x2104,   # OAM Data Write Register   single   write   f-blank, v-blank
      rBGMODE:           0x2105,   # BG Mode and Character Size Register   single   write   f-blank, v-blank, h-blank
      rMOSAIC:           0x2106,   # Mosaic Register   single   write   f-blank, v-blank, h-blank
      rBG1SC:            0x2107,   # BG Tilemap Address Registers (BG1)   single   write   f-blank, v-blank
      rBG2SC:            0x2108,   # BG Tilemap Address Registers (BG2)   single   write   f-blank, v-blank
      rBG3SC:            0x2109,   # BG Tilemap Address Registers (BG3)   single   write   f-blank, v-blank
      rBG4SC:            0x210A,   # BG Tilemap Address Registers (BG4)   single   write   f-blank, v-blank
      rBG12NBA:          0x210B,   # BG Character Address Registers (BG1&2)   single   write   f-blank, v-blank
      rBG34NBA:          0x210C,   # BG Character Address Registers (BG3&4)   single   write   f-blank, v-blank
      rBG1HOFS:          0x210D,   # BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
      rBG1VOFS:          0x210E,   # BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
      rBG2HOFS:          0x210F,   # BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
      rBG2VOFS:          0x2110,   # BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
      rBG3HOFS:          0x2111,   # BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
      rBG3VOFS:          0x2112,   # BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
      rBG4HOFS:          0x2113,   # BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank
      rBG4VOFS:          0x2114,   # BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank
      rVMAIN:            0x2115,   # Video Port Control Register   single   write   f-blank, v-blank
      rVMADDL:           0x2116,   # VRAM Address Registers (Low)   single   write   f-blank, v-blank
      rVMADDH:           0x2117,   # VRAM Address Registers (High)   single   write   f-blank, v-blank
      rVMDATAL:          0x2118,   # VRAM Data Write Registers (Low)   single   write   f-blank, v-blank
      rVMDATAH:          0x2119,   # VRAM Data Write Registers (High)   single   write   f-blank, v-blank
      rM7SEL:            0x211A,   # Mode 7 Settings Register   single   write   f-blank, v-blank
      rM7A:              0x211B,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rM7B:              0x211C,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rM7C:              0x211D,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rM7D:              0x211E,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rM7X:              0x211F,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rM7Y:              0x2120,   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
      rCGADD:            0x2121,   # CGRAM Address Register   single   write   f-blank, v-blank, h-blank
      rCGDATA:           0x2122,   # CGRAM Data Write Register   dual   write   f-blank, v-blank, h-blank
      rW12SEL:           0x2123,   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
      rW34SEL:           0x2124,   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
      rWOBJSEL:          0x2125,   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
      rWH0:              0x2126,   # Window Position Registers (WH0)   single   write   f-blank, v-blank, h-blank
      rWH1:              0x2127,   # Window Position Registers (WH1)   single   write   f-blank, v-blank, h-blank
      rWH2:              0x2128,   # Window Position Registers (WH2)   single   write   f-blank, v-blank, h-blank
      rWH3:              0x2129,   # Window Position Registers (WH3)   single   write   f-blank, v-blank, h-blank
      rWBGLOG:           0x212A,   # Window Mask Logic registers (BG)   single   write   f-blank, v-blank, h-blank
      rWOBJLOG:          0x212B,   # Window Mask Logic registers (OBJ)   single   write   f-blank, v-blank, h-blank
      rTM:               0x212C,   # Screen Destination Registers   single   write   f-blank, v-blank, h-blank
      rTS:               0x212D,   # Screen Destination Registers   single   write   f-blank, v-blank, h-blank
      rTMW:              0x212E,   # Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank
      rTSW:              0x212F,   # Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank
      rCGWSEL:           0x2130,   # Color Math Registers   single   write   f-blank, v-blank, h-blank
      rCGADSUB:          0x2131,   # Color Math Registers   single   write   f-blank, v-blank, h-blank
      rCOLDATA:          0x2132,   # Color Math Registers   single   write   f-blank, v-blank, h-blank
      rSETINI:           0x2133,   # Screen Mode Select Register   single   write   f-blank, v-blank, h-blank
      rMPYL:             0x2134,   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
      rMPYM:             0x2135,   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
      rMPYH:             0x2136,   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
      rSLHV:             0x2137,   # Software Latch Register   single      any time
      rOAMDATAREAD:      0x2138,   # OAM Data Read Register   dual   read   f-blank, v-blank
      rVMDATALREAD:      0x2139,   # VRAM Data Read Register (Low)   single   read   f-blank, v-blank
      rVMDATAHREAD:      0x213A,   # VRAM Data Read Register (High)   single   read   f-blank, v-blank
      rCGDATAREAD:       0x213B,   # CGRAM Data Read Register   dual   read   f-blank, v-blank
      rOPHCT:            0x213C,   # Scanline Location Registers (Horizontal)   dual   read   any time
      rOPVCT:            0x213D,   # Scanline Location Registers (Vertical)   dual   read   any time
      rSTAT77:           0x213E,   # PPU Status Register   single   read   any time
      rSTAT78:           0x213F,   # PPU Status Register   single   read   any time
      rAPUIO0:           0x2140,   # APU IO Registers   single   both   any time
      rAPUIO1:           0x2141,   # APU IO Registers   single   both   any time
      rAPUIO2:           0x2142,   # APU IO Registers   single   both   any time
      rAPUIO3:           0x2143,   # APU IO Registers   single   both   any time
      rWMDATA:           0x2180,   # WRAM Data Register   single   both   any time
      rWMADDL:           0x2181,   # WRAM Address Registers   single   write   any time
      rWMADDM:           0x2182,   # WRAM Address Registers   single   write   any time
      rWMADDH:           0x2183,   # WRAM Address Registers   single   write   any time

      # Old Style Joypad Registers
      rJOYSER0:          0x4016,   # Old Style Joypad Registers   single (write)   read/write   any time that is not auto-joypad
      rJOYSER1:          0x4017,   # Old Style Joypad Registers   many (read)   read   any time that is not auto-joypad

      # Internal CPU Registers
      rNMITIMEN:         0x4200,   # Interrupt Enable Register   single   write   any time
      rWRIO:             0x4201,   # IO Port Write Register   single   write   any time
      rWRMPYA:           0x4202,   # Multiplicand Registers   single   write   any time
      rWRMPYB:           0x4203,   # Multiplicand Registers   single   write   any time
      rWRDIVL:           0x4204,   # Divisor & Dividend Registers   single   write   any time
      rWRDIVH:           0x4205,   # Divisor & Dividend Registers   single   write   any time
      rWRDIVB:           0x4206,   # Divisor & Dividend Registers   single   write   any time
      rHTIMEL:           0x4207,   # IRQ Timer Registers (Horizontal - Low)   single   write   any time
      rHTIMEH:           0x4208,   # IRQ Timer Registers (Horizontal - High)   single   write   any time
      rVTIMEL:           0x4209,   # IRQ Timer Registers (Vertical - Low)   single   write   any time
      rVTIMEH:           0x420A,   # IRQ Timer Registers (Vertical - High)   single   write   any time
      rMDMAEN:           0x420B,   # DMA Enable Register   single   write   any time
      rHDMAEN:           0x420C,   # HDMA Enable Register   single   write   any time
      rMEMSEL:           0x420D,   # ROM Speed Register   single   write   any time
      rRDNMI:            0x4210,   # Interrupt Flag Registers   single   read   any time
      rTIMEUP:           0x4211,   # Interrupt Flag Registers   single   read   any time
      rHVBJOY:           0x4212,   # PPU Status Register   single   read   any time
      rRDIO:             0x4213,   # IO Port Read Register   single   read   any time
      rRDDIVL:           0x4214,   # Multiplication Or Divide Result Registers (Low)   single   read   any time
      rRDDIVH:           0x4215,   # Multiplication Or Divide Result Registers (High)   single   read   any time
      rRDMPYL:           0x4216,   # Multiplication Or Divide Result Registers (Low)   single   read   any time
      rRDMPYH:           0x4217,   # Multiplication Or Divide Result Registers (High)   single   read   any time
      rJOY1L:            0x4218,   # Controller Port Data Registers (Pad 1 - Low)   single   read   any time that is not auto-joypad
      rJOY1H:            0x4219,   # Controller Port Data Registers (Pad 1 - High)   single   read   any time that is not auto-joypad
      rJOY2L:            0x421A,   # Controller Port Data Registers (Pad 2 - Low)   single   read   any time that is not auto-joypad
      rJOY2H:            0x421B,   # Controller Port Data Registers (Pad 2 - High)   single   read   any time that is not auto-joypad
      rJOY3L:            0x421C,   # Controller Port Data Registers (Pad 3 - Low)   single   read   any time that is not auto-joypad
      rJOY3H:            0x421D,   # Controller Port Data Registers (Pad 3 - High)   single   read   any time that is not auto-joypad
      rJOY4L:            0x421E,   # Controller Port Data Registers (Pad 4 - Low)   single   read   any time that is not auto-joypad
      rJOY4H:            0x421F,   # Controller Port Data Registers (Pad 4 - High)   single   read   any time that is not auto-joypad

      # DMA/HDMA Registers
      rDMAPx:            0x4300,   # (H)DMA Control Register
      rBBADx:            0x4301,   # (H)DMA Destination Register
      rA1TxL:            0x4302,   # (H)DMA Source Address Registers
      rA1TxH:            0x4303,   # (H)DMA Source Address Registers
      rA1Bx:             0x4304,   # (H)DMA Source Address Registers
      rDASxL:            0x4305,   # (H)DMA Size Registers (Low)
      rDASxH:            0x4306,   # (H)DMA Size Registers (High)
      rDASBx:            0x4307,   # HDMA Indirect Address Registers
      rA2AxL:            0x4308,   # HDMA Mid Frame Table Address Registers (Low)
      rA2AxH:            0x4309,   # HDMA Mid Frame Table Address Registers (High)
      rNTLRx:            0x430A,   # HDMA Line Counter Register
    }
  end
end