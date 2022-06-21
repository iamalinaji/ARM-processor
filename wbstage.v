module wbstage (clk, rst, MEM_R_EN,wb_en_in,dest_in, Mem_Result, ALU_Result,wb_en,dest,out);

input clk, rst, MEM_R_EN,wb_en_in;
input [3:0]dest_in;
input  [31:0] Mem_Result,ALU_Result;
output [31:0] out;
output [3:0]dest;
output wb_en;

assign out = (MEM_R_EN==1'b1) ? Mem_Result : ALU_Result;
assign {wb_en,dest}={wb_en_in,dest_in};


endmodule