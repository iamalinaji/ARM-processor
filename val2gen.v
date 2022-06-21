module val2gen  (shift_operand,Val_Rm,ldorst,I,Val2);
 
input ldorst,I; 
input [11:0] shift_operand;
input [31:0]  Val_Rm;
output reg [31:0] Val2;

  reg [63:0] rotate_wire;
  reg [63:0] immd;
  reg [4:0] shift_im;
  reg [4:0] rotate_im;

always@(shift_operand,I,Val_Rm,ldorst)

  begin
    immd = {{24{shift_operand[7]}} , shift_operand[7:0] , {24{shift_operand[7]}} , shift_operand[7:0]};
    rotate_im = {shift_operand[11:8] , 1'b0};
    rotate_wire = {Val_Rm , Val_Rm};
    shift_im = shift_operand[11:7];
    if(ldorst == 1'b1) begin
      Val2 <= {{20{shift_operand[11]}}, shift_operand};
    end
    else if(I == 1'b0 && shift_operand[4] == 1'b0) begin
      case(shift_operand[6:5])
        2'b00 : Val2 <= (Val_Rm << shift_operand[11:7]);
        2'b01 : Val2 <= (Val_Rm >> shift_operand[11:7]);
        2'b10 : Val2 <= (Val_Rm >>> shift_operand[11:7]);
        2'b11 : Val2 <= (rotate_wire[shift_im+31-:32]);
      endcase
    end
    else if(I == 1'b1) begin      
      Val2 <= immd[rotate_im+31-:32];
    end
  end
    
   
endmodule
