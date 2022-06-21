module cu(input [3:0]opcode,input [1:0]mode,input s,output reg [8:0]controlsignals);
//control signals are {wb_en,mem_r_en,mem_w_en,exe_cmd,b,s}
always @(*)begin 
    controlsignals={8'd0,s};
    case(mode)
      2'b00: begin
        case(opcode)
          4'b1101:{controlsignals[8],controlsignals[5:2]}   = 5'b10001;
          4'b1111:{controlsignals[8],controlsignals[5:2]}   = 5'b11001;
          4'b0100:{controlsignals[8],controlsignals[5:2]}   = 5'b10010;
          4'b0101:{controlsignals[8],controlsignals[5:2]}   = 5'b10011;
          4'b0010:{controlsignals[8],controlsignals[5:2]}   = 5'b10100;
          4'b0110:{controlsignals[8],controlsignals[5:2]}   = 5'b10101;
          4'b0000:{controlsignals[8],controlsignals[5:2]}   = 5'b10110;
          4'b1100:{controlsignals[8],controlsignals[5:2]}   = 5'b10111;
          4'b0001:{controlsignals[8],controlsignals[5:2]}   = 5'b11000;
          4'b1010:{controlsignals[5:2]}   = 4'b0100;
          4'b1000:{controlsignals[5:2]}   = 4'b0110;
        endcase
        end 
      2'b01: begin
        controlsignals[5:2] = 4'b0010;
        case(s)
          1'b1:{controlsignals[8], controlsignals[7], controlsignals[0]} = {3'b110};
          1'b0:{controlsignals[6],controlsignals[0]} = {2'b10};
        endcase
      end
      2'b10:begin
        {controlsignals[1],controlsignals[0]} = 2'b10;
      end
    endcase
      end
endmodule 