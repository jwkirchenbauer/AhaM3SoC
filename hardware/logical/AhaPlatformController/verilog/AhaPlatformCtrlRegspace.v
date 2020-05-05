//-----------------------------------------------------------------------------
// Verilog 2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------
// Purpose: Platform Controller Register Space
//------------------------------------------------------------------------------
//
// Author   : Gedeon Nyengele
// Date     : May 4, 2020
//------------------------------------------------------------------------------
module AhaPlatformCtrlRegspace (
  // AHB Interface
  input   wire                HCLK,
  input   wire                HRESETn,

  input   wire                HSEL,
  input   wire [31:0]         HADDR,
  input   wire  [1:0]         HTRANS,
  input   wire                HWRITE,
  input   wire  [2:0]         HSIZE,
  input   wire  [2:0]         HBURST,
  input   wire  [3:0]         HPROT,
  input   wire  [3:0]         HMASTER,
  input   wire [31:0]         HWDATA,
  input   wire                HMASTLOCK,
  input   wire                HREADYMUX,

  output  wire [31:0]         HRDATA,
  output  wire                HREADYOUT,
  output  wire [1:0]          HRESP,

  // Register Signals
  input   wire                H2L_RESET_ACK_REG_DMA0_w,
  input   wire                H2L_RESET_ACK_REG_DMA1_w,
  input   wire                H2L_RESET_ACK_REG_TLX_FWD_w,
  input   wire                H2L_RESET_ACK_REG_TLX_REV_w,
  input   wire                H2L_RESET_ACK_REG_GGRA_w,
  input   wire                H2L_RESET_ACK_REG_NIC_w,
  input   wire                H2L_RESET_ACK_REG_TIMER0_w,
  input   wire                H2L_RESET_ACK_REG_TIMER1_w,
  input   wire                H2L_RESET_ACK_REG_UART0_w,
  input   wire                H2L_RESET_ACK_REG_UART1_w,
  input   wire                H2L_RESET_ACK_REG_WDOG_w,

  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP0_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP1_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP2_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP3_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP4_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP5_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP6_r,
  output  wire [2:0]          L2H_PAD_STRENGTH_CTRL_REG_GRP7_r,
  output  wire                L2H_SYS_CLK_SELECT_REG_SELECT_SWMOD_o,
  output  wire [2:0]          L2H_SYS_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_DMA0_PCLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_DMA1_PCLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_TLX_FWD_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_CGRA_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_TIMER0_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_TIMER1_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_UART0_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_UART1_CLK_SELECT_REG_SELECT_r,
  output  wire [2:0]          L2H_WDOG_CLK_SELECT_REG_SELECT_r,
  output  wire                L2H_CLK_GATE_EN_REG_CPU_r,
  output  wire                L2H_CLK_GATE_EN_REG_DAP_r,
  output  wire                L2H_CLK_GATE_EN_REG_DMA0_r,
  output  wire                L2H_CLK_GATE_EN_REG_DMA1_r,
  output  wire                L2H_CLK_GATE_EN_REG_SRAMX_r,
  output  wire                L2H_CLK_GATE_EN_REG_TLX_FWD_r,
  output  wire                L2H_CLK_GATE_EN_REG_GGRA_r,
  output  wire                L2H_CLK_GATE_EN_REG_NIC_r,
  output  wire                L2H_CLK_GATE_EN_REG_TIMER0_r,
  output  wire                L2H_CLK_GATE_EN_REG_TIMER1_r,
  output  wire                L2H_CLK_GATE_EN_REG_UART0_r,
  output  wire                L2H_CLK_GATE_EN_REG_UART1_r,
  output  wire                L2H_CLK_GATE_EN_REG_WDOG_r,
  output  wire                L2H_SYS_RESET_PROP_REG_DMA0_r,
  output  wire                L2H_SYS_RESET_PROP_REG_DMA1_r,
  output  wire                L2H_SYS_RESET_PROP_REG_SRAMX_r,
  output  wire                L2H_SYS_RESET_PROP_REG_TLX_FWD_r,
  output  wire                L2H_SYS_RESET_PROP_REG_GGRA_r,
  output  wire                L2H_SYS_RESET_PROP_REG_NIC_r,
  output  wire                L2H_SYS_RESET_PROP_REG_TIMER0_r,
  output  wire                L2H_SYS_RESET_PROP_REG_TIMER1_r,
  output  wire                L2H_SYS_RESET_PROP_REG_UART0_r,
  output  wire                L2H_SYS_RESET_PROP_REG_UART1_r,
  output  wire                L2H_SYS_RESET_PROP_REG_WDOG_r,
  output  wire                L2H_RESET_REQ_REG_DMA0_r,
  output  wire                L2H_RESET_REQ_REG_DMA1_r,
  output  wire                L2H_RESET_REQ_REG_TLX_FWD_r,
  output  wire                L2H_RESET_REQ_REG_TLX_REV_r,
  output  wire                L2H_RESET_REQ_REG_GGRA_r,
  output  wire                L2H_RESET_REQ_REG_NIC_r,
  output  wire                L2H_RESET_REQ_REG_TIMER0_r,
  output  wire                L2H_RESET_REQ_REG_TIMER1_r,
  output  wire                L2H_RESET_REQ_REG_UART0_r,
  output  wire                L2H_RESET_REQ_REG_UART1_r,
  output  wire                L2H_RESET_REQ_REG_WDOG_r,
  output  wire [23:0]         L2H_SYS_TICK_CONFIG_REG_CALIB_r,
  output  wire                L2H_SYS_TICK_CONFIG_REG_NOT_10_MS_r,
  output  wire                L2H_SYS_RESET_AGGR_REG_LOCKUP_RESET_EN_r,
  output  wire                L2H_SYS_RESET_AGGR_REG_WDOG_TIMEOUT_RESET_EN_r
);

