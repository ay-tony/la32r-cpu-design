`ifndef DECODER_SVH
`define DECODER_SVH

`define ALU_GTYPE_BW (3'd0)
`define ALU_GTYPE_INT (3'd1)
`define ALU_GTYPE_LI (3'd2)
`define ALU_GTYPE_SFT (3'd3)
`define ALU_GTYPE_MUL (3'd4)
`define ALU_GTYPE_DIV (3'd5)
`define ALU_STYPE_NOR (2'b00)
`define ALU_STYPE_AND (2'b01)
`define ALU_STYPE_OR (2'b10)
`define ALU_STYPE_XOR (2'b11)
`define ALU_STYPE_ADD (2'b00)
`define ALU_STYPE_SUB (2'b10)
`define ALU_STYPE_SLT (2'b11)
`define ALU_STYPE_SLTU (2'b01)
`define ALU_STYPE_LUI (2'b00)
`define ALU_STYPE_PCPLUS4 (2'b01)
`define ALU_STYPE_PCADDU12I (2'b10)
`define ALU_STYPE_PCADDI (2'b11)
`define ALU_STYPE_SRA (2'b00)
`define ALU_STYPE_SLL (2'b10)
`define ALU_STYPE_SRL (2'b11)
`define MUL_TYPE_MULL (2'b00)
`define MUL_TYPE_MULH (2'b01)
`define MUL_TYPE_MULHU (2'b10)
`define DIV_TYPE_DIV (2'b00)
`define DIV_TYPE_DIVU (2'b01)
`define DIV_TYPE_MOD (2'b10)
`define DIV_TYPE_MODU (2'b11)
`define TARGET_REL (1'b0)
`define TARGET_ABS (1'b1)
`define CMP_NOCONDITION (4'b1110)
`define CMP_E (4'b0100)
`define CMP_NE (4'b1010)
`define CMP_LE (4'b1101)
`define CMP_GT (4'b0011)
`define CMP_LT (4'b1001)
`define CMP_GE (4'b0111)
`define CMP_LTU (4'b1000)
`define CMP_GEU (4'b0110)
`define SRC1_RJ (1'b1)
`define SRC1_NONE (1'b0)
`define SRC2_IMM (2'b11)
`define SRC2_RD (2'b10)
`define SRC2_RK (2'b01)
`define SRC2_NONE (2'b00)
`define SRC3_RD (1'b1)
`define SRC3_NONE (1'b0)
`define SRCW_R1 (2'b11)
`define SRCW_RD (2'b01)
`define SRCW_NONE (2'b00)
`define IMM_U12 (3'd0)
`define IMM_U5 (3'd0)
`define IMM_S12 (3'd1)
`define IMM_S20 (3'd2)
`define IMM_S16 (3'd3)
`define IMM_S26 (3'd4)
`define BYPASS_S3_NONE (1'd0)
`define BYPASS_S3_ALU (1'd1)
`define BYPASS_S4_NONE (2'd0)
`define BYPASS_S4_ALU (2'd1)
`define BYPASS_S4_MEM (2'd2)
`define BYPASS_S5_NONE (2'd0)
`define BYPASS_S5_ALU (2'd1)
`define BYPASS_S5_MEM (2'd2)
`define MEM_TYPE_NONE (3'd0)
`define MEM_TYPE_WORD (3'd1)
`define MEM_TYPE_HALF (3'd2)
`define MEM_TYPE_BYTE (3'd3)
`define MEM_TYPE_UHALF (3'd4)
`define MEM_TYPE_UBYTE (3'd5)

typedef logic [2 :0] alu_grand_op_t;
typedef logic [1 :0] alu_op_t;
typedef logic [0 :0] target_type_t;
typedef logic [3 :0] cmp_type_t;
typedef logic [0 :0] need_bpu_t;
typedef logic [0 :0] src1_t;
typedef logic [1 :0] src2_t;
typedef logic [0 :0] src3_t;
typedef logic [1 :0] srcw_t;
typedef logic [2 :0] imm_type_t;
typedef logic [0 :0] bypass_s3_t;
typedef logic [1 :0] bypass_s4_t;
typedef logic [1 :0] bypass_s5_t;
typedef logic [2 :0] mem_type_t;
typedef logic [0 :0] mem_write_t;
typedef logic [0 :0] mem_read_t;

typedef struct packed {
  target_type_t target_type;
  cmp_type_t cmp_type;
  need_bpu_t need_bpu;
  alu_grand_op_t alu_grand_op;
  alu_op_t alu_op;
  imm_type_t imm_type;
  bypass_s3_t bypass_s3;
  mem_write_t mem_write;
  bypass_s4_t bypass_s4;
  mem_type_t mem_type;
  mem_read_t mem_read;
  src1_t src1;
  src2_t src2;
  src3_t src3;
  srcw_t srcw;
  bypass_s5_t bypass_s5;
} s2_sig_t;

typedef struct packed {
  alu_grand_op_t alu_grand_op;
  alu_op_t alu_op;
  imm_type_t imm_type;
  bypass_s3_t bypass_s3;
  mem_write_t mem_write;
  bypass_s4_t bypass_s4;
  mem_type_t mem_type;
  mem_read_t mem_read;
  src1_t src1;
  src2_t src2;
  src3_t src3;
  srcw_t srcw;
  bypass_s5_t bypass_s5;
} s3_sig_t;

typedef struct packed {
  bypass_s4_t bypass_s4;
  mem_type_t mem_type;
  mem_read_t mem_read;
  src1_t src1;
  src2_t src2;
  src3_t src3;
  srcw_t srcw;
  bypass_s5_t bypass_s5;
} s4_sig_t;

typedef struct packed {
  src1_t src1;
  src2_t src2;
  src3_t src3;
  srcw_t srcw;
  bypass_s5_t bypass_s5;
} s5_sig_t;

function s3_sig_t get_s3_from_s2(input s2_sig_t s2);
  s3_sig_t ret;
  ret.alu_grand_op = s2.alu_grand_op;
  ret.alu_op = s2.alu_op;
  ret.imm_type = s2.imm_type;
  ret.bypass_s3 = s2.bypass_s3;
  ret.mem_write = s2.mem_write;
  ret.bypass_s4 = s2.bypass_s4;
  ret.mem_type = s2.mem_type;
  ret.mem_read = s2.mem_read;
  ret.src1 = s2.src1;
  ret.src2 = s2.src2;
  ret.src3 = s2.src3;
  ret.srcw = s2.srcw;
  ret.bypass_s5 = s2.bypass_s5;
  return ret;
endfunction

function s4_sig_t get_s4_from_s3(input s3_sig_t s3);
  s4_sig_t ret;
  ret.bypass_s4 = s3.bypass_s4;
  ret.mem_type = s3.mem_type;
  ret.mem_read = s3.mem_read;
  ret.src1 = s3.src1;
  ret.src2 = s3.src2;
  ret.src3 = s3.src3;
  ret.srcw = s3.srcw;
  ret.bypass_s5 = s3.bypass_s5;
  return ret;
endfunction

function s5_sig_t get_s5_from_s4(input s4_sig_t s4);
  s5_sig_t ret;
  ret.src1 = s4.src1;
  ret.src2 = s4.src2;
  ret.src3 = s4.src3;
  ret.srcw = s4.srcw;
  ret.bypass_s5 = s4.bypass_s5;
  return ret;
endfunction

`endif
