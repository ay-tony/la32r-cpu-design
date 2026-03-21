// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : CpuTop.sv
//  Create  : 2024-7-1
// =============================================

`include "Decoder.svh"

function logic [4:0] get_srcw_addr_from_s3(
  input logic [31:0] inst,
  input s3_sig_t s3_sig
);
  return (s3_sig.srcw == `SRCW_RD) ? inst[4:0] :
         (s3_sig.srcw == `SRCW_R1) ? 5'd1      :
                                     5'd0;
endfunction

function logic [4:0] get_srcw_addr_from_s4(
  input logic [31:0] inst,
  input s4_sig_t s4_sig
);
  return (s4_sig.srcw == `SRCW_RD) ? inst[4:0] :
         (s4_sig.srcw == `SRCW_R1) ? 5'd1      :
                                     5'd0;
endfunction

function logic [4:0] get_srcw_addr_from_s5(
  input logic [31:0] inst,
  input s5_sig_t s5_sig
);
  return (s5_sig.srcw == `SRCW_RD) ? inst[4:0] :
         (s5_sig.srcw == `SRCW_R1) ? 5'd1      :
                                     5'd0;
endfunction

typedef struct packed {
  logic data_valid;
  logic valid;
  logic ready;
} st_ctrl_t;

module CpuTop(
  // 时钟和复位
  input  logic        clk,
  input  logic        reset_n,
  // SRAM 指令接口
  output logic        inst_sram_en_o,
  output logic [3 :0] inst_sram_we_o,
  output logic [31:0] inst_sram_addr_o,
  output logic [31:0] inst_sram_wdata_o,
  input  logic [31:0] inst_sram_rdata_i,
  // SRAM 数据接口
  output logic        data_sram_en_o,
  output logic [3 :0] data_sram_we_o,
  output logic [31:0] data_sram_addr_o,
  output logic [31:0] data_sram_wdata_o,
  input  logic [31:0] data_sram_rdata_i,
  // 调试接口
  output logic [31:0] debug_s5_pc_o,
  output logic [3 :0] debug_s5_rf_we_o,
  output logic [4 :0] debug_s5_rf_wnum_o,
  output logic [31:0] debug_s5_rf_wdata_o
);

  wire reset = !reset_n;

  st_ctrl_t s1_ctrl, s2_ctrl, s3_ctrl, s4_ctrl, s5_ctrl;

  logic [31:0] s1_pc;
  logic [31:0] s2_pc, s2_inst;
  logic [31:0] s3_pc, s3_inst;
  logic [31:0] s4_pc, s4_inst;
  logic [31:0] s5_pc, s5_inst;

  s2_sig_t s2_sig;
  s3_sig_t s3_sig;
  s4_sig_t s4_sig;
  s5_sig_t s5_sig;

  logic s2_stall, s3_stall, s4_stall;

  logic        s2_branch_taken;  // 是否出现分支
  logic [31:0] s2_branch_addr;   // 若分支则指示目标地址

  wire [4:0] s3_srcw_addr = get_srcw_addr_from_s3(s3_inst, s3_sig);
  wire [4:0] s4_srcw_addr = get_srcw_addr_from_s4(s4_inst, s4_sig);
  wire [4:0] s5_srcw_addr = get_srcw_addr_from_s5(s5_inst, s5_sig);
  
  // ================
  //  流水线 stage 1
  // ================

  // 控制信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s1_ctrl.data_valid <= 1'b0;
    end else begin
      s1_ctrl.data_valid <= 1'b1;  // s1 级总是有效
    end
  end

  always_comb begin
    s1_ctrl.valid = s1_ctrl.data_valid && !(s2_ctrl.valid && s2_branch_taken);  // 当 s2 级跳转时冲刷本级流水线
    s1_ctrl.ready = !s1_ctrl.valid || s2_ctrl.ready;                            // s1 级无前级，此参数无实际意义
  end

  // 初始化 pc 寄存器
  always_ff @(posedge clk) begin
    if (reset) begin
      s1_pc <= 32'h1bfffffc;                                                         // 下一拍的 pc 就是初始值 0x1c000000
    end else if (s2_ctrl.valid && !s2_ctrl.ready) begin
      s1_pc <= s1_pc;                                                                // 阻塞 pc
    end else begin
      s1_pc <= (s2_ctrl.valid && s2_branch_taken) ? s2_branch_addr : (s1_pc + 'd4);  // 根据分支情况更新 pc
    end
  end

  // 通过 SRAM 接口读取指令
  always_comb begin
    inst_sram_en_o    = 1'b1;
    inst_sram_we_o    = 4'b0;
    inst_sram_addr_o  = (s2_ctrl.valid && !s2_ctrl.ready) ? s2_pc : s1_pc;
    inst_sram_wdata_o = 32'b0;
  end

  // ================
  //  流水线 stage 2
  // ================
  
  // 控制信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s2_ctrl.data_valid <= 1'b0;
    end else if (s2_ctrl.ready) begin
      s2_ctrl.data_valid <= s1_ctrl.valid;
    end else if (s2_ctrl.data_valid && s3_ctrl.ready) begin
      s2_ctrl.data_valid <= 1'b0;
    end
  end

  always_comb begin
    s2_ctrl.valid = s2_ctrl.data_valid;  // TODO: 冲刷流水线
    s2_ctrl.ready = !s2_ctrl.valid || s3_ctrl.ready;
  end

  // 数据信号
  assign s2_inst = inst_sram_rdata_i;  // 异步 BRAM 读取
  always_ff @(posedge clk) begin
    if (reset) begin
      s2_pc <= 32'h1bfffff8;  // s1 级初始 pc - 4
    end else if (s1_ctrl.valid && s2_ctrl.ready) begin
      s2_pc <= s1_pc;
    end else begin
      s2_pc <= s2_pc;
    end
  end

  // 解码器
  Decoder U_Decoder(
    .inst_i  (s2_inst),
    .s2_sig_o(s2_sig )
  );

  // 解码立即数
  logic [31:0] s2_imm, s3_imm;
  assign s2_imm = (s2_sig.imm_type == `IMM_U12) ? {20'd0,             s2_inst[21:10]} :
                  (s2_sig.imm_type == `IMM_U5 ) ? {27'd0,             s2_inst[14:10]} :
                  (s2_sig.imm_type == `IMM_S12) ? {{20{s2_inst[21]}}, s2_inst[21:10]} :
                  (s2_sig.imm_type == `IMM_S20) ? {{20{s2_inst[24]}}, s2_inst[24:5 ]} :
                  (s2_sig.imm_type == `IMM_S16) ? {{20{s2_inst[25]}}, s2_inst[25:10]} :
                  (s2_sig.imm_type == `IMM_S26) ? {{6 {s2_inst[9 ]}}, s2_inst[9 :0 ], s2_inst[25:10]} :
                                                  32'd0;

  // 读寄存器
  wire  [4 :0] s2_src1_addr = (s2_sig.src1 == `SRC1_RJ ) ? s2_inst[9:5] :
                                                           5'b0;
  wire  [4 :0] s2_src2_addr = (s2_sig.src2 == `SRC2_RK ) ? s2_inst[14:10] :
                              (s2_sig.src2 == `SRC2_RD ) ? s2_inst[4 :0 ] : 
                              (s2_sig.src3 == `SRC3_RD ) ? s2_inst[4 :0 ] :
                                                           5'b0;
  wire  [4 :0] s2_src3_addr = (s2_sig.src3 == `SRC3_RD ) ? s2_inst[4 :0 ] :
                                                           5'b0;
  logic [4 :0] s3_src1_addr, s4_src1_addr, s5_src1_addr;
  logic [4 :0] s3_src2_addr, s4_src2_addr, s5_src2_addr;
  logic [4 :0] s3_src3_addr, s4_src3_addr, s5_src3_addr;
  logic [31:0] s2_src1_raw, s2_src1, s3_src1, s4_src1, s5_src1;
  logic [31:0] s2_src2_raw, s2_src2, s3_src2, s4_src2, s5_src2;
  logic [31:0] s2_src3_raw, s2_src3, s3_src3, s4_src3, s5_src3;

  // npc 计算
  always_comb begin
    unique case(s2_sig.cmp_type)
      `CMP_NOCONDITION: begin
        s2_branch_taken = 1'b1;
      end
      `CMP_E: begin
        s2_branch_taken = s2_src1 == s2_src2;
      end
      `CMP_NE: begin
        s2_branch_taken = s2_src1 != s2_src2;
      end
      `CMP_LE: begin
        s2_branch_taken = $signed(s2_src1) <= $signed(s2_src2);
      end
      `CMP_GT: begin
        s2_branch_taken = $signed(s2_src1) > $signed(s2_src2);
      end
      `CMP_LT: begin
        s2_branch_taken = $signed(s2_src1) < $signed(s2_src2);
      end
      `CMP_GE: begin
        s2_branch_taken = $signed(s2_src1) >= $signed(s2_src2);
      end
      `CMP_LTU: begin
        s2_branch_taken = s2_src1 < s2_src2;
      end
      `CMP_GEU: begin
        s2_branch_taken = s2_src1 > s2_src2;
      end
      default: begin
        s2_branch_taken = 1'b0;
      end
    endcase

    s2_branch_addr = (s2_sig.target_type == `TARGET_REL) ?
                       (s2_pc        + (s2_imm[29:0] << 2)) : 
                       (s2_src1 + (s2_imm[29:0] << 2));
  end

  // ================
  //  流水线 stage 3
  // ================
  
  // 控制信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s3_ctrl.data_valid <= 1'b0;
    end else if (s3_ctrl.ready) begin
      s3_ctrl.data_valid <= s2_ctrl.valid;
    end else if (s3_ctrl.valid && s4_ctrl.ready) begin
      s3_ctrl.data_valid <= 1'b0;
    end
  end

  always_comb begin
    s3_ctrl.valid = s3_ctrl.data_valid;  // TODO: 冲刷流水线
    s3_ctrl.ready = (!s3_ctrl.valid || s4_ctrl.ready) && !s2_stall;
  end

  // 数据信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s3_pc <= 32'h1bfffff4;
      s3_inst <= '0;
    end else if (s2_ctrl.valid && s3_ctrl.ready) begin
      s3_pc <= s2_pc;
      s3_inst <= s2_inst;
      s3_sig <= s2_sig;
      s3_src1_addr <= s2_src1_addr;
      s3_src2_addr <= s2_src2_addr;
      s3_src3_addr <= s2_src3_addr;
      s3_imm <= s2_imm;
    end else begin
      s3_pc <= s3_pc;
      s3_inst <= s3_inst;
      s3_sig <= s3_sig;
      s3_src1_addr <= s3_src1_addr;
      s3_src2_addr <= s3_src2_addr;
      s3_src3_addr <= s3_src3_addr;
      s3_imm <= s3_imm;
    end
  end

  // Alu
  wire  [31:0] s3_alu_src1 = (s3_sig.src1 == `SRC1_RJ ) ? s3_src1 :
                                                          32'b0;
  wire  [31:0] s3_alu_src2 = (s3_sig.src2 == `SRC2_RK ) ? s3_src2 :
                             (s3_sig.src2 == `SRC2_RD ) ? s3_src2 :
                             (s3_sig.src2 == `SRC2_IMM) ? s3_imm       :
                                                          32'b0;
  logic [31:0] s3_alu_result, s4_alu_result, s5_alu_result;
  Alu U_Alu(
    .grand_op_i(s3_sig.alu_grand_op),
    .op_i(s3_sig.alu_op),
    .pc_i(s3_pc),
    .src1_i(s3_alu_src1),
    .src2_i(s3_alu_src2),
    .result_o(s3_alu_result)
  );

  // Lsu 写入
  LsuWrite U_LsuWrite(
    .s3_sig_i         (s3_sig           ),
    .s3_mem_addr_i    (s3_alu_result    ),
    .s3_mem_data_i    (s3_src3          ),
    .s3_valid_i       (s3_ctrl.valid    ),
    .data_sram_en_o   (data_sram_en_o   ),
    .data_sram_we_o   (data_sram_we_o   ),
    .data_sram_addr_o (data_sram_addr_o ),
    .data_sram_wdata_o(data_sram_wdata_o)
  );

  // ================
  //  流水线 stage 4
  // ================
  
  // 控制信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s4_ctrl.data_valid <= 1'b0;
    end else if (s4_ctrl.ready) begin
      s4_ctrl.data_valid <= s3_ctrl.valid;
    end else if (s4_ctrl.valid && s5_ctrl.ready) begin
      s4_ctrl.data_valid <= 1'b0;
    end
  end

  always_comb begin
    s4_ctrl.valid = s4_ctrl.data_valid;  // TODO: 冲刷流水线
    s4_ctrl.ready = (!s4_ctrl.valid || s5_ctrl.ready) && !s3_stall;
  end

  // 数据信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s4_pc <= 32'h1bfffff0;
      s4_inst <= '0;
    end else if (s3_ctrl.valid && s4_ctrl.ready) begin
      s4_pc <= s3_pc;
      s4_inst <= s3_inst;
      s4_sig <= s3_sig;
      s4_alu_result <= s3_alu_result;
      s4_src1_addr <= s3_src1_addr;
      s4_src2_addr <= s3_src2_addr;
      s4_src3_addr <= s3_src3_addr;
    end else begin
      s4_pc <= s4_pc;
      s4_inst <= s4_inst;
      s4_sig <= s4_sig;
      s4_alu_result <= s4_alu_result;
      s4_src1_addr <= s4_src1_addr;
      s4_src2_addr <= s4_src2_addr;
      s4_src3_addr <= s4_src3_addr;
    end
  end

  // Lsu 读出
  logic [31:0] s4_mem_data, s5_mem_data;
  LsuRead U_LsuRead(
    .s4_sig_i         (s4_sig           ),
    .s4_mem_addr_i    (s4_alu_result    ),
    .s4_mem_data_o    (s4_mem_data      ),
    .data_sram_rdata_i(data_sram_rdata_i)
  );

  // ================
  //  流水线 stage 5
  // ================
  
  // 控制信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s5_ctrl.data_valid <= 1'b0;
    end else if (s5_ctrl.ready) begin
      s5_ctrl.data_valid <= s4_ctrl.valid;
    end else begin
      s5_ctrl.data_valid <= s5_ctrl.data_valid;
    end
  end

  always_comb begin
    s5_ctrl.valid = s5_ctrl.data_valid;  // TODO: 冲刷流水线
    s5_ctrl.ready = !s4_stall;
  end

  // 数据信号
  always_ff @(posedge clk) begin
    if (reset) begin
      s5_pc <= 32'h1bffffec;
      s5_inst <= '0;
    end else if (s4_ctrl.valid && s5_ctrl.ready) begin
      s5_pc <= s4_pc;
      s5_inst <= s4_inst;
      s5_sig <= s4_sig;
      s5_alu_result <= s4_alu_result;
      s5_src1_addr <= s4_src1_addr;
      s5_src2_addr <= s4_src2_addr;
      s5_src3_addr <= s4_src3_addr;
      s5_mem_data <= s4_mem_data;
    end else begin
      s5_pc <= s5_pc;
      s5_inst <= s5_inst;
      s5_alu_result <= s5_alu_result;
      s5_src1_addr <= s5_src1_addr;
      s5_src2_addr <= s5_src2_addr;
      s5_src3_addr <= s5_src3_addr;
      s5_mem_data <= s5_mem_data;
    end
  end

  // 写寄存器
  wire        s5_reg_w_en  = s5_ctrl.valid && (s5_sig.srcw != `SRCW_NONE);
  wire [31:0] s5_srcw      = (s5_sig.bypass_s5 == `BYPASS_S5_ALU) ? s5_alu_result :
                             (s5_sig.bypass_s5 == `BYPASS_S5_MEM) ? s5_mem_data   :
                                                                    '0;

  // 例化寄存器
  logic [4 :0] reg_addr2;
  logic [31:0] reg_data2;
  always_comb begin
    if (s2_sig.src3 != `SRC3_NONE) begin
      reg_addr2 = s2_src3_addr;
      s2_src3_raw = reg_data2;
      s2_src2_raw = (s2_sig.src2 == `SRC2_IMM) ? s2_imm : 5'b0;
    end else begin
      reg_addr2 = s2_src2_addr;
      s2_src2_raw = reg_data2;
      s2_src3_raw = 0;
    end
  end
  RegFile U_RegFile(
    .clk      (clk             ),
    .r_addr1_i(s2_src1_addr    ),
    .r_data1_o(s2_src1_raw     ),
    .r_addr2_i(reg_addr2       ),
    .r_data2_o(reg_data2       ),
    .w_en_i   (s5_reg_w_en     ),
    .w_addr_i (s5_srcw_addr    ),
    .w_data_i (s5_srcw         )
  );

  // 调试接口
  always_comb begin
    debug_s5_pc_o       = s5_pc;
    debug_s5_rf_we_o    = {4{s5_reg_w_en}};
    debug_s5_rf_wnum_o  = s5_srcw_addr;
    debug_s5_rf_wdata_o = s5_srcw;
  end

  // ================
  //  流水线暂停处理
  // ================

  assign s2_stall = s2_ctrl.valid && (
    (s2_sig.src1 != `SRC1_NONE && (
      (s3_ctrl.valid && s2_src1_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_NONE) ||
      (s4_ctrl.valid && s2_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s2_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)  // TODO: 内部转发实现
    )) ||
    (s2_sig.src2 != `SRC2_NONE && s2_sig.src2 != `SRC2_IMM && (
      (s3_ctrl.valid && s2_src2_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_NONE) ||
      (s4_ctrl.valid && s2_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s2_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)  // TODO: 内部转发实现
    )) || 
    (s2_sig.src3 != `SRC3_NONE && (
      (s3_ctrl.valid && s2_src3_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_NONE) ||
      (s4_ctrl.valid && s2_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s2_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)  // TODO: 内部转发实现
    ))
  );

  assign s3_stall = s3_ctrl.valid && (
    (s3_sig.src1 != `SRC1_NONE && (
      (s4_ctrl.valid && s3_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s3_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    )) ||
    (s3_sig.src2 != `SRC2_NONE && s3_sig.src2 != `SRC2_IMM && (
      (s4_ctrl.valid && s3_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s3_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    )) ||
    (s3_sig.src3 != `SRC2_NONE && (
      (s4_ctrl.valid && s3_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_NONE) ||
      (s5_ctrl.valid && s3_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    ))
  );

  assign s4_stall = s4_ctrl.valid && (
    (s4_sig.src1 != `SRC1_NONE && (
      (s5_ctrl.valid && s4_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    )) ||
    (s4_sig.src2 != `SRC2_NONE && s4_sig.src2 != `SRC2_IMM && (
      (s5_ctrl.valid && s4_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    )) ||
    (s4_sig.src3 != `SRC2_NONE && (
      (s5_ctrl.valid && s4_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_NONE)
    ))
  );

  // ================
  //  流水线前递处理
  // ================
  
  // s2 级流水线前递
  always_comb begin
    priority case (1'b1)
      (s3_ctrl.valid && s2_src1_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
        s2_src1 = s3_alu_result;
      end
      (s4_ctrl.valid && s2_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
        s2_src1 = s4_alu_result;
      end
      (s4_ctrl.valid && s2_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
        s2_src1 = s4_mem_data;
      end
      (s5_ctrl.valid && s2_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
        s2_src1 = s5_alu_result;
      end
      (s5_ctrl.valid && s2_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
        s2_src1 = s5_mem_data;
      end
      default: begin
        s2_src1 = s2_src1_raw;
      end
    endcase
    priority case (1'b1)
      (s3_ctrl.valid && s2_src2_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
        s2_src2 = s3_alu_result;
      end
      (s4_ctrl.valid && s2_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
        s2_src2 = s4_alu_result;
      end
      (s4_ctrl.valid && s2_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
        s2_src2 = s4_mem_data;
      end
      (s5_ctrl.valid && s2_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
        s2_src2 = s5_alu_result;
      end
      (s5_ctrl.valid && s2_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
        s2_src2 = s5_mem_data;
      end
      default: begin
        s2_src2 = s2_src2_raw;
      end
    endcase
    priority case (1'b1)
      (s3_ctrl.valid && s2_src3_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
        s2_src3 = s3_alu_result;
      end
      (s4_ctrl.valid && s2_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
        s2_src3 = s4_alu_result;
      end
      (s4_ctrl.valid && s2_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
        s2_src3 = s4_mem_data;
      end
      (s5_ctrl.valid && s2_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
        s2_src3 = s5_alu_result;
      end
      (s5_ctrl.valid && s2_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
        s2_src3 = s5_mem_data;
      end
      default: begin
        s2_src3 = s2_src3_raw;
      end
    endcase
  end
  
  // s3 级流水线前递
  always_ff @(posedge clk) begin
    if (s2_ctrl.valid && s3_ctrl.ready) begin
      priority case (1'b1)
        (s3_ctrl.valid && s2_src1_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
          s3_src1 <= s3_alu_result;
        end
        (s4_ctrl.valid && s2_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s3_src1 <= s4_alu_result;
        end
        (s4_ctrl.valid && s2_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s3_src1 <= s4_mem_data;
        end
        (s5_ctrl.valid && s2_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s3_src1 <= s5_alu_result;
        end
        (s5_ctrl.valid && s2_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s3_src1 <= s5_mem_data;
        end
        default: begin
          s3_src1 <= s2_src1;
        end
      endcase
      priority case (1'b1)
        (s3_ctrl.valid && s2_src2_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
          s3_src2 <= s3_alu_result;
        end
        (s4_ctrl.valid && s2_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s3_src2 <= s4_alu_result;
        end
        (s4_ctrl.valid && s2_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s3_src2 <= s4_mem_data;
        end
        (s5_ctrl.valid && s2_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s3_src2 <= s5_alu_result;
        end
        (s5_ctrl.valid && s2_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s3_src2 <= s5_mem_data;
        end
        default: begin
          s3_src2 <= s2_src2;
        end
      endcase
      priority case (1'b1)
        (s3_ctrl.valid && s2_src3_addr == s3_srcw_addr && s3_sig.bypass_s3 == `BYPASS_S3_ALU): begin
          s3_src3 <= s3_alu_result;
        end
        (s4_ctrl.valid && s2_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s3_src3 <= s4_alu_result;
        end
        (s4_ctrl.valid && s2_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s3_src3 <= s4_mem_data;
        end
        (s5_ctrl.valid && s2_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s3_src3 <= s5_alu_result;
        end
        (s5_ctrl.valid && s2_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s3_src3 <= s5_mem_data;
        end
        default: begin
          s3_src3 <= s2_src3;
        end
      endcase
    end else begin
      s3_src1 <= s3_src1;
      s3_src2 <= s3_src2;
      s3_src3 <= s3_src3;
    end
  end

  // s4 级流水线前递
  always_ff @(posedge clk) begin
    if (s3_ctrl.valid && s4_ctrl.ready) begin
      priority case (1'b1)
        (s4_ctrl.valid && s3_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s4_src1 <= s4_alu_result;
        end
        (s4_ctrl.valid && s3_src1_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s4_src1 <= s4_mem_data;
        end
        (s5_ctrl.valid && s3_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s4_src1 <= s5_alu_result;
        end
        (s5_ctrl.valid && s3_src1_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s4_src1 <= s5_mem_data;
        end
        default: begin
          s4_src1 <= s3_src1;
        end
      endcase
      priority case (1'b1)
        (s4_ctrl.valid && s3_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s4_src2 <= s4_alu_result;
        end
        (s4_ctrl.valid && s3_src2_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s4_src2 <= s4_mem_data;
        end
        (s5_ctrl.valid && s3_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s4_src2 <= s5_alu_result;
        end
        (s5_ctrl.valid && s3_src2_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s4_src2 <= s5_mem_data;
        end
        default: begin
          s4_src2 <= s3_src2;
        end
      endcase
      priority case (1'b1)
        (s4_ctrl.valid && s3_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_ALU): begin
          s4_src3 <= s4_alu_result;
        end
        (s4_ctrl.valid && s3_src3_addr == s4_srcw_addr && s4_sig.bypass_s4 == `BYPASS_S4_MEM): begin
          s4_src3 <= s4_mem_data;
        end
        (s5_ctrl.valid && s3_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_ALU): begin
          s4_src3 <= s5_alu_result;
        end
        (s5_ctrl.valid && s3_src3_addr == s5_srcw_addr && s5_sig.bypass_s5 == `BYPASS_S5_MEM): begin
          s4_src3 <= s5_mem_data;
        end
        default: begin
          s4_src3 <= s3_src3;
        end
      endcase
    end else begin
      s4_src1 <= s4_src1;
      s4_src2 <= s4_src2;
      s4_src3 <= s4_src3;
    end
  end

  // s5 级流水线前递
  // s5 级不需要前递
  always_ff @(posedge clk) begin
    if (s4_ctrl.valid && s5_ctrl.ready) begin
      s5_src1 <= s4_src1;
      s5_src2 <= s4_src2;
      s5_src3 <= s4_src3;
    end else begin
      s5_src1 <= s5_src1;
      s5_src2 <= s5_src2;
      s5_src3 <= s5_src3;
    end
  end

endmodule : CpuTop
