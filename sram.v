`timescale 1ns/1ns
module sram(
  input CLK,
  input RST,
  input SRAM_WE_N,
  input[16:0] SRAM_ADDR,
  inout[31:0] SRAM_DQ
);
  
  reg [31:0] mem[0:512];
  
  assign #3 SRAM_DQ = SRAM_WE_N ? mem[SRAM_ADDR] : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
    
  always @(posedge CLK)
    if (~SRAM_WE_N)
      mem[SRAM_ADDR] = SRAM_DQ;
  
endmodule 