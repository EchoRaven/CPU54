`timescale 1ns / 1ps

module CP0(
    input clk,
    input rst,
    input ena,
    input MFCS,  
    input MTCS,  
    input ERETS, 
    input [31:0] PC,
    input [4:0] addr,
    input [31:0] Wdata,
    input [4:0] cause,
    output [31:0] CP0_out,
    output [31:0] EPC_out
    );
    
    parameter SYSCALL = 5'b01000,   //SYSCALL
              BREAK   = 5'b01001,   //BREAK
              TEQ     = 5'b01101;   //TEQ
     
    parameter STATUS = 4'd12,   // STATUS �Ĵ���         
              CAUSE  = 4'd13,   // CAUSE �Ĵ���
              EPC    = 4'd14;   // EPC �Ĵ���
              
    reg [31:0] CP0_reg [31:0];  // CP0 �Ĵ�����
    
    assign CP0_out = ena && MFCS ? CP0_reg[addr] : 32'bz;
    assign EPC_out = ena && ERETS ? CP0_reg[EPC] : 32'bz;
    
    always @(posedge clk or posedge rst) begin
        if(ena) begin
            if(rst) begin
                CP0_reg[00] = 0;
                CP0_reg[01] = 0;
                CP0_reg[02] = 0;
                CP0_reg[03] = 0;
                CP0_reg[04] = 0;
                CP0_reg[05] = 0;
                CP0_reg[06] = 0;
                CP0_reg[07] = 0;
                CP0_reg[08] = 0;
                CP0_reg[09] = 0;
                CP0_reg[10] = 0;
                CP0_reg[11] = 0;
                CP0_reg[12] = 0;
                CP0_reg[13] = 0;
                CP0_reg[14] = 0;
                CP0_reg[15] = 0;
                CP0_reg[16] = 0;
                CP0_reg[17] = 0;
                CP0_reg[18] = 0;
                CP0_reg[19] = 0;
                CP0_reg[20] = 0;
                CP0_reg[21] = 0;
                CP0_reg[22] = 0;
                CP0_reg[23] = 0;
                CP0_reg[24] = 0;
                CP0_reg[25] = 0;
                CP0_reg[26] = 0;
                CP0_reg[27] = 0;
                CP0_reg[28] = 0;
                CP0_reg[29] = 0;
                CP0_reg[30] = 0;
                CP0_reg[31] = 0;
            end
            else begin
                if(MTCS) begin  // д
                    CP0_reg[addr] = Wdata;
                end
                else if(cause == SYSCALL || cause == BREAK || cause == TEQ) begin
                    CP0_reg[STATUS] = CP0_reg[STATUS] << 5;     // ���� STATUS �Ĵ���
                    CP0_reg[EPC]    = PC;                       // ����ǰ PC ���� EPC ��
                    CP0_reg[cause][6:2]  = cause;               // �� cause ���� CAUSE �ε���
                end
                else if(ERETS) begin     // ϵͳ���÷���
                    CP0_reg[STATUS] = CP0_reg[STATUS] >> 5;     // ���ƻָ� STATUS 
//                    EPC_out         = CP0_reg[EPC];
                end
            end
        end
    end
    
endmodule