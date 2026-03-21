// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : Lsu.sv
//  Create  : 2024-6-22
// =============================================

`include "Decoder.svh"

module LsuRead(
  // 控制信号
  input  s4_sig_t     s4_sig_i,
  // CPU 数据接口
  input  logic [31:0] s4_mem_addr_i,
  output logic [31:0] s4_mem_data_o,
  // 数据 SRAM 接口
  input  logic [31:0] data_sram_rdata_i
);

  always_comb begin
    if (s4_sig_i.mem_read) begin
      unique case (s4_sig_i.mem_type)
        `MEM_TYPE_WORD: begin
          s4_mem_data_o = data_sram_rdata_i;
        end
        `MEM_TYPE_UHALF: begin
          unique case (s4_mem_addr_i[1])
            1'b1: begin
              s4_mem_data_o = {16'b0, data_sram_rdata_i[31:16]};
            end
            1'b0: begin
              s4_mem_data_o = {16'b0, data_sram_rdata_i[15:0 ]};
            end
          endcase
        end
        `MEM_TYPE_UBYTE: begin
          unique case (s4_mem_addr_i[1:0])
            2'b00: begin
              s4_mem_data_o = {24'b0, data_sram_rdata_i[7 :0 ]};
            end
            2'b01: begin
              s4_mem_data_o = {24'b0, data_sram_rdata_i[15:8 ]};
            end
            2'b10: begin
              s4_mem_data_o = {24'b0, data_sram_rdata_i[23:16]};
            end
            2'b11: begin
              s4_mem_data_o = {24'b0, data_sram_rdata_i[31:24]};
            end
          endcase
        end
        `MEM_TYPE_HALF: begin
          unique case (s4_mem_addr_i[1])
            1'b1: begin
              s4_mem_data_o = {{16{data_sram_rdata_i[31]}}, data_sram_rdata_i[31:16]};
            end
            1'b0: begin
              s4_mem_data_o = {{16{data_sram_rdata_i[15]}}, data_sram_rdata_i[15:0 ]};
            end
          endcase
        end
        `MEM_TYPE_BYTE: begin
          unique case (s4_mem_addr_i[1:0])
            2'b00: begin
              s4_mem_data_o = {{24{data_sram_rdata_i[7 ]}}, data_sram_rdata_i[7 :0 ]};
            end
            2'b01: begin
              s4_mem_data_o = {{24{data_sram_rdata_i[15]}}, data_sram_rdata_i[15:8 ]};
            end
            2'b10: begin
              s4_mem_data_o = {{24{data_sram_rdata_i[23]}}, data_sram_rdata_i[23:16]};
            end
            2'b11: begin
              s4_mem_data_o = {{24{data_sram_rdata_i[31]}}, data_sram_rdata_i[31:24]};
            end
          endcase
        end
        default: begin
          s4_mem_data_o = '0;
        end
      endcase
    end else begin
      s4_mem_data_o = '0;
    end
  end

endmodule : LsuRead

module LsuWrite(
  // 控制信号
  input  s3_sig_t     s3_sig_i,
  // CPU 地址和写数据信号
  input  logic [31:0] s3_mem_addr_i,
  input  logic [31:0] s3_mem_data_i,
  input  logic        s3_valid_i,
  // 数据 SRAM 接口
  output logic        data_sram_en_o,
  output logic [3 :0] data_sram_we_o,
  output logic [31:0] data_sram_addr_o,
  output logic [31:0] data_sram_wdata_o
);

  always_comb begin
    data_sram_en_o = (s3_sig_i.mem_type != `MEM_TYPE_NONE);
    data_sram_addr_o = {s3_mem_addr_i[31:2], 2'b00};

    if (s3_valid_i && s3_sig_i.mem_write) begin
      unique case (s3_sig_i.mem_type)
        `MEM_TYPE_WORD: begin
          data_sram_we_o = 4'b1111;
          data_sram_wdata_o = s3_mem_data_i;
        end
        `MEM_TYPE_HALF: begin
          unique case (s3_mem_addr_i[1])
            1'b1: begin
              data_sram_we_o = 4'b1100;
              data_sram_wdata_o = {s3_mem_data_i[15:0], 16'b0};
            end
            1'b0: begin
              data_sram_we_o = 4'b0011;
              data_sram_wdata_o = {16'b0, s3_mem_data_i[15:0]};
            end
          endcase
        end
        `MEM_TYPE_BYTE: begin
          unique case (s3_mem_addr_i[1:0])
            2'b00: begin
              data_sram_we_o = 4'b0001;
              data_sram_wdata_o = {24'b0, s3_mem_data_i[7:0]};
            end
            2'b01: begin
              data_sram_we_o = 4'b0010;
              data_sram_wdata_o = {16'b0, s3_mem_data_i[7:0], 8'b0};
            end
            2'b10: begin
              data_sram_we_o = 4'b0100;
              data_sram_wdata_o = {8'b0, s3_mem_data_i[7:0], 16'b0};
            end
            2'b11: begin
              data_sram_we_o = 4'b1000;
              data_sram_wdata_o = {s3_mem_data_i[7:0], 24'b0};
            end
          endcase
        end
        default: begin
          data_sram_we_o = 4'b0;
          data_sram_wdata_o = '0;
        end
      endcase
    end else begin
      data_sram_we_o = 4'b0;
      data_sram_wdata_o = '0;
    end
  end

endmodule : LsuWrite
