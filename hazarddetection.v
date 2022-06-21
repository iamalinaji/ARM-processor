module hazarddetection(two_src,src1,src2,exe_dest,exe_wb_en,
mem_dest,mem_wb_en,hazard_detected,exe_cmd,imm, mem_w_en,id_exe_mem_r_en,forwarding);

input two_src,exe_wb_en,mem_wb_en,imm, mem_w_en,id_exe_mem_r_en,forwarding;
input [3:0]src1,src2,exe_dest,mem_dest,exe_cmd;
output reg hazard_detected;


//assign hazard_detected=((src1==exe_dest)   &&  (exe_wb_en==1'b1))||  
//                        ((src1==mem_dest)  &&  (mem_wb_en==1'b1))||
//                        ((src2==exe_dest)  &&  (exe_wb_en==1'b1)  &&(two_src==1'b1))||
//                        ((src2==mem_dest)  &&   (mem_wb_en==1'b1)  &&(two_src==1'b1));

	always @(*) begin
	if(!forwarding) begin	
		if(exe_wb_en & (src1 == exe_dest) & (exe_cmd != 4'b1001) & (exe_cmd != 4'b0001)) hazard_detected = 1'b1;
		else if(mem_wb_en & (src1 == mem_dest) & (exe_cmd != 4'b1001) & (exe_cmd != 4'b0001)) hazard_detected = 1'b1;
		else if(exe_wb_en & (src2 == exe_dest) & (~imm) & (~mem_w_en)) hazard_detected = 1'b1;
		else if(mem_wb_en & (src2 == mem_dest) & (~imm) & (~mem_w_en)) hazard_detected = 1'b1;
		else hazard_detected = 1'b0;
		end
	else if(forwarding)
		begin
		if ( (id_exe_mem_r_en && (exe_dest == src1)) | ( id_exe_mem_r_en && (exe_dest == src2) ))  hazard_detected = 1'b1;
		else hazard_detected = 1'b0;
		end
	else hazard_detected=1'b0;
	end

endmodule