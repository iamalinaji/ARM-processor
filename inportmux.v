module inportmux(input [3:0] Rm,Rd,input select,output [3:0]src2);
assign src2=(select==1'b1)?Rd:Rm;
endmodule