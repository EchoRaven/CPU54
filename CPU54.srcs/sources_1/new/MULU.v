`timescale 1ns / 1ps

module MULU(
    input [31:0] MULUA,
    input [31:0] MULUB,
    input MULUS,
    output [63:0] MULUR
    );
    reg [63:0] res;
    always@(*)
    begin
        if(MULUS)
        begin
            res = MULUA * MULUB;
        end
    end
    assign MULUR = res;
endmodule
