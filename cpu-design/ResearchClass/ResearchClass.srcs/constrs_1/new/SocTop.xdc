# =============================================
#  Copyright (c) 2024-2024 All rights reserved
# =============================================
#  Author  : aytony <anyang@buaa.edu.cn>
#  File    : SocTop.xdc
#  Create  : 2024-7-1
# =============================================

# 时钟和重置
set_property PACKAGE_PIN AC19                                 [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE BACKBONE                   [get_nets  clk]
create_clock -name clk -period 10.000 -waveform {0.000 5.000} [get_ports clk]
set_property IOSTANDARD LVCMOS33                              [get_ports clk]
set_property PACKAGE_PIN Y3                                   [get_ports reset_n]
set_property IOSTANDARD LVCMOS33                              [get_ports reset_n]

# 单色 LED
set_property PACKAGE_PIN K23     [get_ports {led_o[0]}]
set_property PACKAGE_PIN J21     [get_ports {led_o[1]}]
set_property PACKAGE_PIN H23     [get_ports {led_o[2]}]
set_property PACKAGE_PIN J19     [get_ports {led_o[3]}]
set_property PACKAGE_PIN G9      [get_ports {led_o[4]}]
set_property PACKAGE_PIN J26     [get_ports {led_o[5]}]
set_property PACKAGE_PIN J23     [get_ports {led_o[6]}]
set_property PACKAGE_PIN J8      [get_ports {led_o[7]}]
set_property PACKAGE_PIN H8      [get_ports {led_o[8]}]
set_property PACKAGE_PIN G8      [get_ports {led_o[9]}]
set_property PACKAGE_PIN F7      [get_ports {led_o[10]}]
set_property PACKAGE_PIN A4      [get_ports {led_o[11]}]
set_property PACKAGE_PIN A5      [get_ports {led_o[12]}]
set_property PACKAGE_PIN A3      [get_ports {led_o[13]}]
set_property PACKAGE_PIN D5      [get_ports {led_o[14]}]
set_property PACKAGE_PIN H7      [get_ports {led_o[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[*]}]

# 双色 LED
set_property PACKAGE_PIN G7      [get_ports {led_rg0_o[0]}]
set_property PACKAGE_PIN F8      [get_ports {led_rg0_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rg0_o[*]}]
set_property PACKAGE_PIN B5      [get_ports {led_rg1_o[0]}]
set_property PACKAGE_PIN D6      [get_ports {led_rg1_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rg1_o[*]}]

# 七段数码管数据
set_property PACKAGE_PIN C3      [get_ports {num_a_g_o[0]}]
set_property PACKAGE_PIN E6      [get_ports {num_a_g_o[1]}]
set_property PACKAGE_PIN B2      [get_ports {num_a_g_o[2]}]
set_property PACKAGE_PIN B4      [get_ports {num_a_g_o[3]}]
set_property PACKAGE_PIN E5      [get_ports {num_a_g_o[4]}]
set_property PACKAGE_PIN D4      [get_ports {num_a_g_o[5]}]
set_property PACKAGE_PIN A2      [get_ports {num_a_g_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {num_a_g_o[*]}]

# 七段数码管片选
set_property PACKAGE_PIN D3      [get_ports {num_csn_o[7]}]
set_property PACKAGE_PIN D25     [get_ports {num_csn_o[6]}]
set_property PACKAGE_PIN D26     [get_ports {num_csn_o[5]}]
set_property PACKAGE_PIN E25     [get_ports {num_csn_o[4]}]
set_property PACKAGE_PIN E26     [get_ports {num_csn_o[3]}]
set_property PACKAGE_PIN G25     [get_ports {num_csn_o[2]}]
set_property PACKAGE_PIN G26     [get_ports {num_csn_o[1]}]
set_property PACKAGE_PIN H26     [get_ports {num_csn_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {num_csn_o[*]}]

#num_data_o
set_property PACKAGE_PIN U24  [get_ports {num_data_o[0]}]
set_property PACKAGE_PIN U25  [get_ports {num_data_o[1]}]
set_property PACKAGE_PIN U26  [get_ports {num_data_o[2]}]
set_property PACKAGE_PIN V26  [get_ports {num_data_o[3]}]
set_property PACKAGE_PIN W26  [get_ports {num_data_o[4]}]
set_property PACKAGE_PIN AB26 [get_ports {num_data_o[5]}]
set_property PACKAGE_PIN AC26 [get_ports {num_data_o[6]}]
set_property PACKAGE_PIN W25  [get_ports {num_data_o[7]}]
set_property PACKAGE_PIN Y26  [get_ports {num_data_o[8]}]
set_property PACKAGE_PIN Y25  [get_ports {num_data_o[9]}]
set_property PACKAGE_PIN V24  [get_ports {num_data_o[10]}]
set_property PACKAGE_PIN AB25 [get_ports {num_data_o[11]}]
set_property PACKAGE_PIN AA23 [get_ports {num_data_o[12]}]
set_property PACKAGE_PIN V23  [get_ports {num_data_o[13]}]
set_property PACKAGE_PIN W23  [get_ports {num_data_o[14]}]
set_property PACKAGE_PIN Y22  [get_ports {num_data_o[15]}]
set_property PACKAGE_PIN Y23  [get_ports {num_data_o[16]}]
set_property PACKAGE_PIN U22  [get_ports {num_data_o[17]}]
set_property PACKAGE_PIN V22  [get_ports {num_data_o[18]}]
set_property PACKAGE_PIN U21  [get_ports {num_data_o[19]}]
set_property PACKAGE_PIN V21  [get_ports {num_data_o[20]}]
set_property PACKAGE_PIN T20  [get_ports {num_data_o[21]}]
set_property PACKAGE_PIN T19  [get_ports {num_data_o[22]}]
set_property PACKAGE_PIN U15  [get_ports {num_data_o[23]}]
set_property PACKAGE_PIN U16  [get_ports {num_data_o[24]}]
set_property PACKAGE_PIN U14  [get_ports {num_data_o[25]}]
set_property PACKAGE_PIN V14  [get_ports {num_data_o[26]}]
set_property PACKAGE_PIN V16  [get_ports {num_data_o[27]}]
set_property PACKAGE_PIN V17  [get_ports {num_data_o[28]}]
set_property PACKAGE_PIN U17  [get_ports {num_data_o[29]}]
set_property PACKAGE_PIN R7   [get_ports {num_data_o[30]}]
set_property PACKAGE_PIN R6   [get_ports {num_data_o[31]}]
set_property IOSTANDARD LVCMOS33 [get_ports {num_data_o[*]}]

#switch_i
set_property PACKAGE_PIN AC21 [get_ports {switch_i[7]}]
set_property PACKAGE_PIN AD24 [get_ports {switch_i[6]}]
set_property PACKAGE_PIN AC22 [get_ports {switch_i[5]}]
set_property PACKAGE_PIN AC23 [get_ports {switch_i[4]}]
set_property PACKAGE_PIN AB6  [get_ports {switch_i[3]}]
set_property PACKAGE_PIN W6   [get_ports {switch_i[2]}]
set_property PACKAGE_PIN AA7  [get_ports {switch_i[1]}]
set_property PACKAGE_PIN Y6   [get_ports {switch_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch_i[*]}]

#btn_key
set_property PACKAGE_PIN V8  [get_ports {btn_key_col_o[0]}]
set_property PACKAGE_PIN V9  [get_ports {btn_key_col_o[1]}]
set_property PACKAGE_PIN Y8  [get_ports {btn_key_col_o[2]}]
set_property PACKAGE_PIN V7  [get_ports {btn_key_col_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_key_col_o[*]}]
set_property PACKAGE_PIN U7  [get_ports {btn_key_row_i[0]}]
set_property PACKAGE_PIN W8  [get_ports {btn_key_row_i[1]}]
set_property PACKAGE_PIN Y7  [get_ports {btn_key_row_i[2]}]
set_property PACKAGE_PIN AA8 [get_ports {btn_key_row_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_key_row_i[*]}]

#btn_step_i
set_property PACKAGE_PIN Y5 [get_ports {btn_step_i[0]}]
set_property PACKAGE_PIN V6 [get_ports {btn_step_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_step_i[*]}]

