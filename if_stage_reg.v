module if_stage_reg(input clk,rst,freeze,flush,input[31:0]newpc,
ir,output reg [31:0]pc,instruction);

always @(posedge clk , posedge rst )begin 
	if (rst)begin 
	pc<=32'd4;
	instruction<=32'd0;
	end
	else if(flush)begin 
	instruction<=32'b0;
	pc<=32'd0;
	end 
	else if (~freeze) begin 
	pc<=newpc;
	instruction<=ir;
	end 
end
endmodule
