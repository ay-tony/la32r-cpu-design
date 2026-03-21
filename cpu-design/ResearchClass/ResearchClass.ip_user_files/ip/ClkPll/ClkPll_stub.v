// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Mon Jul  8 06:40:38 2024
// Host        : laptop-mach running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/shuij/Documents/Projects/CpuDesign/ResearchClass/ResearchClass.gen/sources_1/ip/ClkPll/ClkPll_stub.v
// Design      : ClkPll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ClkPll(clk_out, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_in1" */
/* synthesis syn_force_seq_prim="clk_out" */;
  output clk_out /* synthesis syn_isclock = 1 */;
  input clk_in1;
endmodule
