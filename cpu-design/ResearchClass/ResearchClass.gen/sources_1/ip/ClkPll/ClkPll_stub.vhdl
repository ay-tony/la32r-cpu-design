-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
-- Date        : Mon Jul  8 06:40:38 2024
-- Host        : laptop-mach running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/shuij/Documents/Projects/CpuDesign/ResearchClass/ResearchClass.gen/sources_1/ip/ClkPll/ClkPll_stub.vhdl
-- Design      : ClkPll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg676-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClkPll is
  Port ( 
    clk_out : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end ClkPll;

architecture stub of ClkPll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,clk_in1";
begin
end;
