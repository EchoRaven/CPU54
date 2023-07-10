`timescale 1ns / 1ps

module SB(
    input [31:0] SB_in,
    input [31:0] SB_r,
    input SBS,
    input [15:0] SB_imm,
    output [31:0] SB_out
    );
    reg [31:0] res;
    always@(*)
    begin
        if(SBS)
        begin
            if(SB_imm % 4 == 0)
            begin
                res = {SB_in[31:8], SB_r[7:0]};
            end
            else if(SB_imm % 4 == 1)
            begin
                res = {SB_in[31:16], SB_r[7:0], SB_in[7:0]};
            end
            else if(SB_imm % 4 == 2)
            begin
                res = {SB_in[31:24], SB_r[7:0], SB_in[15:0]};
            end
            else if(SB_imm % 4 == 3)
            begin
                res = {SB_r[7:0], SB_in[23:0]};
            end
        end
    end
    assign SB_out = res;
endmodule
