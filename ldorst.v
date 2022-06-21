module ldorst (input mem_r_en,mem_w_en,output ldorst);
assign ldorst = mem_r_en | mem_w_en;
endmodule 