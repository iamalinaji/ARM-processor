module SRAM_CU(
   input clk,
  input rst,
  
  input write_en,
  input read_en,
  
  input[31:0] address,
  input[31:0] data,
  
  output[63:0] readData,
  
  output ready,
  
  output[31:0] SRAM_DQ,
  output[16:0] SRAM_ADDR,
  output SRAM_WE_N);
  
  reg[2:0] count;
  wire zero;
  wire[31:0] MSB, LSB;
  
  always@(posedge clk, posedge rst)
  begin
    if(rst)
      count <= 3'b000;
    else if(zero)
      count <= 3'b000;
    else if(write_en | read_en)
      count = count + 1;
    else
      count = 3'b000;
  end
  
  assign SRAM_WE_N = write_en ? 1'b0 :
                     read_en ? 1'b1 : 1'bz;
                     
  assign SRAM_ADDR = (read_en == 1'b1) ? ((count <= 3'b010) ? {address[18:3],1'b0} : {address[18:3],1'b1}) : address[18:2];
  
  assign LSB = (count == 3'b010) ? SRAM_DQ : LSB;
  
  assign MSB = (count == 3'b101) ? SRAM_DQ : MSB;
  
  assign SRAM_DQ = write_en ? data : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
  
  assign readData = {MSB, LSB};
  
  assign ready = (write_en | read_en) ? ((count == 3'b101) ? 1'b1 : 1'b0) : 1'b1;
  
  assign zero = (count == 3'b101) ? 1'b1 : 1'b0;
  
endmodule