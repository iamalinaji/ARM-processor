module mem_stage(clk,rst,wb_en_in,mem_r_en_in,
mem_w_en,alu_result_in,val_Rm,dest_in,wb_en,mem_r_en,
alu_result,mem,dest,ready,SRAM_DQ,SRAM_ADDR,SRAM_WE_N);
input clk,rst,wb_en_in,mem_r_en_in,mem_w_en;
input [31:0]alu_result_in,val_Rm;
input [3:0]dest_in;
output wb_en,mem_r_en;
output [3:0]dest;
output [31:0]mem,alu_result;


output ready;


output [31:0] SRAM_DQ;    
output [16:0] SRAM_ADDR;
output  SRAM_WE_N;     



wire [31:0]cache_rdata;
wire [31:0]sram_address;
wire [31:0]sram_wdata;
wire write;
wire read;
wire [63:0]sram_rdata;
wire sram_ready;



cache_controller cache_cu(clk,rst,alu_result_in,val_Rm,
mem_r_en_in,mem_w_en,cache_rdata,ready,sram_address,
sram_wdata,write,read,sram_rdata,sram_ready);


SRAM_CU sramcontroller(clk,rst,write,read,sram_address,
sram_wdata,sram_rdata,sram_ready,SRAM_DQ,SRAM_ADDR,SRAM_WE_N);	

mem_stage_reg msr(clk,rst,alu_result_in,mem_r_en_in,
dest_in,wb_en_in,cache_rdata,dest,alu_result,mem_r_en,wb_en,mem,~ready);



endmodule