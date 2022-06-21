module cache_mem(
  input clk, rst,
  input R_EN, W_EN,
  input[63:0] data,
  input[9:0] tag,
  input[5:0] addr,
  output[63:0] data_out,
  output hit);
  
  reg[63:0] WAY0_DATA[0:63];
  reg[63:0] WAY1_DATA[0:63];
  reg[9:0] WAY0_TAG[0:63];
  reg[9:0] WAY1_TAG[0:63];
  reg WAY0_VALID[0:63];
  reg WAY1_VALID[0:63];
  reg LRU[0:63];
  
  integer i;
  
  always @(posedge clk, posedge rst)
  begin
    //resetting
    if(rst == 1'b1)begin
      for(i = 0; i < 64; i = i+1)begin
        WAY0_DATA[i] = 64'b0;
        WAY1_DATA[i] = 64'b0;
        WAY0_TAG[i] = 10'b0;
        WAY1_TAG[i] = 10'b0;
        WAY0_VALID[i] = 1'b0;
        WAY1_VALID[i] = 1'b0;
        LRU[i] = 1'b1;
      end
    end
    //writing from cpu
    else if(W_EN == 1'b1)begin
      if(WAY0_TAG[addr] == tag)begin
        WAY0_VALID[addr] = 1'b0;
      end
      else if(WAY1_TAG[addr] == tag)begin
        WAY1_VALID[addr] = 1'b0;
      end
    end
    //writing from sram
    else if(R_EN == 1'b1) begin
      if(WAY0_VALID[addr] == 1'b0)begin
        WAY0_DATA[addr] = data;
        WAY0_TAG[addr] = tag;
        WAY0_VALID[addr] = 1'b1;
        LRU[addr] = 1'b0;
      end
      else if(WAY1_VALID[addr] == 1'b0)begin
        WAY1_DATA[addr] = data;
        WAY1_TAG[addr] = tag;
        WAY1_VALID[addr] = 1'b1;
        LRU[addr] = 1'b1;
      end
      else if(LRU[addr] == 1'b0)begin
        WAY1_DATA[addr] = data;
        WAY1_TAG[addr] = tag;
        WAY1_VALID[addr] = 1'b1;
        LRU[addr] = 1'b1;
      end
      else if(LRU[addr] == 1'b1)begin
        WAY0_DATA[addr] = data;
        WAY0_TAG[addr] = tag;
        WAY0_VALID[addr] = 1'b1;
        LRU[addr] = 1'b0;
      end
    end
  end
  
  assign data_out = (WAY0_TAG[addr] == tag && WAY0_VALID[addr] == 1'b1) ? WAY0_DATA[addr]:
                    (WAY1_TAG[addr] == tag && WAY1_VALID[addr] == 1'b1) ? WAY1_DATA[addr]: 
                    64'bzzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz; 
  
  assign hit = ((WAY0_TAG[addr] == tag && WAY0_VALID[addr] == 1'b1) || (WAY1_TAG[addr] == tag && WAY1_VALID[addr] == 1'b1)) ? 1'b1 : 1'b0;  
  
endmodule