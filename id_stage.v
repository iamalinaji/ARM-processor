module id_stage(input clk,rst,input [31:0] instruction,pc,
input [31:0]result_wb,input writebacken,input [3:0]dest_wb,
input hazard,flush,input [3:0]sr,
output wb_en,mem_r_en,mem_w_en,b,s,
output [3:0]exe_cmd,output [31:0]pcout,val_Rn,val_Rm,output imm,
output [11:0]shift_operand,output [23:0]signed_imm_24,
output [3:0]dest,src1,src2,src1_fu,src2_fu,output cout,two_src,mem_r_en_id,mem_w_en_id,input freeze);
wire [31:0]val_Rn_in,val_Rm_in;
wire [8:0]controlsignals,outcusignals;//control signals are {wb_en,mem_r_en,mem_w_en,exe_cmd,b,s}
wire [3:0]input2regfile;
wire ismet,bobble;
cu controlunit(instruction[24:21],instruction[27:26],instruction[20],
controlsignals);
condcheck conditioncheck(instruction[31:28],sr,ismet);
bobble bobbleinst(ismet,hazard,bobble);
inportmux mux1(instruction[3:0],instruction[15:12],controlsignals[6],input2regfile);
regfile registerfile(clk,rst,instruction[19:16],input2regfile,
dest_wb,result_wb,writebacken,val_Rn_in,val_Rm_in);
cumux mux2(controlsignals,bobble,outcusignals);
id_stage_reg idreg(clk,rst,flush,outcusignals[8],
outcusignals[7],outcusignals[6],outcusignals[1],
outcusignals[0],sr[1],outcusignals[5:2],src1,src2,pc,val_Rn_in,
val_Rm_in,instruction[25],instruction[11:0],instruction[23:0],
instruction[15:12],
wb_en,mem_r_en,mem_w_en,b,s,cout,exe_cmd,pcout,val_Rn,
val_Rm,imm,shift_operand,signed_imm_24,dest,src1_fu,src2_fu,freeze);

assign mem_r_en_id=outcusignals[7];
assign mem_w_en_id=outcusignals[6];
assign two_src=(!instruction[25])||controlsignals[6];
assign src1=instruction[19:16];
assign src2=input2regfile;


endmodule




