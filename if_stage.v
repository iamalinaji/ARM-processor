module if_stage(input clk,rst,freeze,branch_taken,
input [31:0]branchaddr,output [31:0]pcout,instruction);
wire [31:0] pcin,pc,ir,newpc;
adder add(pc,newpc);
if_mux mux(newpc,branchaddr,branch_taken,pcin);
pc ifpc(pcin,clk,rst,freeze,pc);
ir ifir(pc,ir);
if_stage_reg ifreg(clk,rst,freeze,branch_taken,newpc,ir,pcout,instruction);
endmodule