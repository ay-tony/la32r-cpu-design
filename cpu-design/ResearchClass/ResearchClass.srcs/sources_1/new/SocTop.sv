// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : SocTop.sv
//  Create  : 2024-7-1
// =============================================

module SocTop #(
  parameter SIMULATION = 1'b1
)(
  // 时钟和复位
  input  logic        clk,
  input  logic        reset_n, 
  // LED 灯
  output logic [15:0] led_o,      // 单色 LED
  output logic [1 :0] led_rg0_o,  // 第一个双色 LED
  output logic [1 :0] led_rg1_o,  // 第二个双色 LED
  // 七段数码管
  output logic [6 :0] num_a_g_o,  // 数码管信号
  output logic [7 :0] num_csn_o,  // 数码管片选信号
  // 其他信号
  output logic [31:0] num_data_o,
  input  logic [7 :0] switch_i, 
  output logic [3 :0] btn_key_col_o,
  input  logic [3 :0] btn_key_row_i,
  input  logic [1 :0] btn_step_i
);

  // PLL 转换时钟
  logic soc_clk;

  // CPU 调试接口
  logic [31:0] cpu_debug_s5_pc;
  logic [ 3:0] cpu_debug_s5_rf_we;
  logic [ 4:0] cpu_debug_s5_rf_wnum;
  logic [31:0] cpu_debug_s5_rf_wdata;

  // CPU InstRam 接口
  logic        cpu_inst_en;
  logic [3 :0] cpu_inst_we;
  logic [31:0] cpu_inst_addr;
  logic [31:0] cpu_inst_wdata;
  logic [31:0] cpu_inst_rdata;

  // CPU Bridge 接口
  logic        cpu_data_en;
  logic [3 :0] cpu_data_we;
  logic [31:0] cpu_data_addr;
  logic [31:0] cpu_data_wdata;
  logic [31:0] cpu_data_rdata;

  // Bridge DataRam 接口
  logic        bridge_data_en;
  logic [3 :0] bridge_data_we;
  logic [31:0] bridge_data_addr;
  logic [31:0] bridge_data_wdata;
  logic [31:0] bridge_data_rdata;

  // Bridge ConfReg 接口
  logic        bridge_conf_en;
  logic        bridge_conf_we;
  logic [31:0] bridge_conf_addr;
  logic [31:0] bridge_conf_wdata;
  logic [31:0] bridge_conf_rdata;

  generate if(SIMULATION) begin
    assign soc_clk = clk;
  end else begin
    ClkPll U_ClkPll(
      .clk_in1(clk    ),
      .clk_out(soc_clk)
    );
  end
  endgenerate


  CpuTop U_CpuTop(
    .clk(soc_clk),
    .reset_n(reset_n),
    .inst_sram_en_o(cpu_inst_en),
    .inst_sram_we_o(cpu_inst_we),
    .inst_sram_addr_o(cpu_inst_addr),
    .inst_sram_wdata_o(cpu_inst_wdata),
    .inst_sram_rdata_i(cpu_inst_rdata),
    .data_sram_en_o(cpu_data_en),
    .data_sram_we_o(cpu_data_we),
    .data_sram_addr_o(cpu_data_addr),
    .data_sram_wdata_o(cpu_data_wdata),
    .data_sram_rdata_i(cpu_data_rdata),
    .debug_s5_pc_o(cpu_debug_s5_pc),
    .debug_s5_rf_we_o(cpu_debug_s5_rf_we),
    .debug_s5_rf_wnum_o(cpu_debug_s5_rf_wnum),
    .debug_s5_rf_wdata_o(cpu_debug_s5_rf_wdata)
  );

  Bridge U_Bridge(
    .clk(soc_clk),
    .reset_n(reset_n),
    .cpu_data_en(cpu_data_en),
    .cpu_data_we(cpu_data_we),
    .cpu_data_addr(cpu_data_addr),
    .cpu_data_wdata(cpu_data_wdata),
    .cpu_data_rdata(cpu_data_rdata),
    .data_sram_en(bridge_data_en),
    .data_sram_we(bridge_data_we),
    .data_sram_addr(bridge_data_addr),
    .data_sram_wdata(bridge_data_wdata),
    .data_sram_rdata(bridge_data_rdata),
    .conf_en(bridge_conf_en),
    .conf_we(bridge_conf_we),
    .conf_addr(bridge_conf_addr),
    .conf_wdata(bridge_conf_wdata),
    .conf_rdata(bridge_conf_rdata)
  );

  ConfReg #(
    .SIMULATION(SIMULATION)
  ) U_ConfReg(
      .clk(soc_clk),
      .timer_clk(soc_clk),
      .resetn(reset_n),
      .conf_en(bridge_conf_en),
      .conf_we(bridge_conf_we),
      .conf_addr(bridge_conf_addr),
      .conf_wdata(bridge_conf_wdata),
      .conf_rdata(bridge_conf_rdata),
      .led(led_o),
      .led_rg0(led_rg0_o),
      .led_rg1(led_rg1_o),
      .num_csn(num_csn_o),
      .num_a_g(num_a_g_o),
      .num_data(num_data_o),
      .switch(switch_i),
      .btn_key_col(btn_key_col_o),
      .btn_key_row(btn_key_row_i),
      .btn_step(btn_step_i)
    );

  InstRam U_InstRam
  (
    .clka  (soc_clk                ),   
    .ena   (cpu_inst_en        ),
    .wea   (cpu_inst_we        ),
    .addra (cpu_inst_addr[18:2]),
    .dina  (cpu_inst_wdata     ),
    .douta (cpu_inst_rdata     )
  );

  DataRam U_DataRam
  (
    .clka  (soc_clk                   ),   
    .ena   (bridge_data_en        ),
    .wea   (bridge_data_we        ),
    .addra (bridge_data_addr[18:2]),
    .dina  (bridge_data_wdata     ),
    .douta (bridge_data_rdata     )
  );

endmodule : SocTop
