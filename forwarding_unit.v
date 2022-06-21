module forwarding_unit (src1,src2,writeBackEn,writeBackEn_EXE_Reg,Dest_wb,Dest_EXE_Reg,sel_src1,sel_src2);
	
input writeBackEn,writeBackEn_EXE_Reg;
input [3:0] src1, src2, Dest_wb,Dest_EXE_Reg;
output [1:0] sel_src1,sel_src2;


 
assign sel_src1 = ((src1 == Dest_EXE_Reg) & (writeBackEn_EXE_Reg) ) ? 2'b01 : ((src1 == Dest_wb) & (writeBackEn) ) ? 2'b10 : 2'b00 ;
    
assign sel_src2 = ((src2 == Dest_EXE_Reg) & (writeBackEn_EXE_Reg) ) ? 2'b01 : ((src2 == Dest_wb) & (writeBackEn) ) ? 2'b10 : 2'b00 ;
   


endmodule
