module id_stage_reg(input clk,rst,flush,
wb_en_in,mem_r_en_in,mem_w_en_in,b_in,s_in,cin,
input [3:0]exe_cmd_in,tempsrc1,tempsrc2,input [31:0]pc_in,
input [31:0]val_Rn_in,val_Rm_in,input imm_in,
input [11:0]shift_operand_in,
input [23:0]signed_imm_24_in,input [3:0]dest_in,
output reg wb_en,mem_r_en,mem_w_en,b,s,cout,
output reg [3:0]exe_cmd,
output reg [31:0]pc,
output reg [31:0]val_Rn,val_Rm,
output reg imm,
output reg [11:0]shift_operand,
output reg [23:0]signed_imm_24,
output reg [3:0]dest,src1_fu,src2_fu,input freeze);
always @(posedge clk, posedge rst)begin 
    if(rst)
        {wb_en,mem_r_en,mem_w_en,b,s,exe_cmd,pc,val_Rn,val_Rm,imm,shift_operand,signed_imm_24,dest,cout,src1_fu,src2_fu}=154'd0;
    else if (flush)
        {wb_en,mem_r_en,mem_w_en,b,s,exe_cmd,pc,val_Rn,val_Rm,imm,shift_operand,signed_imm_24,dest,cout,src1_fu,src2_fu}=154'd0;
    else if(~freeze)
        {wb_en,mem_r_en,mem_w_en,b,s,exe_cmd,pc,val_Rn,val_Rm,imm,shift_operand,signed_imm_24,dest,cout,src1_fu,src2_fu}<={wb_en_in,mem_r_en_in,mem_w_en_in,b_in,s_in,exe_cmd_in
        ,pc_in,val_Rn_in,val_Rm_in,imm_in,shift_operand_in,signed_imm_24_in,dest_in,cin,tempsrc1,tempsrc2};
end
endmodule
