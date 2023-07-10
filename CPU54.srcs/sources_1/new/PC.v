`timescale 1ns / 1ps
module PC (
    input         clk,
    input         rst,
    input         ena,
    input  [31:0] Din,
    output [31:0] Dout
);
  reg [31:0] instr_pos;
  
  always @(negedge clk or posedge rst) begin
    if (ena) begin
      if (rst) begin
        instr_pos <= 32'h00400000;
      end 
      else begin
        instr_pos <= Din;
      end
    end
  end
  assign Dout = instr_pos;

endmodule
