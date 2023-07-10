`timescale 1ns / 1ps

module DIV(
    input [31:0] DIVA,
    input [31:0] DIVB,
    input DIVS,
    output [31:0] DIVR,
    output [31:0] DIVM
    );
    reg [31:0] res;
    reg [31:0] rem;
    always@(*)
    begin
        if(DIVS)
        begin
            res = $signed(DIVA) / $signed(DIVB);
            rem = $signed(DIVA) % $signed(DIVB);
        end
    end
    assign DIVR = res;
    assign DIVM = rem;
endmodule
