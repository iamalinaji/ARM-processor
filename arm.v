module arm(input clk,rst,output [31:0]SRAM_DQ,output [16:0]SRAM_ADDR,
output SRAM_WE_N);
//if stage...
wire flush,hazard;
wire [31:0]branchaddr,pcoutif,ir;

//id stage...
wire wb_en,mem_r_en,mem_w_en,s,branch_taken,imm,cout,two_src;
wire [3:0]dest_id,statusbits,exe_cmd,src1_hd,src2_hd;
wire [31:0]pcoutid,val_Rmid,val_Rnid;
wire [11:0]shift_operand;
wire [23:0]signed_imm_24;

//exe stage...
wire mem_r_en_exe,mem_w_en_exe,wb_en_exe;
wire [31:0]val_Rm_exe,alu_result;
wire [3:0]dest_exe,statusbit_in;


//mem stage...
wire wb_en_mem,mem_r_en_mem;
wire [31:0]alu_result_mem,mem_out;
wire [3:0]dest_mem;
wire ready;

//wb stage...
wire [3:0]dest_wb;
wire writebacken;
wire [31:0]result_wb;


//for new hazarddetection unit 
wire mem_r_en_id,mem_w_en_id;


// related to forwarding module...
wire forwarding;
wire [1:0] sel_src1,sel_src2;
wire [3:0] src1_fu,src2_fu;




if_stage ifstage(clk,rst,(hazard | ~ready),flush,branchaddr,pcoutif,ir);


id_stage idstage(clk,rst,ir,pcoutif,result_wb,writebacken,dest_wb,hazard,
flush,statusbits,wb_en,mem_r_en,mem_w_en,branch_taken,s,exe_cmd,
pcoutid,val_Rnid,val_Rmid,imm,shift_operand,signed_imm_24,dest_id,
src1_hd,src2_hd,src1_fu,src2_fu,cout,two_src,mem_r_en_id,mem_w_en_id,~ready);

assign flush=branch_taken;



exe_stage exestage(clk,rst,exe_cmd,mem_r_en,mem_w_en,wb_en,pcoutid,
val_Rnid,val_Rmid,imm,shift_operand,signed_imm_24,dest_id,cout,s,wb_en_exe
,mem_r_en_exe,mem_w_en_exe,val_Rm_exe,dest_exe,alu_result,branchaddr
,statusbit_in,sel_src1,sel_src2,result_wb,~ready);


mem_stage memstage(clk,rst,wb_en_exe,mem_r_en_exe,mem_w_en_exe,alu_result,
val_Rm_exe,dest_exe,wb_en_mem,mem_r_en_mem,alu_result_mem,mem_out,dest_mem,ready,
SRAM_DQ,SRAM_ADDR,SRAM_WE_N);


wbstage write_back_stage(clk,rst,mem_r_en_mem,wb_en_mem,dest_mem,
mem_out,alu_result_mem,writebacken,dest_wb,result_wb);

statusregister statusreg(clk,rst,statusbit_in[3],
statusbit_in[2],statusbit_in[1],statusbit_in[0],s,statusbits,~ready);

hazarddetection hd(two_src,src1_hd,src2_hd,dest_id,wb_en,dest_exe,wb_en_exe,hazard,exe_cmd, imm, mem_w_en_id, mem_r_en,forwarding );

forwarding_unit fw(src1_fu,src2_fu,writebacken,wb_en_exe,dest_wb,dest_exe,sel_src1,sel_src2);


endmodule 