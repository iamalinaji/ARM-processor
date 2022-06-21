module alu( val1,val2,exe_cmd,result,cin,status);
input [31:0]val1,val2;
input cin;
input [3:0]exe_cmd;
output [31:0]result;
output [3:0]status;


wire n,z,c,v;
assign status = {n,z,c,v};


assign {c,result}=(exe_cmd==4'b0001)?val2:
    (exe_cmd==4'b1001)?~val2:
    (exe_cmd==4'b0010)? val1+val2:
    (exe_cmd==4'b0011)? val1+val2+cin:
    (exe_cmd==4'b0100)? val1-val2:
    (exe_cmd==4'b0101)? val1 - val2 - {31'b0, ~cin}: 
    (exe_cmd==4'b0110)? val1 & val2 :
    (exe_cmd==4'b0111)? val1 | val2:
    (exe_cmd==4'b1000)? val1 ^ val2:
    32'bz;


assign n=result[31];
assign z=~(|result);

assign v=  ((exe_cmd == 4'b0010) | (exe_cmd == 4'b0011))? 
			(result[31] & ~val1[31] & ~val2[31]) | (~result[31] & val1[31] & val2[31])
		  :((exe_cmd == 4'b0100) | (exe_cmd == 4'b0101))? 
			(result[31] & ~val1[31] & val2[31]) | (~result[31] & val1[31] & ~val2[31])
		  : 1'b0;

endmodule 
