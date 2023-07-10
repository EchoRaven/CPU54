`timescale 1ns / 1ps

module LH(
    input [31:0] LH_in,
    input LHS,
    input [15:0] LH_imm,
    output [31:0] LH_out
    );
    reg [31:0] res;
    always@(*)
    begin
      if(LHS)
      begin
        if((LH_imm/2)%2==0)
        begin
            res = {{16{LH_in[15]}}, LH_in[15:0]};
        end
        else if((LH_imm/2)%2==1)
        begin
            res = {{16{LH_in[31]}}, LH_in[31:16]};
        end
      end  
    end
    assign LH_out = res;
endmodule
