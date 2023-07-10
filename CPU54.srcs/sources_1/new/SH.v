`timescale 1ns / 1ps

module SH(
    input [31:0] SH_in,
    input [31:0] SH_r,
    input SHS,
    input [15:0] SH_imm,
    output [31:0] SH_out
    );
    reg [31:0] res;
    always@(*)
    begin
        if(SHS)
        begin
            if((SH_imm/2) % 2 == 0)
            begin
                res = {SH_in[31:16], SH_r[15:0]};
            end
            else if((SH_imm/2) % 2 == 1)
            begin
                res = {SH_r[15:0], SH_in[15:0]};
            end
        end
    end
    assign SH_out = res;
endmodule
