###################################################################

# Created by write_sdc on Sun Sep 19 20:27:15 2021

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
create_clock [get_ports CLK]  -period 0.714  -waveform {0 0.357}
set_max_delay 0.714  -from [list [get_ports CLK] [get_ports RST] [get_ports IRAM_READY] [get_ports \
{IRAM_DATA[63]}] [get_ports {IRAM_DATA[62]}] [get_ports {IRAM_DATA[61]}]       \
[get_ports {IRAM_DATA[60]}] [get_ports {IRAM_DATA[59]}] [get_ports             \
{IRAM_DATA[58]}] [get_ports {IRAM_DATA[57]}] [get_ports {IRAM_DATA[56]}]       \
[get_ports {IRAM_DATA[55]}] [get_ports {IRAM_DATA[54]}] [get_ports             \
{IRAM_DATA[53]}] [get_ports {IRAM_DATA[52]}] [get_ports {IRAM_DATA[51]}]       \
[get_ports {IRAM_DATA[50]}] [get_ports {IRAM_DATA[49]}] [get_ports             \
{IRAM_DATA[48]}] [get_ports {IRAM_DATA[47]}] [get_ports {IRAM_DATA[46]}]       \
[get_ports {IRAM_DATA[45]}] [get_ports {IRAM_DATA[44]}] [get_ports             \
{IRAM_DATA[43]}] [get_ports {IRAM_DATA[42]}] [get_ports {IRAM_DATA[41]}]       \
[get_ports {IRAM_DATA[40]}] [get_ports {IRAM_DATA[39]}] [get_ports             \
{IRAM_DATA[38]}] [get_ports {IRAM_DATA[37]}] [get_ports {IRAM_DATA[36]}]       \
[get_ports {IRAM_DATA[35]}] [get_ports {IRAM_DATA[34]}] [get_ports             \
{IRAM_DATA[33]}] [get_ports {IRAM_DATA[32]}] [get_ports {IRAM_DATA[31]}]       \
[get_ports {IRAM_DATA[30]}] [get_ports {IRAM_DATA[29]}] [get_ports             \
{IRAM_DATA[28]}] [get_ports {IRAM_DATA[27]}] [get_ports {IRAM_DATA[26]}]       \
[get_ports {IRAM_DATA[25]}] [get_ports {IRAM_DATA[24]}] [get_ports             \
{IRAM_DATA[23]}] [get_ports {IRAM_DATA[22]}] [get_ports {IRAM_DATA[21]}]       \
[get_ports {IRAM_DATA[20]}] [get_ports {IRAM_DATA[19]}] [get_ports             \
{IRAM_DATA[18]}] [get_ports {IRAM_DATA[17]}] [get_ports {IRAM_DATA[16]}]       \
[get_ports {IRAM_DATA[15]}] [get_ports {IRAM_DATA[14]}] [get_ports             \
{IRAM_DATA[13]}] [get_ports {IRAM_DATA[12]}] [get_ports {IRAM_DATA[11]}]       \
[get_ports {IRAM_DATA[10]}] [get_ports {IRAM_DATA[9]}] [get_ports              \
{IRAM_DATA[8]}] [get_ports {IRAM_DATA[7]}] [get_ports {IRAM_DATA[6]}]          \
[get_ports {IRAM_DATA[5]}] [get_ports {IRAM_DATA[4]}] [get_ports               \
{IRAM_DATA[3]}] [get_ports {IRAM_DATA[2]}] [get_ports {IRAM_DATA[1]}]          \
[get_ports {IRAM_DATA[0]}] [get_ports DRAM_READY] [get_ports {DRAM_DATA[63]}]  \
[get_ports {DRAM_DATA[62]}] [get_ports {DRAM_DATA[61]}] [get_ports             \
{DRAM_DATA[60]}] [get_ports {DRAM_DATA[59]}] [get_ports {DRAM_DATA[58]}]       \
[get_ports {DRAM_DATA[57]}] [get_ports {DRAM_DATA[56]}] [get_ports             \
{DRAM_DATA[55]}] [get_ports {DRAM_DATA[54]}] [get_ports {DRAM_DATA[53]}]       \
[get_ports {DRAM_DATA[52]}] [get_ports {DRAM_DATA[51]}] [get_ports             \
{DRAM_DATA[50]}] [get_ports {DRAM_DATA[49]}] [get_ports {DRAM_DATA[48]}]       \
[get_ports {DRAM_DATA[47]}] [get_ports {DRAM_DATA[46]}] [get_ports             \
{DRAM_DATA[45]}] [get_ports {DRAM_DATA[44]}] [get_ports {DRAM_DATA[43]}]       \
[get_ports {DRAM_DATA[42]}] [get_ports {DRAM_DATA[41]}] [get_ports             \
{DRAM_DATA[40]}] [get_ports {DRAM_DATA[39]}] [get_ports {DRAM_DATA[38]}]       \
[get_ports {DRAM_DATA[37]}] [get_ports {DRAM_DATA[36]}] [get_ports             \
{DRAM_DATA[35]}] [get_ports {DRAM_DATA[34]}] [get_ports {DRAM_DATA[33]}]       \
[get_ports {DRAM_DATA[32]}] [get_ports {DRAM_DATA[31]}] [get_ports             \
{DRAM_DATA[30]}] [get_ports {DRAM_DATA[29]}] [get_ports {DRAM_DATA[28]}]       \
[get_ports {DRAM_DATA[27]}] [get_ports {DRAM_DATA[26]}] [get_ports             \
{DRAM_DATA[25]}] [get_ports {DRAM_DATA[24]}] [get_ports {DRAM_DATA[23]}]       \
[get_ports {DRAM_DATA[22]}] [get_ports {DRAM_DATA[21]}] [get_ports             \
{DRAM_DATA[20]}] [get_ports {DRAM_DATA[19]}] [get_ports {DRAM_DATA[18]}]       \
[get_ports {DRAM_DATA[17]}] [get_ports {DRAM_DATA[16]}] [get_ports             \
{DRAM_DATA[15]}] [get_ports {DRAM_DATA[14]}] [get_ports {DRAM_DATA[13]}]       \
[get_ports {DRAM_DATA[12]}] [get_ports {DRAM_DATA[11]}] [get_ports             \
{DRAM_DATA[10]}] [get_ports {DRAM_DATA[9]}] [get_ports {DRAM_DATA[8]}]         \
[get_ports {DRAM_DATA[7]}] [get_ports {DRAM_DATA[6]}] [get_ports               \
{DRAM_DATA[5]}] [get_ports {DRAM_DATA[4]}] [get_ports {DRAM_DATA[3]}]          \
[get_ports {DRAM_DATA[2]}] [get_ports {DRAM_DATA[1]}] [get_ports               \
{DRAM_DATA[0]}]]  -to [list [get_ports {IRAM_ADDRESS[31]}] [get_ports {IRAM_ADDRESS[30]}]       \
[get_ports {IRAM_ADDRESS[29]}] [get_ports {IRAM_ADDRESS[28]}] [get_ports       \
{IRAM_ADDRESS[27]}] [get_ports {IRAM_ADDRESS[26]}] [get_ports                  \
{IRAM_ADDRESS[25]}] [get_ports {IRAM_ADDRESS[24]}] [get_ports                  \
{IRAM_ADDRESS[23]}] [get_ports {IRAM_ADDRESS[22]}] [get_ports                  \
{IRAM_ADDRESS[21]}] [get_ports {IRAM_ADDRESS[20]}] [get_ports                  \
{IRAM_ADDRESS[19]}] [get_ports {IRAM_ADDRESS[18]}] [get_ports                  \
{IRAM_ADDRESS[17]}] [get_ports {IRAM_ADDRESS[16]}] [get_ports                  \
{IRAM_ADDRESS[15]}] [get_ports {IRAM_ADDRESS[14]}] [get_ports                  \
{IRAM_ADDRESS[13]}] [get_ports {IRAM_ADDRESS[12]}] [get_ports                  \
{IRAM_ADDRESS[11]}] [get_ports {IRAM_ADDRESS[10]}] [get_ports                  \
{IRAM_ADDRESS[9]}] [get_ports {IRAM_ADDRESS[8]}] [get_ports {IRAM_ADDRESS[7]}] \
[get_ports {IRAM_ADDRESS[6]}] [get_ports {IRAM_ADDRESS[5]}] [get_ports         \
{IRAM_ADDRESS[4]}] [get_ports {IRAM_ADDRESS[3]}] [get_ports {IRAM_ADDRESS[2]}] \
[get_ports {IRAM_ADDRESS[1]}] [get_ports {IRAM_ADDRESS[0]}] [get_ports         \
IRAM_ISSUE] [get_ports {DRAM_ADDRESS[31]}] [get_ports {DRAM_ADDRESS[30]}]      \
[get_ports {DRAM_ADDRESS[29]}] [get_ports {DRAM_ADDRESS[28]}] [get_ports       \
{DRAM_ADDRESS[27]}] [get_ports {DRAM_ADDRESS[26]}] [get_ports                  \
{DRAM_ADDRESS[25]}] [get_ports {DRAM_ADDRESS[24]}] [get_ports                  \
{DRAM_ADDRESS[23]}] [get_ports {DRAM_ADDRESS[22]}] [get_ports                  \
{DRAM_ADDRESS[21]}] [get_ports {DRAM_ADDRESS[20]}] [get_ports                  \
{DRAM_ADDRESS[19]}] [get_ports {DRAM_ADDRESS[18]}] [get_ports                  \
{DRAM_ADDRESS[17]}] [get_ports {DRAM_ADDRESS[16]}] [get_ports                  \
{DRAM_ADDRESS[15]}] [get_ports {DRAM_ADDRESS[14]}] [get_ports                  \
{DRAM_ADDRESS[13]}] [get_ports {DRAM_ADDRESS[12]}] [get_ports                  \
{DRAM_ADDRESS[11]}] [get_ports {DRAM_ADDRESS[10]}] [get_ports                  \
{DRAM_ADDRESS[9]}] [get_ports {DRAM_ADDRESS[8]}] [get_ports {DRAM_ADDRESS[7]}] \
[get_ports {DRAM_ADDRESS[6]}] [get_ports {DRAM_ADDRESS[5]}] [get_ports         \
{DRAM_ADDRESS[4]}] [get_ports {DRAM_ADDRESS[3]}] [get_ports {DRAM_ADDRESS[2]}] \
[get_ports {DRAM_ADDRESS[1]}] [get_ports {DRAM_ADDRESS[0]}] [get_ports         \
DRAM_ISSUE] [get_ports DRAM_READNOTWRITE] [get_ports {DRAM_DATA[63]}]          \
[get_ports {DRAM_DATA[62]}] [get_ports {DRAM_DATA[61]}] [get_ports             \
{DRAM_DATA[60]}] [get_ports {DRAM_DATA[59]}] [get_ports {DRAM_DATA[58]}]       \
[get_ports {DRAM_DATA[57]}] [get_ports {DRAM_DATA[56]}] [get_ports             \
{DRAM_DATA[55]}] [get_ports {DRAM_DATA[54]}] [get_ports {DRAM_DATA[53]}]       \
[get_ports {DRAM_DATA[52]}] [get_ports {DRAM_DATA[51]}] [get_ports             \
{DRAM_DATA[50]}] [get_ports {DRAM_DATA[49]}] [get_ports {DRAM_DATA[48]}]       \
[get_ports {DRAM_DATA[47]}] [get_ports {DRAM_DATA[46]}] [get_ports             \
{DRAM_DATA[45]}] [get_ports {DRAM_DATA[44]}] [get_ports {DRAM_DATA[43]}]       \
[get_ports {DRAM_DATA[42]}] [get_ports {DRAM_DATA[41]}] [get_ports             \
{DRAM_DATA[40]}] [get_ports {DRAM_DATA[39]}] [get_ports {DRAM_DATA[38]}]       \
[get_ports {DRAM_DATA[37]}] [get_ports {DRAM_DATA[36]}] [get_ports             \
{DRAM_DATA[35]}] [get_ports {DRAM_DATA[34]}] [get_ports {DRAM_DATA[33]}]       \
[get_ports {DRAM_DATA[32]}] [get_ports {DRAM_DATA[31]}] [get_ports             \
{DRAM_DATA[30]}] [get_ports {DRAM_DATA[29]}] [get_ports {DRAM_DATA[28]}]       \
[get_ports {DRAM_DATA[27]}] [get_ports {DRAM_DATA[26]}] [get_ports             \
{DRAM_DATA[25]}] [get_ports {DRAM_DATA[24]}] [get_ports {DRAM_DATA[23]}]       \
[get_ports {DRAM_DATA[22]}] [get_ports {DRAM_DATA[21]}] [get_ports             \
{DRAM_DATA[20]}] [get_ports {DRAM_DATA[19]}] [get_ports {DRAM_DATA[18]}]       \
[get_ports {DRAM_DATA[17]}] [get_ports {DRAM_DATA[16]}] [get_ports             \
{DRAM_DATA[15]}] [get_ports {DRAM_DATA[14]}] [get_ports {DRAM_DATA[13]}]       \
[get_ports {DRAM_DATA[12]}] [get_ports {DRAM_DATA[11]}] [get_ports             \
{DRAM_DATA[10]}] [get_ports {DRAM_DATA[9]}] [get_ports {DRAM_DATA[8]}]         \
[get_ports {DRAM_DATA[7]}] [get_ports {DRAM_DATA[6]}] [get_ports               \
{DRAM_DATA[5]}] [get_ports {DRAM_DATA[4]}] [get_ports {DRAM_DATA[3]}]          \
[get_ports {DRAM_DATA[2]}] [get_ports {DRAM_DATA[1]}] [get_ports               \
{DRAM_DATA[0]}]]
