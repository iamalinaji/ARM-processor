module exe_stage(clk,rst,exe_cmd,mem_r_en_in,mem_w_en_in,wb_en_in,pc,
val_Rn_in,val_Rm_in,imm,shift_operand,signed_imm_24,dest_in,c_in,s_bit,
wb_en,mem_r_en,mem_w_en,src2_out,dest_out,
alu_result,br_addr,status,sel_src1,sel_src2,wb_result,freeze);
input clk,rst,mem_r_en_in,mem_w_en_in,imm,wb_en_in;
input [3:0]dest_in,exe_cmd;
input [31:0]pc,val_Rn_in,val_Rm_in;
input [11:0] shift_operand;
input [23:0] signed_imm_24;
input c_in,s_bit,freeze;
input [31:0] wb_result;
input [1:0] sel_src1,sel_src2;
output wb_en,mem_r_en,mem_w_en;
output [31:0]alu_result,br_addr,src2_out;
output [3:0]status,dest_out;


wire ldorst,cout;
wire [31:0]add_sign_ex,alu_result_in;
wire [31:0]add_in,val2;
wire [31:0] src1,src2;

assign add_sign_ex=({{8{signed_imm_24[23]}} , signed_imm_24}+32'd1);
assign add_in=add_sign_ex << 2 ;
assign br_addr = (({{8{signed_imm_24[23]}} , signed_imm_24}) << 2) + pc;

ldorst m1(mem_r_en_in,mem_w_en_in,ldorst);
val2gen val_gen(shift_operand,src2,ldorst,imm,val2);
alu ALU(src1,val2,exe_cmd,alu_result_in,c_in,status);
exe_stage_reg exe_reg(clk,rst,wb_en_in,mem_r_en_in,mem_w_en_in,alu_result_in,
dest_in,wb_en,mem_r_en,mem_w_en,alu_result,dest_out,src2,src2_out,freeze);

assign src1 = (sel_src1 == 2'd0) ? val_Rn_in :
              (sel_src1 == 2'd1) ? alu_result :
              (sel_src1 == 2'd2) ? wb_result : 32'bz;
assign src2 = (sel_src2 == 2'd0) ? val_Rm_in :
              (sel_src2 == 2'd1) ? alu_result :
              (sel_src2 == 2'd2) ? wb_result : 32'bz;


endmodule 