module exe_stage_reg (clk, rst, WB_EN,MEM_R_EN, MEM_W_EN,
ALU_Result, Dest,  
WB_EN_Out,MEM_R_EN_Out,
MEM_W_EN_Out,ALU_Result_Out,Dest_Out,src2,src2_out, freeze);

	input clk, rst, MEM_W_EN, MEM_R_EN, WB_EN,freeze;
	input [3:0]  Dest;
	input [31:0]  ALU_Result,src2;
	output reg MEM_W_EN_Out, MEM_R_EN_Out, WB_EN_Out;
	output reg [3:0]  Dest_Out;
	output reg [31:0]  ALU_Result_Out,src2_out;

	always @(posedge clk, posedge rst) 
	begin
		if (rst) 
			{Dest_Out, ALU_Result_Out, MEM_W_EN_Out, MEM_R_EN_Out, WB_EN_Out,src2_out} <= 71'b0;
		else if(~freeze)
			{src2_out,Dest_Out, ALU_Result_Out, MEM_W_EN_Out, MEM_R_EN_Out, WB_EN_Out} <= {src2,Dest, ALU_Result, MEM_W_EN, MEM_R_EN, WB_EN};
	end

endmodule
