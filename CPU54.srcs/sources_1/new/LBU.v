`timescale 1ns / 1ps

module LBU(
    input [31:0] LBU_in,
    input LBUS,
    input [15:0] LBU_imm,
    output [31:0] LBU_out
    );
    reg [31:0] res;
    always@(*)
    begin
      if(LBUS)
      begin
        if(LBU_imm%4==0)
        begin
            res = {{24{1'b0}}, LBU_in[7:0]};
        end
        else if(LBU_imm%4==1)
        begin
            res = {{24{1'b0}}, LBU_in[15:8]};
        end
        else if(LBU_imm%4==2)
        begin
            res = {{24{1'b0}}, LBU_in[23:16]};
        end
        else if(LBU_imm%4==3)
        begin
            res = {{24{1'b0}}, LBU_in[31:24]};
        end
      end  
    end
    assign LBU_out = res;
endmodule
