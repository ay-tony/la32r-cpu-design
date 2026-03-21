// =============================================
//  Copyright (c) 2024-2024 All rights reserved
// =============================================
//  Author  : aytony <anyang@buaa.edu.cn>
//  File    : TbTop.sv
//  Create  : 2024-7-3
// =============================================

`timescale 1ns / 1ps

`define TRACE_REF_FILE "../../../../../src/mycpu_env/gettrace/golden_trace.txt"
`define CONFREG_NUM_REG      SocTop.U_ConfReg.num_data
`define CONFREG_OPEN_TRACE   SocTop.U_ConfReg.open_trace
`define CONFREG_NUM_MONITOR  SocTop.U_ConfReg.num_monitor
`define CONFREG_UART_DISPLAY SocTop.U_ConfReg.write_uart_valid
`define CONFREG_UART_DATA    SocTop.U_ConfReg.write_uart_data
`define END_PC 32'h1c000100

module TbTop();

  reg reset_n;
  reg clk;
  
  logic [15:0] led;
  logic [1 :0] led_rg0;
  logic [1 :0] led_rg1;
  logic [7 :0] num_csn;
  logic [6 :0] num_a_g;
  logic [31:0] num_data;
  logic [7 :0] switch; 
  logic [3 :0] btn_key_col;
  logic [3 :0] btn_key_row;
  logic [1 :0] btn_step;

  assign switch      = 8'hff;
  assign btn_key_row = 4'd0;
  assign btn_step    = 2'd3;
  
  initial begin
    clk = 1'b0;
    reset_n = 1'b0;
    #2000;
    reset_n = 1'b1;
  end

  always #5 clk=~clk;

  SocTop U_SocTop
  (
     .reset_n      (reset_n    ), 
     .clk          (clk        ),
    
     // gpio
     .num_csn_o    (num_csn    ),
     .num_a_g_o    (num_a_g    ),
     .led_o        (led        ),
     .led_rg0_o    (led_rg0    ),
     .led_rg1_o    (led_rg1    ),
     .num_data_o   (num_data   ),
     .switch_i     (switch     ), 
     .btn_key_col_o(btn_key_col),
     .btn_key_row_i(btn_key_row),
     .btn_step_i   (btn_step   )
  );   
  
  //soc lite signals
  //"soc_clk" means clk in cpu
  //"wb" means write-back stage in pipeline
  //"rf" means regfiles in cpu
  //"w" in "wen/wnum/wdata" means writing
  wire soc_clk;
  wire [31:0] debug_wb_pc;
  wire [3 :0] debug_wb_rf_we;
  wire [4 :0] debug_wb_rf_wnum;
  wire [31:0] debug_wb_rf_wdata;
  assign soc_clk           = SocTop.clk;
  assign debug_wb_pc       = SocTop.cpu_debug_s5_pc;
  assign debug_wb_rf_we    = SocTop.cpu_debug_s5_rf_we;
  assign debug_wb_rf_wnum  = SocTop.cpu_debug_s5_rf_wnum;
  assign debug_wb_rf_wdata = SocTop.cpu_debug_s5_rf_wdata;
  
  // open the trace file;
  integer trace_ref;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, SocTop); 
    trace_ref = $fopen(`TRACE_REF_FILE, "r");
  end
  
  //get reference result in falling edge
  reg        trace_cmp_flag;
  reg        debug_end;
  
  reg [31:0] ref_wb_pc;
  reg [4 :0] ref_wb_rf_wnum;
  reg [31:0] ref_wb_rf_wdata;
  integer a;
  always @(posedge soc_clk)
  begin 
    #1;
    if(|debug_wb_rf_we && debug_wb_rf_wnum!=5'd0 && !debug_end && `CONFREG_OPEN_TRACE && reset_n)
    begin
      trace_cmp_flag=1'b0;
      while (!trace_cmp_flag && !($feof(trace_ref)))
      begin
        a =  $fscanf(trace_ref, "%h %h %h %h", trace_cmp_flag,
                     ref_wb_pc, ref_wb_rf_wnum, ref_wb_rf_wdata);
      end
    end
  end
  
  //wdata[i*8+7 : i*8] is valid, only wehile wen[i] is valid
  wire [31:0] debug_wb_rf_wdata_v;
  wire [31:0] ref_wb_rf_wdata_v;
  assign debug_wb_rf_wdata_v[31:24] = debug_wb_rf_wdata[31:24] & {8{debug_wb_rf_we[3]}};
  assign debug_wb_rf_wdata_v[23:16] = debug_wb_rf_wdata[23:16] & {8{debug_wb_rf_we[2]}};
  assign debug_wb_rf_wdata_v[15: 8] = debug_wb_rf_wdata[15: 8] & {8{debug_wb_rf_we[1]}};
  assign debug_wb_rf_wdata_v[7 : 0] = debug_wb_rf_wdata[7 : 0] & {8{debug_wb_rf_we[0]}};
  assign   ref_wb_rf_wdata_v[31:24] =   ref_wb_rf_wdata[31:24] & {8{debug_wb_rf_we[3]}};
  assign   ref_wb_rf_wdata_v[23:16] =   ref_wb_rf_wdata[23:16] & {8{debug_wb_rf_we[2]}};
  assign   ref_wb_rf_wdata_v[15: 8] =   ref_wb_rf_wdata[15: 8] & {8{debug_wb_rf_we[1]}};
  assign   ref_wb_rf_wdata_v[7 : 0] =   ref_wb_rf_wdata[7 : 0] & {8{debug_wb_rf_we[0]}};
  
  
  //compare result in rsing edge 
  reg debug_wb_err;
  always @(posedge soc_clk)
  begin
    #2;
    if(!reset_n)
    begin
        debug_wb_err <= 1'b0;
    end
    else if(|debug_wb_rf_we && debug_wb_rf_wnum!=5'd0 && !debug_end && `CONFREG_OPEN_TRACE)
    begin
      if (  (debug_wb_pc!==ref_wb_pc) || (debug_wb_rf_wnum!==ref_wb_rf_wnum)
          ||(debug_wb_rf_wdata_v!==ref_wb_rf_wdata_v) )
      begin
        $display("--------------------------------------------------------------");
        $display("[%t] Error!!!",$time);
        $display("    reference: PC = 0x%8h, wb_rf_wnum = 0x%2h, wb_rf_wdata = 0x%8h",
                  ref_wb_pc, ref_wb_rf_wnum, ref_wb_rf_wdata_v);
        $display("    mycpu    : PC = 0x%8h, wb_rf_wnum = 0x%2h, wb_rf_wdata = 0x%8h",
                  debug_wb_pc, debug_wb_rf_wnum, debug_wb_rf_wdata_v);
        $display("--------------------------------------------------------------");
        debug_wb_err <= 1'b1;
        #40;
        $finish;
      end
    end
  end
  
  //monitor numeric display
  reg [7:0] err_count;
  wire [31:0] confreg_num_reg = `CONFREG_NUM_REG;
  reg  [31:0] confreg_num_reg_r;
  always @(posedge soc_clk)
  begin
    confreg_num_reg_r <= confreg_num_reg;
    if (!reset_n)
    begin
      err_count <= 8'd0;
    end
    else if (confreg_num_reg_r != confreg_num_reg && `CONFREG_NUM_MONITOR)
    begin
      if(confreg_num_reg[7:0]!=confreg_num_reg_r[7:0]+1'b1)
      begin
        $display("--------------------------------------------------------------");
        $display("[%t] Error(%d)!!! Occurred in number 8'd%02d Functional Test Point!",$time, err_count, confreg_num_reg[31:24]);
        $display("--------------------------------------------------------------");
        err_count <= err_count + 1'b1;
      end
      else if(confreg_num_reg[31:24]!=confreg_num_reg_r[31:24]+1'b1)
      begin
        $display("--------------------------------------------------------------");
        $display("[%t] Error(%d)!!! Unknown, Functional Test Point numbers are unequal!",$time,err_count);
        $display("--------------------------------------------------------------");
        $display("==============================================================");
        err_count <= err_count + 1'b1;
      end
      else
      begin
        $display("----[%t] Number 8'd%02d Functional Test Point PASS!!!", $time, confreg_num_reg[31:24]);
      end
    end
  end
  
  //monitor test
  initial
  begin
    $timeformat(-9,0," ns",10);
    while(!reset_n) #5;
    $display("==============================================================");
    $display("Test begin!");
  
    #10000;
    while(`CONFREG_NUM_MONITOR)
    begin
      #10000;
      $display ("        [%t] Test is running, debug_wb_pc = 0x%8h",$time, debug_wb_pc);
    end
  end
  
  //模拟串口打印
  wire uart_display;
  wire [7:0] uart_data;
  assign uart_display = `CONFREG_UART_DISPLAY;
  assign uart_data    = `CONFREG_UART_DATA;
  
  always @(posedge soc_clk)
  begin
    if(uart_display)
    begin
      if(uart_data==8'hff)
      begin
        ;//$finish;
      end
      else
      begin
        $write("%c",uart_data);
      end
    end
  end
  
  //test end
  wire global_err = debug_wb_err || (err_count!=8'd0);
  wire test_end = (debug_wb_pc==`END_PC) || (uart_display && uart_data==8'hff);
  always @(posedge soc_clk)
  begin
    if (!reset_n)
    begin
      debug_end <= 1'b0;
    end
    else if(test_end && !debug_end)
    begin
      debug_end <= 1'b1;
      $display("==============================================================");
      $display("Test end!");
      #40;
      $fclose(trace_ref);
      if (global_err)
      begin
        $display("Fail!!!Total %d errors!",err_count);
      end
      else
      begin
        $display("----PASS!!!");
      end
	  $finish;
	end
  end
endmodule : TbTop
