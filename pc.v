module pc(input [31:0]pcin,input clk,rst,freeze,output reg[31:0]pc);
always @(posedge clk , posedge rst)begin 
if(rst)pc<=32'd0;
else if (~freeze)pc<=pcin;
end
endmodule