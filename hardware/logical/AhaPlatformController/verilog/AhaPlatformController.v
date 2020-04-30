//-----------------------------------------------------------------------------
// Verilog 2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------
// Purpose: Platform Controller for AHA SoC
//------------------------------------------------------------------------------
//
// Author   : Gedeon Nyengele
// Date     : Apr 17, 2020
//------------------------------------------------------------------------------
module AhaPlatformController (
  // Master Clock and Reset
  input   wire            MASTER_CLK,         // Master Clock
  input   wire            PORESETn,           // Global PowerOn Reset
  input   wire            SOC_JTAG_TRSTn,     // SOC JTAG Reset
  input   wire            CGRA_JTAG_TRSTn,    // CGRA JTAG Reset

  // JTAG Clocks
  input   wire            SOC_JTAG_TCK,       // SOC JTAG Clock
  input   wire            CGRA_JTAG_TCK,      // CGRA JTAG Clock

  // TLX Reverse Clock
  input   wire            TLX_REV_CLK,

  // Generated Clocks
  output  wire            CPU_FCLK,
  output  wire            CPU_GCLK,
  output  wire            DAP_CLK,
  output  wire            SRAM_CLK,
  output  wire            TLX_CLK,
  output  wire            CGRA_CLK,
  output  wire            DMA0_CLK,
  output  wire            DMA1_CLK,
  output  wire            PERIPH_CLK,
  output  wire            TIMER0_CLK,
  output  wire            TIMER1_CLK,
  output  wire            UART0_CLK,
  output  wire            UART1_CLK,
  output  wire            WDOG_CLK,
  output  wire            NIC_CLK,

  // Synchronized resets
  output  wire            CPU_PORESETn,
  output  wire            CPU_SYSRESETn,
  output  wire            DAP_RESETn,
  output  wire            SOC_JTAG_RESETn,
  output  wire            SOC_JTAG_PORESETn,
  output  wire            CGRA_JTAG_RESETn,
  output  wire            SRAM_RESETn,
  output  wire            TLX_RESETn,
  output  wire            CGRA_RESETn,
  output  wire            DMA0_RESETn,
  output  wire            DMA1_RESETn,
  output  wire            PERIPH_RESETn,
  output  wire            TIMER0_RESETn,
  output  wire            TIMER1_RESETn,
  output  wire            UART0_RESETn,
  output  wire            UART1_RESETn,
  output  wire            WDOG_RESETn,
  output  wire            NIC_RESETn,
  output  wire            TLX_REV_RESETn,

  // Peripheral Clock Qualifiers
  output  wire            TIMER0_CLKEN,
  output  wire            TIMER1_CLKEN,
  output  wire            UART0_CLKEN,
  output  wire            UART1_CLKEN,
  output  wire            WDOG_CLKEN,
  output  wire            DMA0_CLKEN,
  output  wire            DMA1_CLKEN,

  // SysTick
  output  wire            CPU_CLK_CHANGED,
  output  wire            SYS_TICK_NOT_10MS_MULT,
  output  wire [23:0]     SYS_TICK_CALIB,

  // Control
  output  wire            DBGPWRUPACK,
  output  wire            DBGRSTACK,
  output  wire            DBGSYSPWRUPACK,
  output  wire            SLEEPHOLDREQn,
  output  wire            PMU_WIC_EN_REQ,
  input   wire            PMU_WIC_EN_ACK,
  input   wire            PMU_WAKEUP,
  input   wire            DBGPWRUPREQ,
  input   wire            DBGRSTREQ,
  input   wire            DBGSYSPWRUPREQ,
  input   wire            SLEEP,
  input   wire            SLEEPDEEP,
  input   wire            LOCKUP,
  input   wire            SYSRESETREQ,
  input   wire            SLEEPHOLDACKn,
  input   wire            WDOG_RESET_REQ,

  // Pad Strength Control
  output  wire [2:0]      OUT_PAD_DS_GRP0,
  output  wire [2:0]      OUT_PAD_DS_GRP1,
  output  wire [2:0]      OUT_PAD_DS_GRP2,
  output  wire [2:0]      OUT_PAD_DS_GRP3,
  output  wire [2:0]      OUT_PAD_DS_GRP4,
  output  wire [2:0]      OUT_PAD_DS_GRP5,
  output  wire [2:0]      OUT_PAD_DS_GRP6,
  output  wire [2:0]      OUT_PAD_DS_GRP7,

  // LoopBack
  output  wire            LOOP_BACK
);

  wire unused = PMU_WIC_EN_ACK | PMU_WAKEUP | SLEEP | SLEEPDEEP | LOCKUP |
    SLEEPHOLDACKn | WDOG_RESET_REQ;

  // ===== PORESETn
  // CPU PORESETn
  reg cpu_poreset_n_q;
  reg cpu_poreset_n_qq;
  always @(posedge MASTER_CLK or negedge PORESETn) begin
    if(~PORESETn) begin
      cpu_poreset_n_q   <= 1'b0;
      cpu_poreset_n_qq  <= 1'b0;
    end else begin
      cpu_poreset_n_q   <= 1'b1;
      cpu_poreset_n_qq  <= cpu_poreset_n_q;
    end
  end
  assign CPU_PORESETn  = cpu_poreset_n_qq;

  // SOC JTAG PORESETn
  reg soc_jtag_poreset_n_q;
  reg soc_jtag_poreset_n_qq;
  always @(posedge SOC_JTAG_TCK or negedge PORESETn) begin
    if(~PORESETn) begin
      soc_jtag_poreset_n_q   <= 1'b0;
      soc_jtag_poreset_n_qq  <= 1'b0;
    end else begin
      soc_jtag_poreset_n_q   <= 1'b1;
      soc_jtag_poreset_n_qq  <= soc_jtag_poreset_n_q;
    end
  end
  assign SOC_JTAG_PORESETn  = soc_jtag_poreset_n_qq;

  // ===== SOC JTAG RESETn
  reg soc_jtag_trst_n_q;
  reg soc_jtag_trst_n_qq;
  always @(posedge SOC_JTAG_TCK or negedge SOC_JTAG_TRSTn) begin
    if(~SOC_JTAG_TRSTn) begin
      soc_jtag_trst_n_q   <= 1'b0;
      soc_jtag_trst_n_qq  <= 1'b0;
    end else begin
      soc_jtag_trst_n_q   <= 1'b1;
      soc_jtag_trst_n_qq  <= soc_jtag_trst_n_q;
    end
  end
  assign SOC_JTAG_RESETn  = soc_jtag_trst_n_qq;

  // ===== CGRA JTAG RESETn
  wire cgra_reset_n = PORESETn & CGRA_JTAG_TRSTn;
  reg cgra_jtag_trst_n_q;
  reg cgra_jtag_trst_n_qq;
  always @(posedge CGRA_JTAG_TCK or negedge cgra_reset_n) begin
    if(~cgra_reset_n) begin
      cgra_jtag_trst_n_q   <= 1'b0;
      cgra_jtag_trst_n_qq  <= 1'b0;
    end else begin
      cgra_jtag_trst_n_q   <= 1'b1;
      cgra_jtag_trst_n_qq  <= cgra_jtag_trst_n_q;
    end
  end
  assign CGRA_JTAG_RESETn  = cgra_jtag_trst_n_qq;

  // ===== CPU System Reset
  reg   int_cpu_sysresetn_q;
  reg   int_cpu_sysresetn_qq;
  wire  cpu_reset_n;
  always @ (posedge MASTER_CLK or negedge PORESETn) begin
    if(~PORESETn) begin
      int_cpu_sysresetn_q     <= 1'b0;
      int_cpu_sysresetn_qq    <= 1'b0;
    end else begin
      int_cpu_sysresetn_q     <= ~SYSRESETREQ;
      int_cpu_sysresetn_qq    <= int_cpu_sysresetn_q;
    end
  end
  assign cpu_reset_n = int_cpu_sysresetn_q & int_cpu_sysresetn_qq;
  assign CPU_SYSRESETn = cpu_reset_n;

  // ===== Debug Reset
  reg int_dbg_resetn_q;
  reg int_dbg_resetn_qq;
  always @ (posedge MASTER_CLK or negedge PORESETn) begin
    if(~PORESETn) begin
      int_dbg_resetn_q     <= 1'b0;
      int_dbg_resetn_qq    <= 1'b0;
    end else begin
      int_dbg_resetn_q     <= ~DBGRSTREQ;
      int_dbg_resetn_qq    <= int_dbg_resetn_q;
    end
  end
  assign DAP_RESETn = int_dbg_resetn_q & int_dbg_resetn_qq;

  // ===== TLX Reverse Channel Reset
  reg tlx_rev_reset_n_q;
  reg tlx_rev_reset_n_qq;
  always @(posedge TLX_REV_CLK or negedge PORESETn) begin
    if(~PORESETn) begin
      tlx_rev_reset_n_q   <= 1'b0;
      tlx_rev_reset_n_qq  <= 1'b0;
    end else begin
      tlx_rev_reset_n_q   <= 1'b1;
      tlx_rev_reset_n_qq  <= tlx_rev_reset_n_q;
    end
  end
  assign TLX_REV_RESETn  = tlx_rev_reset_n_qq;

  // Synchronized Reset Assignments
  assign SRAM_RESETn          = cpu_reset_n;
  assign TLX_RESETn           = cpu_reset_n;
  assign CGRA_RESETn          = cpu_reset_n;
  assign DMA0_RESETn          = cpu_reset_n;
  assign DMA1_RESETn          = cpu_reset_n;
  assign PERIPH_RESETn        = cpu_reset_n;
  assign TIMER0_RESETn        = cpu_reset_n;
  assign TIMER1_RESETn        = cpu_reset_n;
  assign UART0_RESETn         = cpu_reset_n;
  assign UART1_RESETn         = cpu_reset_n;
  assign WDOG_RESETn          = cpu_reset_n;
  assign NIC_RESETn           = cpu_reset_n;

  // Generated Clock Assignments
  assign CPU_FCLK             = MASTER_CLK;
  assign CPU_GCLK             = MASTER_CLK;
  assign DAP_CLK              = MASTER_CLK;
  assign SRAM_CLK             = MASTER_CLK;
  assign TLX_CLK              = MASTER_CLK;
  assign CGRA_CLK             = MASTER_CLK;
  assign DMA0_CLK             = MASTER_CLK;
  assign DMA1_CLK             = MASTER_CLK;
  assign PERIPH_CLK           = MASTER_CLK;
  assign TIMER0_CLK           = MASTER_CLK;
  assign TIMER1_CLK           = MASTER_CLK;
  assign UART0_CLK            = MASTER_CLK;
  assign UART1_CLK            = MASTER_CLK;
  assign WDOG_CLK             = MASTER_CLK;
  assign NIC_CLK              = MASTER_CLK;

  // Peripheral Clock Qualifiers
  assign TIMER0_CLKEN         = 1'b1;
  assign TIMER1_CLKEN         = 1'b1;
  assign UART0_CLKEN          = 1'b1;
  assign UART1_CLKEN          = 1'b1;
  assign WDOG_CLKEN           = 1'b1;
  assign DMA0_CLKEN           = 1'b1;
  assign DMA1_CLKEN           = 1'b1;

  // SysTick
  assign CPU_CLK_CHANGED        = 1'b0;
  assign SYS_TICK_NOT_10MS_MULT = 1'b0;
  assign SYS_TICK_CALIB         = 24'h98967F;

  // Control
  assign DBGPWRUPACK            = DBGPWRUPREQ;
  assign DBGRSTACK              = DBGRSTREQ;
  assign DBGSYSPWRUPACK         = DBGSYSPWRUPREQ;
  assign SLEEPHOLDREQn          = 1'b1;
  assign PMU_WIC_EN_REQ         = 1'b0;

  // Pad Strength Control
  assign OUT_PAD_DS_GRP0        = {3{1'b0}};
  assign OUT_PAD_DS_GRP1        = {3{1'b0}};
  assign OUT_PAD_DS_GRP2        = {3{1'b0}};
  assign OUT_PAD_DS_GRP3        = {3{1'b0}};
  assign OUT_PAD_DS_GRP4        = {3{1'b0}};
  assign OUT_PAD_DS_GRP5        = {3{1'b0}};
  assign OUT_PAD_DS_GRP6        = {3{1'b0}};
  assign OUT_PAD_DS_GRP7        = {3{1'b0}};

  // LoopBack
  assign LOOP_BACK              = MASTER_CLK;

endmodule