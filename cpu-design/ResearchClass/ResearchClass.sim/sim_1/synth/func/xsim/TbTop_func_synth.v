// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Sat Jul  6 03:42:11 2024
// Host        : laptop-mach running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/shuij/Documents/Projects/CpuDesign/ResearchClass/ResearchClass.sim/sim_1/synth/func/xsim/TbTop_func_synth.v
// Design      : SocTop
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module SocTop
   (resetn,
    clk,
    led,
    led_rg0,
    led_rg1,
    num_csn,
    num_a_g);
  input resetn;
  input clk;
  output [15:0]led;
  output [1:0]led_rg0;
  output [1:0]led_rg1;
  output [7:0]num_csn;
  output [6:0]num_a_g;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [15:0]led;
  wire [4:0]led_OBUF;
  wire [1:0]led_rg0;
  wire [1:0]led_rg1;
  wire [6:0]num_a_g;
  wire [7:0]num_csn;
  wire [0:0]r_led;
  wire resetn;
  wire resetn_IBUF;

  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  OBUF \led_OBUF[10]_inst 
       (.I(1'b0),
        .O(led[10]));
  OBUF \led_OBUF[11]_inst 
       (.I(1'b0),
        .O(led[11]));
  OBUF \led_OBUF[12]_inst 
       (.I(led_OBUF[4]),
        .O(led[12]));
  OBUF \led_OBUF[13]_inst 
       (.I(led_OBUF[4]),
        .O(led[13]));
  OBUF \led_OBUF[14]_inst 
       (.I(led_OBUF[4]),
        .O(led[14]));
  OBUF \led_OBUF[15]_inst 
       (.I(led_OBUF[4]),
        .O(led[15]));
  OBUF \led_OBUF[1]_inst 
       (.I(1'b0),
        .O(led[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(1'b0),
        .O(led[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(1'b0),
        .O(led[3]));
  OBUF \led_OBUF[4]_inst 
       (.I(led_OBUF[4]),
        .O(led[4]));
  OBUF \led_OBUF[5]_inst 
       (.I(led_OBUF[4]),
        .O(led[5]));
  OBUF \led_OBUF[6]_inst 
       (.I(led_OBUF[4]),
        .O(led[6]));
  OBUF \led_OBUF[7]_inst 
       (.I(led_OBUF[4]),
        .O(led[7]));
  OBUF \led_OBUF[8]_inst 
       (.I(1'b0),
        .O(led[8]));
  OBUF \led_OBUF[9]_inst 
       (.I(1'b0),
        .O(led[9]));
  OBUF \led_rg0_OBUF[0]_inst 
       (.I(1'b0),
        .O(led_rg0[0]));
  OBUF \led_rg0_OBUF[1]_inst 
       (.I(1'b1),
        .O(led_rg0[1]));
  OBUF \led_rg1_OBUF[0]_inst 
       (.I(1'b1),
        .O(led_rg1[0]));
  OBUF \led_rg1_OBUF[1]_inst 
       (.I(1'b0),
        .O(led_rg1[1]));
  OBUF \num_a_g_OBUF[0]_inst 
       (.I(1'b0),
        .O(num_a_g[0]));
  OBUF \num_a_g_OBUF[1]_inst 
       (.I(1'b0),
        .O(num_a_g[1]));
  OBUF \num_a_g_OBUF[2]_inst 
       (.I(1'b0),
        .O(num_a_g[2]));
  OBUF \num_a_g_OBUF[3]_inst 
       (.I(1'b0),
        .O(num_a_g[3]));
  OBUF \num_a_g_OBUF[4]_inst 
       (.I(1'b0),
        .O(num_a_g[4]));
  OBUF \num_a_g_OBUF[5]_inst 
       (.I(1'b0),
        .O(num_a_g[5]));
  OBUF \num_a_g_OBUF[6]_inst 
       (.I(1'b0),
        .O(num_a_g[6]));
  OBUF \num_csn_OBUF[0]_inst 
       (.I(1'b1),
        .O(num_csn[0]));
  OBUF \num_csn_OBUF[1]_inst 
       (.I(1'b1),
        .O(num_csn[1]));
  OBUF \num_csn_OBUF[2]_inst 
       (.I(1'b1),
        .O(num_csn[2]));
  OBUF \num_csn_OBUF[3]_inst 
       (.I(1'b1),
        .O(num_csn[3]));
  OBUF \num_csn_OBUF[4]_inst 
       (.I(1'b1),
        .O(num_csn[4]));
  OBUF \num_csn_OBUF[5]_inst 
       (.I(1'b1),
        .O(num_csn[5]));
  OBUF \num_csn_OBUF[6]_inst 
       (.I(1'b1),
        .O(num_csn[6]));
  OBUF \num_csn_OBUF[7]_inst 
       (.I(1'b1),
        .O(num_csn[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \r_led[15]_i_1 
       (.I0(resetn_IBUF),
        .O(r_led));
  FDRE #(
    .INIT(1'b0)) 
    \r_led_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(r_led),
        .Q(led_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_led_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(1'b1),
        .Q(led_OBUF[4]),
        .R(r_led));
  IBUF resetn_IBUF_inst
       (.I(resetn),
        .O(resetn_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
