`timescale 1ns / 1ps

module LHU(
    input [31:0] LHU_in,
    input LHUS,
    input [15:0] LHU_imm,
    output [31:0] LHU_out
    );
    reg [31:0] res;
    always@(*)
    begin
      if(LHUS)
      begin
        if((LHU_imm/2)%2==0)
        begin
            res = {{16{1'b0}}, LHU_in[15:0]};
        end
        else if((LHU_imm/2)%2==1)
        begin
            res = {{16{1'b0}}, LHU_in[31:16]};
        end
      end  
    end
    assign LHU_out = res;
endmodule
