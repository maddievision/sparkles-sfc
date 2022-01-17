require './lib/snes_builder'

module Sparkles
  class Snes < SnesBuilder::AssemblyModule

    equate :addr_rom_name, 0xFFC0
    equate :addr_rom_info, 0xFFD5
    equate :addr_vectors_native, 0xFFE0
    equate :addr_vectors_emulation, 0xFFF0

    equate :reg_INIDISP,          0x2100   # Screen Display Register   single   write   any time
    equate :reg_OBSEL,            0x2101   # Object Size and Character Size Register   single   write   f-blank, v-blank
    equate :reg_OAMADDL,          0x2102   # OAM Address Registers (Low)   single   write   f-blank, v-blank
    equate :reg_OAMADDH,          0x2103   # OAM Address Registers (High)   single   write   f-blank, v-blank
    equate :reg_OAMDATA,          0x2104   # OAM Data Write Register   single   write   f-blank, v-blank
    equate :reg_BGMODE,           0x2105   # BG Mode and Character Size Register   single   write   f-blank, v-blank, h-blank
    equate :reg_MOSAIC,           0x2106   # Mosaic Register   single   write   f-blank, v-blank, h-blank
    equate :reg_BG1SC,            0x2107   # BG Tilemap Address Registers (BG1)   single   write   f-blank, v-blank
    equate :reg_BG2SC,            0x2108   # BG Tilemap Address Registers (BG2)   single   write   f-blank, v-blank
    equate :reg_BG3SC,            0x2109   # BG Tilemap Address Registers (BG3)   single   write   f-blank, v-blank
    equate :reg_BG4SC,            0x210A   # BG Tilemap Address Registers (BG4)   single   write   f-blank, v-blank
    equate :reg_BG12NBA,          0x210B   # BG Character Address Registers (BG1&2)   single   write   f-blank, v-blank
    equate :reg_BG34NBA,          0x210C   # BG Character Address Registers (BG3&4)   single   write   f-blank, v-blank
    equate :reg_BG1HOFS,          0x210D   # BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG1VOFS,          0x210E   # BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG2HOFS,          0x210F   # BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG2VOFS,          0x2110   # BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG3HOFS,          0x2111   # BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG3VOFS,          0x2112   # BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG4HOFS,          0x2113   # BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank
    equate :reg_BG4VOFS,          0x2114   # BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank
    equate :reg_VMAIN,            0x2115   # Video Port Control Register   single   write   f-blank, v-blank
    equate :reg_VMADDL,           0x2116   # VRAM Address Registers (Low)   single   write   f-blank, v-blank
    equate :reg_VMADDH,           0x2117   # VRAM Address Registers (High)   single   write   f-blank, v-blank
    equate :reg_VMDATAL,          0x2118   # VRAM Data Write Registers (Low)   single   write   f-blank, v-blank
    equate :reg_VMDATAH,          0x2119   # VRAM Data Write Registers (High)   single   write   f-blank, v-blank
    equate :reg_M7SEL,            0x211A   # Mode 7 Settings Register   single   write   f-blank, v-blank
    equate :reg_M7A,              0x211B   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_M7B,              0x211C   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_M7C,              0x211D   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_M7D,              0x211E   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_M7X,              0x211F   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_M7Y,              0x2120   # Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
    equate :reg_CGADD,            0x2121   # CGRAM Address Register   single   write   f-blank, v-blank, h-blank
    equate :reg_CGDATA,           0x2122   # CGRAM Data Write Register   dual   write   f-blank, v-blank, h-blank
    equate :reg_W12SEL,           0x2123   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_W34SEL,           0x2124   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_WOBJSEL,          0x2125   # Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_WH0,              0x2126   # Window Position Registers (WH0)   single   write   f-blank, v-blank, h-blank
    equate :reg_WH1,              0x2127   # Window Position Registers (WH1)   single   write   f-blank, v-blank, h-blank
    equate :reg_WH2,              0x2128   # Window Position Registers (WH2)   single   write   f-blank, v-blank, h-blank
    equate :reg_WH3,              0x2129   # Window Position Registers (WH3)   single   write   f-blank, v-blank, h-blank
    equate :reg_WBGLOG,           0x212A   # Window Mask Logic registers (BG)   single   write   f-blank, v-blank, h-blank
    equate :reg_WOBJLOG,          0x212B   # Window Mask Logic registers (OBJ)   single   write   f-blank, v-blank, h-blank
    equate :reg_TM,               0x212C   # Screen Destination Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_TS,               0x212D   # Screen Destination Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_TMW,              0x212E   # Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_TSW,              0x212F   # Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_CGWSEL,           0x2130   # Color Math Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_CGADSUB,          0x2131   # Color Math Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_COLDATA,          0x2132   # Color Math Registers   single   write   f-blank, v-blank, h-blank
    equate :reg_SETINI,           0x2133   # Screen Mode Select Register   single   write   f-blank, v-blank, h-blank
    equate :reg_MPYL,             0x2134   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
    equate :reg_MPYM,             0x2135   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
    equate :reg_MPYH,             0x2136   # Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
    equate :reg_SLHV,             0x2137   # Software Latch Register   single      any time
    equate :reg_OAMDATAREAD,      0x2138   # OAM Data Read Register   dual   read   f-blank, v-blank
    equate :reg_VMDATALREAD,      0x2139   # VRAM Data Read Register (Low)   single   read   f-blank, v-blank
    equate :reg_VMDATAHREAD,      0x213A   # VRAM Data Read Register (High)   single   read   f-blank, v-blank
    equate :reg_CGDATAREAD,       0x213B   # CGRAM Data Read Register   dual   read   f-blank, v-blank
    equate :reg_OPHCT,            0x213C   # Scanline Location Registers (Horizontal)   dual   read   any time
    equate :reg_OPVCT,            0x213D   # Scanline Location Registers (Vertical)   dual   read   any time
    equate :reg_STAT77,           0x213E   # PPU Status Register   single   read   any time
    equate :reg_STAT78,           0x213F   # PPU Status Register   single   read   any time
    equate :reg_APUIO0,           0x2140   # APU IO Registers   single   both   any time
    equate :reg_APUIO1,           0x2141   # APU IO Registers   single   both   any time
    equate :reg_APUIO2,           0x2142   # APU IO Registers   single   both   any time
    equate :reg_APUIO3,           0x2143   # APU IO Registers   single   both   any time
    equate :reg_WMDATA,           0x2180   # WRAM Data Register   single   both   any time
    equate :reg_WMADDL,           0x2181   # WRAM Address Registers   single   write   any time
    equate :reg_WMADDM,           0x2182   # WRAM Address Registers   single   write   any time
    equate :reg_WMADDH,           0x2183   # WRAM Address Registers   single   write   any time

    # Old Style Joypad Registers
    equate :reg_JOYSER0,          0x4016   # Old Style Joypad Registers   single (write)   read/write   any time that is not auto-joypad
    equate :reg_JOYSER1,          0x4017   # Old Style Joypad Registers   many (read)   read   any time that is not auto-joypad

    # Internal CPU Registers
    equate :reg_NMITIMEN,         0x4200   # Interrupt Enable Register   single   write   any time
    equate :reg_WRIO,             0x4201   # IO Port Write Register   single   write   any time
    equate :reg_WRMPYA,           0x4202   # Multiplicand Registers   single   write   any time
    equate :reg_WRMPYB,           0x4203   # Multiplicand Registers   single   write   any time
    equate :reg_WRDIVL,           0x4204   # Divisor & Dividend Registers   single   write   any time
    equate :reg_WRDIVH,           0x4205   # Divisor & Dividend Registers   single   write   any time
    equate :reg_WRDIVB,           0x4206   # Divisor & Dividend Registers   single   write   any time
    equate :reg_HTIMEL,           0x4207   # IRQ Timer Registers (Horizontal - Low)   single   write   any time
    equate :reg_HTIMEH,           0x4208   # IRQ Timer Registers (Horizontal - High)   single   write   any time
    equate :reg_VTIMEL,           0x4209   # IRQ Timer Registers (Vertical - Low)   single   write   any time
    equate :reg_VTIMEH,           0x420A   # IRQ Timer Registers (Vertical - High)   single   write   any time
    equate :reg_MDMAEN,           0x420B   # DMA Enable Register   single   write   any time
    equate :reg_HDMAEN,           0x420C   # HDMA Enable Register   single   write   any time
    equate :reg_MEMSEL,           0x420D   # ROM Speed Register   single   write   any time
    equate :reg_RDNMI,            0x4210   # Interrupt Flag Registers   single   read   any time
    equate :reg_TIMEUP,           0x4211   # Interrupt Flag Registers   single   read   any time
    equate :reg_HVBJOY,           0x4212   # PPU Status Register   single   read   any time
    equate :reg_RDIO,             0x4213   # IO Port Read Register   single   read   any time
    equate :reg_RDDIVL,           0x4214   # Multiplication Or Divide Result Registers (Low)   single   read   any time
    equate :reg_RDDIVH,           0x4215   # Multiplication Or Divide Result Registers (High)   single   read   any time
    equate :reg_RDMPYL,           0x4216   # Multiplication Or Divide Result Registers (Low)   single   read   any time
    equate :reg_RDMPYH,           0x4217   # Multiplication Or Divide Result Registers (High)   single   read   any time
    equate :reg_JOY1L,            0x4218   # Controller Port Data Registers (Pad 1 - Low)   single   read   any time that is not auto-joypad
    equate :reg_JOY1H,            0x4219   # Controller Port Data Registers (Pad 1 - High)   single   read   any time that is not auto-joypad
    equate :reg_JOY2L,            0x421A   # Controller Port Data Registers (Pad 2 - Low)   single   read   any time that is not auto-joypad
    equate :reg_JOY2H,            0x421B   # Controller Port Data Registers (Pad 2 - High)   single   read   any time that is not auto-joypad
    equate :reg_JOY3L,            0x421C   # Controller Port Data Registers (Pad 3 - Low)   single   read   any time that is not auto-joypad
    equate :reg_JOY3H,            0x421D   # Controller Port Data Registers (Pad 3 - High)   single   read   any time that is not auto-joypad
    equate :reg_JOY4L,            0x421E   # Controller Port Data Registers (Pad 4 - Low)   single   read   any time that is not auto-joypad
    equate :reg_JOY4H,            0x421F   # Controller Port Data Registers (Pad 4 - High)   single   read   any time that is not auto-joypad

    # DMA/HDMA Registers
    equate :reg_DMAPx,            0x4300   # (H)DMA Control Register
    equate :reg_BBADx,            0x4301   # (H)DMA Destination Register
    equate :reg_A1TxL,            0x4302   # (H)DMA Source Address Registers
    equate :reg_A1TxH,            0x4303   # (H)DMA Source Address Registers
    equate :reg_A1Bx,             0x4304   # (H)DMA Source Address Registers
    equate :reg_DASxL,            0x4305   # (H)DMA Size Registers (Low)
    equate :reg_DASxH,            0x4306   # (H)DMA Size Registers (High)
    equate :reg_DASBx,            0x4307   # HDMA Indirect Address Registers
    equate :reg_A2AxL,            0x4308   # HDMA Mid Frame Table Address Registers (Low)
    equate :reg_A2AxH,            0x4309   # HDMA Mid Frame Table Address Registers (High)
    equate :reg_NTLRx,            0x430A   # HDMA Line Counter Register
  end
end