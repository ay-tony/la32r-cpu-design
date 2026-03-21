`include "Decoder.svh"

module Decoder(
  input  logic [31:0] inst_i,
  output s2_sig_t     s2_sig_o
);

  always_comb begin
    unique casez(inst_i)
      32'b010011??????????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_LI;
        s2_sig_o.alu_op = `ALU_STYPE_PCPLUS4;
        s2_sig_o.target_type = `TARGET_ABS;
        s2_sig_o.cmp_type = `CMP_NOCONDITION;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_NONE;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b010100??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_NOCONDITION;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_NONE;
        s2_sig_o.src2 = `SRC2_NONE;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S26;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b010101??????????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_LI;
        s2_sig_o.alu_op = `ALU_STYPE_PCPLUS4;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_NOCONDITION;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_NONE;
        s2_sig_o.src2 = `SRC2_NONE;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_R1;
        s2_sig_o.imm_type = `IMM_S26;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b010110??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_E;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b010111??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_NE;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b011000??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_LT;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b011001??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_GE;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b011010??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_LTU;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b011011??????????????????????????: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = `TARGET_REL;
        s2_sig_o.cmp_type = `CMP_GEU;
        s2_sig_o.need_bpu = 1'd1;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RD;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S16;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0001010?????????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_LI;
        s2_sig_o.alu_op = `ALU_STYPE_LUI;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_NONE;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S20;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0001110?????????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_LI;
        s2_sig_o.alu_op = `ALU_STYPE_PCADDU12I;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_NONE;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S20;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001000??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_SLT;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001001??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_SLTU;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001010??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001101??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_AND;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001110??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_OR;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0000001111??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_XOR;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0010100000??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_MEM;
        s2_sig_o.bypass_s5 = `BYPASS_S5_MEM;
        s2_sig_o.mem_type = `MEM_TYPE_BYTE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd1;
      end
      32'b0010100001??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_MEM;
        s2_sig_o.bypass_s5 = `BYPASS_S5_MEM;
        s2_sig_o.mem_type = `MEM_TYPE_HALF;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd1;
      end
      32'b0010100010??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_MEM;
        s2_sig_o.bypass_s5 = `BYPASS_S5_MEM;
        s2_sig_o.mem_type = `MEM_TYPE_WORD;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd1;
      end
      32'b0010100100??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_RD;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_BYTE;
        s2_sig_o.mem_write = 1'd1;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0010100101??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_RD;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_HALF;
        s2_sig_o.mem_write = 1'd1;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0010100110??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_RD;
        s2_sig_o.srcw = `SRCW_NONE;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_NONE;
        s2_sig_o.bypass_s5 = `BYPASS_S5_NONE;
        s2_sig_o.mem_type = `MEM_TYPE_WORD;
        s2_sig_o.mem_write = 1'd1;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b0010101000??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_MEM;
        s2_sig_o.bypass_s5 = `BYPASS_S5_MEM;
        s2_sig_o.mem_type = `MEM_TYPE_UBYTE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd1;
      end
      32'b0010101001??????????????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_S12;
        s2_sig_o.bypass_s3 = `BYPASS_S3_NONE;
        s2_sig_o.bypass_s4 = `BYPASS_S4_MEM;
        s2_sig_o.bypass_s5 = `BYPASS_S5_MEM;
        s2_sig_o.mem_type = `MEM_TYPE_UHALF;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd1;
      end
      32'b00000000000100000???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_ADD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000100010???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_SUB;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000100100???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_SLT;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000100101???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_INT;
        s2_sig_o.alu_op = `ALU_STYPE_SLTU;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101000???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_NOR;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_AND;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101010???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_OR;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101011???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_BW;
        s2_sig_o.alu_op = `ALU_STYPE_XOR;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101110???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SLL;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000101111???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SRL;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000110000???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SRA;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000111000???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_MUL;
        s2_sig_o.alu_op = `MUL_TYPE_MULL;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000111001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_MUL;
        s2_sig_o.alu_op = `MUL_TYPE_MULH;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000000111010???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_MUL;
        s2_sig_o.alu_op = `MUL_TYPE_MULHU;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000001000000???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_DIV;
        s2_sig_o.alu_op = `DIV_TYPE_DIV;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000001000001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_DIV;
        s2_sig_o.alu_op = `DIV_TYPE_MOD;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000001000010???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_DIV;
        s2_sig_o.alu_op = `DIV_TYPE_DIVU;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000001000011???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_DIV;
        s2_sig_o.alu_op = `DIV_TYPE_MODU;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_RK;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000010000001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SLL;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000010001001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SRL;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      32'b00000000010010001???????????????: begin
        s2_sig_o.alu_grand_op = `ALU_GTYPE_SFT;
        s2_sig_o.alu_op = `ALU_STYPE_SRA;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = `SRC1_RJ;
        s2_sig_o.src2 = `SRC2_IMM;
        s2_sig_o.src3 = `SRC3_NONE;
        s2_sig_o.srcw = `SRCW_RD;
        s2_sig_o.imm_type = `IMM_U5;
        s2_sig_o.bypass_s3 = `BYPASS_S3_ALU;
        s2_sig_o.bypass_s4 = `BYPASS_S4_ALU;
        s2_sig_o.bypass_s5 = `BYPASS_S5_ALU;
        s2_sig_o.mem_type = `MEM_TYPE_NONE;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
      default: begin
        s2_sig_o.alu_grand_op = 3'd0;
        s2_sig_o.alu_op = 2'd0;
        s2_sig_o.target_type = 1'd0;
        s2_sig_o.cmp_type = 4'd0;
        s2_sig_o.need_bpu = 1'd0;
        s2_sig_o.src1 = 1'd0;
        s2_sig_o.src2 = 2'd0;
        s2_sig_o.src3 = 1'd0;
        s2_sig_o.srcw = 2'd0;
        s2_sig_o.imm_type = 3'd0;
        s2_sig_o.bypass_s3 = 1'd0;
        s2_sig_o.bypass_s4 = 2'd0;
        s2_sig_o.bypass_s5 = 2'd0;
        s2_sig_o.mem_type = 3'd0;
        s2_sig_o.mem_write = 1'd0;
        s2_sig_o.mem_read = 1'd0;
      end
    endcase
  end

endmodule