//------------------------------------------------------------------------------
// Simple Register Access Interface Wires
//------------------------------------------------------------------------------
  wire  [11:0]            regif_addr;
  wire                    regif_read_en;
  wire                    regif_write_en;
  wire  [3:0]             regif_byte_strobe;
  wire  [31:0]            regif_wdata;
  wire  [31:0]            regif_rdata;

//------------------------------------------------------------------------------
// Convert AHB to Simple Reg Access Interface
//------------------------------------------------------------------------------
  wire unused   = (| HBURST )     |
                  (| HPROT )      |
                  (| HMASTER )    |
                  (| HMASTLOCK )  ;

  cmsdk_ahb_eg_slave_interface #(.ADDRWIDTH(12)) u_ahb_converter (
    .hclk                 (HCLK),
    .hresetn              (HRESETn),

    // AHB connection to master
    .hsels                (HSEL),
    .haddrs               (HADDR[11:0]),
    .htranss              (HTRANS),
    .hsizes               (HSIZE),
    .hwrites              (HWRITE),
    .hreadys              (HREADYMUX),
    .hwdatas              (HWDATA),

    .hreadyouts           (HREADYOUT),
    .hresps               (HRESP[0]),
    .hrdatas              (HRDATA),

    // Register interface
    .addr                 (regif_addr),
    .read_en              (regif_read_en),
    .write_en             (regif_write_en),
    .byte_strobe          (regif_byte_strobe),
    .wdata                (regif_wdata),
    .rdata                (regif_rdata)
  );

  assign HRESP[1] = 1'b0;

