module regfile(input clk,rst,
input [3:0]src1,src2,dest_wb,input [31:0]result_wb,
input writebacken, output reg[31:0]reg1,reg2);
reg [31:0] regfile[0:14];
always@(*)begin
    reg1<=regfile[src1];
    reg2<=regfile[src2];
    end
integer i;
always@(posedge rst,negedge clk)begin 
    if (rst)begin
        for (i=0; i<=14 ; i=i+1)begin
        regfile[i]<=i;
        end
    end
    else if(writebacken)
        regfile[dest_wb]<=result_wb;
end
endmodule