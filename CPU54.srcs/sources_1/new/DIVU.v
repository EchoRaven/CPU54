`timescale 1ns / 1ps

module DIVU(
    input [31:0] DIVUA,
    input [31:0] DIVUB,
    input DIVUS,
    output [31:0] DIVUR,
    output [31:0] DIVUM
    );
    reg [31:0] res;
    reg [31:0] rem;
    always@(*)
    begin
        if(DIVUS)
        begin
            res = DIVUA / DIVUB;
            rem = DIVUA % DIVUB;
        end
    end
    assign DIVUR = res;
    assign DIVUM = rem;
endmodule
