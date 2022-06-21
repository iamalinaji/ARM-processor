module cumux(input [8:0]incusignals,input bobble,output 
[8:0]outcusignals);
assign outcusignals=(bobble==1'b1)?9'd0:
incusignals;
endmodule