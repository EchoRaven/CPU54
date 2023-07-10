`timescale 1ns / 1ps
module sccomp_dataflow (
    input         clk_in,
    input         reset,
    output [31:0] inst,
    output [31:0] pc
);
  
  wire MFCS, MTCS, ERETS;
  wire DM_W, DM_R;
  wire [31:0] DM_wdata, DM_rdata;
  wire [10:0] DM_addr;
  wire [31:0] IM_instr, ALU_out, IM_addr;
  wire [4:0] cp0_addr; 
  wire [31:0] cp0_Wdata;
  wire [4:0] cp0_cause; 
  wire [31:0] CP0_out; 
  wire [31:0] EPC_out; 
  assign inst   = IM_instr;
  assign DM_addr = (ALU_out - 32'h10010000) >> 2;
  assign IM_addr = (pc - 32'h00400000) >> 2;

  CPU sccpu (
      .clk     (clk_in),
      .ena     (1'b1),
      .rst     (reset),
      .DM_W    (DM_W),
      .DM_R    (DM_R),
      .IM_instr(IM_instr),
      .DM_rdata(DM_rdata),
      .DM_wdata(DM_wdata),
      .PC_out  (pc),
      .ALU_out (ALU_out),
      .MFCS    (MFCS),
      .MTCS    (MTCS),
      .ERETS   (ERETS),
      .cp0_addr(cp0_addr),
      .cp0_Wdata(cp0_Wdata),
      .cp0_cause(cp0_cause)
  );

  IMEM IMEM_inst (
      .IM_addr (IM_addr[10:0]),
      .IM_instr(IM_instr)
  );

  DMEM DMEM_init (
      .clk     (clk_in),
      .ena     (1'b1),
      .DM_W    (DM_W),
      .DM_R    (DM_R),
      .DM_addr (DM_addr),
      .DM_wdata(DM_wdata),
      .DM_rdata(DM_rdata)
  );
  
  CP0 cp0_init (
      .clk    (clk_in),
      .ena    (1'b1),
      .MFCS   (MFCS),
      .MTCS   (MTCS),
      .ERETS  (ERETS),
      .PC     (pc),
      .addr   (cp0_addr),
      .Wdata  (cp0_Wdata),
      .cause  (cp0_cause),
      .CP0_out(CP0_out),
      .EPC_out(EPC_out)
  );
  
endmodule