//------------------------------------------------------------------------------
// Register Space Integration
//------------------------------------------------------------------------------
  AhaPlatformCtrlAddrMap_pio u_addr_map (
    .clk                                            (HCLK),
    .reset                                          (~HRESETn),

    .h2l_RESET_ACK_REG_DMA0_w                       (H2L_RESET_ACK_REG_DMA0_w),
    .h2l_RESET_ACK_REG_DMA1_w                       (H2L_RESET_ACK_REG_DMA1_w),
    .h2l_RESET_ACK_REG_TLX_FWD_w                    (H2L_RESET_ACK_REG_TLX_FWD_w),
    .h2l_RESET_ACK_REG_TLX_REV_w                    (H2L_RESET_ACK_REG_TLX_REV_w),
    .h2l_RESET_ACK_REG_GGRA_w                       (H2L_RESET_ACK_REG_GGRA_w),
    .h2l_RESET_ACK_REG_NIC_w                        (H2L_RESET_ACK_REG_NIC_w),
    .h2l_RESET_ACK_REG_TIMER0_w                     (H2L_RESET_ACK_REG_TIMER0_w),
    .h2l_RESET_ACK_REG_TIMER1_w                     (H2L_RESET_ACK_REG_TIMER1_w),
    .h2l_RESET_ACK_REG_UART0_w                      (H2L_RESET_ACK_REG_UART0_w),
    .h2l_RESET_ACK_REG_UART1_w                      (H2L_RESET_ACK_REG_UART1_w),
    .h2l_RESET_ACK_REG_WDOG_w                       (H2L_RESET_ACK_REG_WDOG_w),
    .h2d_pio_dec_address                            (regif_addr[6:2]),
    .h2d_pio_dec_write_data                         (regif_wdata),
    .h2d_pio_dec_write_enable                       (regif_byte_strobe),
    .h2d_pio_dec_write                              (regif_write_en),
    .h2d_pio_dec_read                               (regif_read_en),

    .l2h_PAD_STRENGTH_CTRL_REG_GRP0_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP0_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP1_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP1_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP2_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP2_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP3_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP3_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP4_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP4_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP5_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP5_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP6_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP6_r),
    .l2h_PAD_STRENGTH_CTRL_REG_GRP7_r               (L2H_PAD_STRENGTH_CTRL_REG_GRP7_r),
    .l2h_SYS_CLK_SELECT_REG_SELECT_swmod_o          (L2H_SYS_CLK_SELECT_REG_SELECT_SWMOD_o),
    .l2h_SYS_CLK_SELECT_REG_SELECT_r                (L2H_SYS_CLK_SELECT_REG_SELECT_r),
    .l2h_DMA0_PCLK_SELECT_REG_SELECT_r              (L2H_DMA0_PCLK_SELECT_REG_SELECT_r),
    .l2h_DMA1_PCLK_SELECT_REG_SELECT_r              (L2H_DMA1_PCLK_SELECT_REG_SELECT_r),
    .l2h_TLX_FWD_CLK_SELECT_REG_SELECT_r            (L2H_TLX_FWD_CLK_SELECT_REG_SELECT_r),
    .l2h_CGRA_CLK_SELECT_REG_SELECT_r               (L2H_CGRA_CLK_SELECT_REG_SELECT_r),
    .l2h_TIMER0_CLK_SELECT_REG_SELECT_r             (L2H_TIMER0_CLK_SELECT_REG_SELECT_r),
    .l2h_TIMER1_CLK_SELECT_REG_SELECT_r             (L2H_TIMER1_CLK_SELECT_REG_SELECT_r),
    .l2h_UART0_CLK_SELECT_REG_SELECT_r              (L2H_UART0_CLK_SELECT_REG_SELECT_r),
    .l2h_UART1_CLK_SELECT_REG_SELECT_r              (L2H_UART1_CLK_SELECT_REG_SELECT_r),
    .l2h_WDOG_CLK_SELECT_REG_SELECT_r               (L2H_WDOG_CLK_SELECT_REG_SELECT_r),
    .l2h_CLK_GATE_EN_REG_CPU_r                      (L2H_CLK_GATE_EN_REG_CPU_r),
    .l2h_CLK_GATE_EN_REG_DAP_r                      (L2H_CLK_GATE_EN_REG_DAP_r),
    .l2h_CLK_GATE_EN_REG_DMA0_r                     (L2H_CLK_GATE_EN_REG_DMA0_r),
    .l2h_CLK_GATE_EN_REG_DMA1_r                     (L2H_CLK_GATE_EN_REG_DMA1_r),
    .l2h_CLK_GATE_EN_REG_SRAMx_r                    (L2H_CLK_GATE_EN_REG_SRAMX_r),
    .l2h_CLK_GATE_EN_REG_TLX_FWD_r                  (L2H_CLK_GATE_EN_REG_TLX_FWD_r),
    .l2h_CLK_GATE_EN_REG_GGRA_r                     (L2H_CLK_GATE_EN_REG_GGRA_r),
    .l2h_CLK_GATE_EN_REG_NIC_r                      (L2H_CLK_GATE_EN_REG_NIC_r),
    .l2h_CLK_GATE_EN_REG_TIMER0_r                   (L2H_CLK_GATE_EN_REG_TIMER0_r),
    .l2h_CLK_GATE_EN_REG_TIMER1_r                   (L2H_CLK_GATE_EN_REG_TIMER1_r),
    .l2h_CLK_GATE_EN_REG_UART0_r                    (L2H_CLK_GATE_EN_REG_UART0_r),
    .l2h_CLK_GATE_EN_REG_UART1_r                    (L2H_CLK_GATE_EN_REG_UART1_r),
    .l2h_CLK_GATE_EN_REG_WDOG_r                     (L2H_CLK_GATE_EN_REG_WDOG_r),
    .l2h_SYS_RESET_PROP_REG_DMA0_r                  (L2H_SYS_RESET_PROP_REG_DMA0_r),
    .l2h_SYS_RESET_PROP_REG_DMA1_r                  (L2H_SYS_RESET_PROP_REG_DMA1_r),
    .l2h_SYS_RESET_PROP_REG_SRAMx_r                 (L2H_SYS_RESET_PROP_REG_SRAMX_r),
    .l2h_SYS_RESET_PROP_REG_TLX_FWD_r               (L2H_SYS_RESET_PROP_REG_TLX_FWD_r),
    .l2h_SYS_RESET_PROP_REG_GGRA_r                  (L2H_SYS_RESET_PROP_REG_GGRA_r),
    .l2h_SYS_RESET_PROP_REG_NIC_r                   (L2H_SYS_RESET_PROP_REG_NIC_r),
    .l2h_SYS_RESET_PROP_REG_TIMER0_r                (L2H_SYS_RESET_PROP_REG_TIMER0_r),
    .l2h_SYS_RESET_PROP_REG_TIMER1_r                (L2H_SYS_RESET_PROP_REG_TIMER1_r),
    .l2h_SYS_RESET_PROP_REG_UART0_r                 (L2H_SYS_RESET_PROP_REG_UART0_r),
    .l2h_SYS_RESET_PROP_REG_UART1_r                 (L2H_SYS_RESET_PROP_REG_UART1_r),
    .l2h_SYS_RESET_PROP_REG_WDOG_r                  (L2H_SYS_RESET_PROP_REG_WDOG_r),
    .l2h_RESET_REQ_REG_DMA0_r                       (L2H_RESET_REQ_REG_DMA0_r),
    .l2h_RESET_REQ_REG_DMA1_r                       (L2H_RESET_REQ_REG_DMA1_r),
    .l2h_RESET_REQ_REG_TLX_FWD_r                    (L2H_RESET_REQ_REG_TLX_FWD_r),
    .l2h_RESET_REQ_REG_TLX_REV_r                    (L2H_RESET_REQ_REG_TLX_REV_r),
    .l2h_RESET_REQ_REG_GGRA_r                       (L2H_RESET_REQ_REG_GGRA_r),
    .l2h_RESET_REQ_REG_NIC_r                        (L2H_RESET_REQ_REG_NIC_r),
    .l2h_RESET_REQ_REG_TIMER0_r                     (L2H_RESET_REQ_REG_TIMER0_r),
    .l2h_RESET_REQ_REG_TIMER1_r                     (L2H_RESET_REQ_REG_TIMER1_r),
    .l2h_RESET_REQ_REG_UART0_r                      (L2H_RESET_REQ_REG_UART0_r),
    .l2h_RESET_REQ_REG_UART1_r                      (L2H_RESET_REQ_REG_UART1_r),
    .l2h_RESET_REQ_REG_WDOG_r                       (L2H_RESET_REQ_REG_WDOG_r),
    .l2h_SYS_TICK_CONFIG_REG_CALIB_r                (L2H_SYS_TICK_CONFIG_REG_CALIB_r),
    .l2h_SYS_TICK_CONFIG_REG_NOT_10_MS_r            (L2H_SYS_TICK_CONFIG_REG_NOT_10_MS_r),
    .l2h_SYS_RESET_AGGR_REG_LOCKUP_RESET_EN_r       (L2H_SYS_RESET_AGGR_REG_LOCKUP_RESET_EN_r),
    .l2h_SYS_RESET_AGGR_REG_WDOG_TIMEOUT_RESET_EN_r (L2H_SYS_RESET_AGGR_REG_WDOG_TIMEOUT_RESET_EN_r),
    .d2h_dec_pio_read_data                          (regif_rdata),
    .d2h_dec_pio_ack                                (),
    .d2h_dec_pio_nack                               ()
  );



endmodule