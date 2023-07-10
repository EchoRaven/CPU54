`timescale 1ns / 1ps

module HI(
    input [31:0]  HI_in,
    input         HIRS,
    input         HIWS,
    output [31:0] HI_out,
    input         clk
    );
    reg [31:0] HI_reg;
    always@(negedge clk)
    begin
        if(HIWS)
        begin
            HI_reg = HI_in;
        end
    end
    assign HI_out = HIRS ? HI_reg : 31'bz;
endmodule
