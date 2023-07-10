`timescale 1ns / 1ps

module LB(
    input [31:0] LB_in,
    input LBS,
    input [15:0] LB_imm,
    output [31:0] LB_out
    );
    reg [31:0] res;
    always@(*)
    begin
      if(LBS)
      begin
        if(LB_imm%4==0)
        begin
            res = {{24{LB_in[7]}}, LB_in[7:0]};
        end
        else if(LB_imm%4==1)
        begin
            res = {{24{LB_in[15]}}, LB_in[15:8]};
        end
        else if(LB_imm%4==2)
        begin
            res = {{24{LB_in[23]}}, LB_in[23:16]};
        end
        else if(LB_imm%4==3)
        begin
            res = {{24{LB_in[31]}}, LB_in[31:24]};
        end
      end  
    end
    assign LB_out = res;
endmodule
