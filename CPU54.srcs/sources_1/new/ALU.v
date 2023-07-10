`timescale 1ns / 1ps
module ALU (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] F,
    input  [ 4:0] ALUC,
    output ZF,    // zero
    output CF,    // carry
    output SF,    // sign
    output OF     // overflow
);

  parameter ADD = 5'b00000;
  parameter ADDU = 5'b00001;
  parameter SUB = 5'b00010;
  parameter SUBU = 5'b00011;
  parameter AND = 5'b00100;
  parameter OR = 5'b00101;
  parameter XOR = 5'b00110;
  parameter NOR = 5'b00111;
  parameter SLT = 5'b01000;
  parameter SLTU = 5'b01001;
  parameter SLL = 5'b01010;
  parameter SRL = 5'b01011;
  parameter SRA = 5'b01100;
  parameter SLLV = 5'b01101;
  parameter SRLV = 5'b01110;
  parameter SRAV = 5'b01111;
  parameter LUI = 5'b10000;
  
  reg [32:0] R;
  always @(*) begin
    case (ALUC)
      ADD:  R <= $signed(A) + $signed(B);
      ADDU: R <= A + B;
      SUB:  R <= $signed(A) - $signed(B);
      SUBU: R <= A - B;
      AND:  R <= A & B;
      OR:   R <= A | B;
      XOR:  R <= A ^ B;
      NOR:  R <= ~(A | B);
      SLT:  R <= ($signed(A) - $signed(B));
      SLTU: R <= (A - B);
      SLL:  R <= B << A;
      SRL:  R <= B >> A;
      SRA:  R <= $signed(B) >>> $signed(A);
      SLLV: R <= $signed(B) << A[4:0];
      SRLV: R <= B >> A[4:0];
      SRAV: R <= $signed(B) >>> A[4:0];
      LUI:  R <= {B[15:0], 16'b0};
    endcase
  end
  assign F  = R[31:0];
  assign ZF = (R == 32'b0) ? 1'b1 : 1'b0;
  assign CF = R[32];
  assign OF = R[32];
  assign SF = (ALUC == SLT ? ($signed(A) < $signed(B)) : ((ALUC == SLTU) ? (A < B) : 1'b0));
endmodule
