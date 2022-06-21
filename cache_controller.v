module cache_controller(
  input clk, rst,
  
  //memory stage unit
  input[31:0] address,
  input[31:0] wdata,
  input MEM_R_EN,
  input MEM_W_EN,
  output[31:0] rdata,
  output ready,
  
  //SRAM Controller
  output[31:0] sram_address,
  output[31:0] sram_wdata,
  output write,
  output read,
  input[63:0] sram_rdata,
  input sram_ready );
  
  wire hit;
  wire ren, wen;
  wire[63:0] cdata;
  wire[63:0] dtoc;
  
  reg cnt;
  
  always@(posedge clk)
  if(sram_ready == 1'b1 && MEM_W_EN == 1'b1)
    cnt = cnt + 1'b1;
  else
    cnt = 1'b0;
  
  cache_mem cache(clk, rst, ren, wen, dtoc, sram_address[18:9], sram_address[8:3], cdata, hit); 
  
  assign rdata = (address[2] == 1'b1) ? cdata[63:32] : cdata[31:0];
  
  assign dtoc = sram_rdata;
  
  assign sram_address = address;
  
  assign sram_wdata = wdata;

  assign read = (MEM_R_EN == 1'b1 && hit == 1'b0) ? 1'b1 : 1'b0;
  
  assign write = (MEM_W_EN == 1'b1 && cnt == 1'b0) ? 1'b1 : 1'b0;
  
  assign ren = (MEM_R_EN == 1'b1 && sram_ready == 1'b1 && hit == 1'b0) ? 1'b1 : 1'b0;
  
  assign wen = (MEM_W_EN == 1'b1 && sram_ready == 1'b1) ? 1'b1 : 1'b0;
  
  assign ready = ((hit == 1'b1 && (MEM_R_EN == 1'b1)) || (MEM_W_EN && cnt == 1'b1) || (MEM_R_EN == 1'b0 && MEM_W_EN == 1'b0)) ? 1'b1 : 1'b0; 
  
endmodule