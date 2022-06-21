module condcheck(input [3:0]cond,input [3:0]statusreg,output reg ismet);
// Note that order of s is ={N,z,c,v}...
wire n,z,c,v;
assign {n,z,c,v}=statusreg;
always @(*)begin 
if (cond==4'b0000)ismet=z;
else if (cond==4'b0001)ismet=~z;
else if(cond==4'b0010)ismet=c;
else if (cond==4'b0011)ismet=~c;
else if(cond==4'b0100)ismet=n;
else if (cond==4'b0101)ismet=~n;
else if (cond==4'b0110)ismet=v;
else if (cond==4'b0111)ismet=~v;
else if (cond==4'b1000)ismet=c & ~z;
else if (cond==4'b1001)ismet=~c & z;
else if (cond==4'b1010)ismet=n ~^v;
else if (cond==4'b1011)ismet=n^v;
else if (cond==4'b1100)ismet=~z&(n~^ v);
else if (cond==4'b1101)ismet=z&(n^v);
else if (cond==4'b1110)ismet=1'b1;
else ismet=1'b0;
end
endmodule