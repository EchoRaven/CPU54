`timescale 1ns / 1ps

module MUL(
    input [31:0] MULA,
    input [31:0] MULB,
    input MULS,
    output [31:0] MULR
    );
    reg [63:0] res;
    always@(*)
    begin
        res = 0;
        if(MULS)
        begin
            res = $signed(MULA) * $signed(MULB);
        end
    end
    assign MULR = res[31:0];
endmodule
