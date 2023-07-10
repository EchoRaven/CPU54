`timescale 1ns / 1ps

module LO(
    input [31:0]  LO_in,
    input         LOWS,
    input         LORS,
    output [31:0] LO_out,
    input         clk
    );
    reg [31:0] LO_reg;
    always@(negedge clk)
    begin
        if(LOWS)
        begin
            LO_reg = LO_in;
        end
    end
    assign LO_out = LORS ? LO_reg : 31'bz;
endmodule
