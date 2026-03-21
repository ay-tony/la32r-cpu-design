// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : RegFile.sv
//  Create  : 2024-7-1
// =============================================

module RegFile(
  // 时钟
  input  logic clk,
  // 两个读端口
  input  logic [ 4:0] r_addr1_i,
  output logic [31:0] r_data1_o,
  input  logic [ 4:0] r_addr2_i,
  output logic [31:0] r_data2_o,
  // 一个写端口
  input  logic        w_en_i,
  input  logic [ 4:0] w_addr_i,
  input  logic [31:0] w_data_i
);

  logic [31:0] rf[31:0];

  always_ff @(posedge clk) begin
    if (w_en_i) rf[w_addr_i] <= w_data_i;
  end

  always_comb begin
    r_data1_o = (r_addr1_i == 5'b0) ? 32'b0 : rf[r_addr1_i];
    r_data2_o = (r_addr2_i == 5'b0) ? 32'b0 : rf[r_addr2_i];
  end

endmodule : RegFile
