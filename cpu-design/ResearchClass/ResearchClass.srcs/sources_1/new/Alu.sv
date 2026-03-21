// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : Alu.sv
//  Create  : 2024-7-1
// =============================================

`include "Decoder.svh"

module Alu(
  input  alu_grand_op_t grand_op_i,
  input  alu_op_t       op_i,
  input  logic [31:0]   pc_i,
  input  logic [31:0]   src1_i,
  input  logic [31:0]   src2_i,
  output logic [31:0]   result_o
);

  logic [31:0] bw_result, li_result, int_result, sft_result, mul_result, div_result;

  always_comb begin
    case (grand_op_i)
      default: begin  // `ALU_GTYPE_BW
        result_o = bw_result;
      end
      `ALU_GTYPE_LI: begin
        result_o = li_result;
      end
      `ALU_GTYPE_INT: begin
        result_o = int_result;
      end
      `ALU_GTYPE_SFT: begin
        result_o = sft_result;
      end
      `ALU_GTYPE_MUL: begin
        result_o = mul_result;
      end
      `ALU_GTYPE_DIV: begin
        result_o = div_result;
      end
    endcase
  end

  always_comb begin
    case (op_i)
      default: begin  // `ALU_STYPE_NOR
        bw_result = ~(src1_i | src2_i);
      end
      `ALU_STYPE_AND: begin
        bw_result = src1_i & src2_i;
      end
      `ALU_STYPE_OR: begin
        bw_result = src1_i | src2_i;
      end
      `ALU_STYPE_XOR: begin
        bw_result = src1_i ^ src2_i;
      end
    endcase
  end

  always_comb begin
    case (op_i)
      default: begin  // `ALU_STYPE_LUI
        li_result = {src2_i[19:0], 12'd0};
      end
      `ALU_STYPE_PCPLUS4: begin
        li_result = 32'd4 + pc_i;
      end
      `ALU_STYPE_PCADDU12I: begin
        li_result = {src2_i[19:0], 12'd0} + pc_i;
      end
      `ALU_STYPE_PCADDI: begin
        li_result = {{10{src2_i[19]}}, src2_i[19:0], 2'd0} + pc_i;
      end
    endcase
  end

  always_comb begin
    case (op_i)
      default: begin  // `ALU_STYPE_ADD
        int_result = src1_i + src2_i;
      end
      `ALU_STYPE_SUB: begin
        int_result = src1_i - src2_i;
      end
      `ALU_STYPE_SLT: begin
        int_result = $signed(src1_i) < $signed(src2_i);
      end
      `ALU_STYPE_SLTU: begin
        int_result = src1_i < src2_i;
      end
    endcase
  end

  always_comb begin
    case (op_i)
      default: begin  // `ALU_STYPE_SRA
        sft_result = $signed($signed(src1_i) >>> $signed(src2_i[4:0]));
      end
      `ALU_STYPE_SRL: begin
        sft_result = src1_i >> src2_i[4:0];
      end
      `ALU_STYPE_SLL: begin
        sft_result = src1_i << src2_i[4:0];
      end
    endcase
  end

  wire [63:0] signed_mul = $signed(src1_i) * $signed(src2_i);
  wire [63:0] unsigned_mul = src1_i * src2_i;

  always_comb begin
    case (op_i)
      default: begin  // `ALU_STYPE_MULL
        mul_result = signed_mul[31:0 ];
      end
      `MUL_TYPE_MULH: begin
        mul_result = signed_mul[63:32];
      end
      `MUL_TYPE_MULHU: begin
        mul_result = unsigned_mul[63:32];
      end
    endcase
  end

  always_comb begin
    case (op_i)
      default: begin  // `DIV_TYPE_DIV
        div_result = ($signed(src1_i) / $signed(src2_i));
      end
      `DIV_TYPE_DIVU: begin
        div_result = (src1_i / src2_i);
      end
      `DIV_TYPE_MOD: begin
        div_result = ($signed(src1_i) % $signed(src2_i));
      end
      `DIV_TYPE_MODU: begin
        div_result = (src1_i % src2_i);
      end
    endcase
  end

endmodule : Alu
