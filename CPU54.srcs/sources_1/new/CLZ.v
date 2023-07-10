`timescale 1ns / 1ps

module CLZ(
    input  [31:0] CLZ_in,
    output [31:0] CLZ_out,
    input CLZS
    );
    integer i = 0;
    integer count = 0;
    integer flag = 0;
    always @ (CLZ_in) 
    begin
    if(CLZS)
    begin
        count = 0;
        i = 0;
        flag = 0;
        for(i = 31; i>=0; i=i-1)begin
            if(CLZ_in[i]==1'b1)begin
                flag = 1;
            end
            else if(flag == 0)
            begin
                count = count + 1;
            end
        end
    end
    end
    assign CLZ_out = count;

endmodule
