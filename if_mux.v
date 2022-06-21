module if_mux(input [31:0]newpc,input [31:0]branchaddr,input branchtaken,output [31:0]pcin);
assign pcin=(branchtaken==1'b1)?branchaddr:
newpc;
endmodule


