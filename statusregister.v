module statusregister (input clk, rst, N, Z, C, V, S,output reg [3:0] SR
,input freeze);
	
	always @(negedge clk)
	begin
		if (rst) 
			SR <= 4'd0;
		else if (S  && ~(freeze))
			SR <= {N, Z, C, V};
		else
			SR <= SR;
	end
	
endmodule
