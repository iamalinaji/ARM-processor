module mem_stage_reg (clk, rst,ALU_Result,MEM_R_EN,Dest,WB_EN,Mem,
		      Dest_Out,ALU_Result_Out,MEM_R_EN_Out,WB_EN_Out,Mem_Out,freeze);

input clk,rst,MEM_R_EN,WB_EN,freeze;
input [3:0]  Dest;
input [31:0] ALU_Result,Mem;
        
output reg MEM_R_EN_Out,WB_EN_Out;
output reg [3:0]  Dest_Out;
output reg [31:0] Mem_Out,ALU_Result_Out;

always @(posedge clk, posedge rst) 
begin
if (rst) 
{Dest_Out,ALU_Result_Out,MEM_R_EN_Out,WB_EN_Out,Mem_Out} <= 70'b0;
else if(~freeze)
{Dest_Out,ALU_Result_Out,MEM_R_EN_Out,WB_EN_Out,Mem_Out}  <= {Dest,ALU_Result,MEM_R_EN,WB_EN,Mem};
end

endmodule
