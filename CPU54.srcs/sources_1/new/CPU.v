`timescale 1ns / 1ps
module CPU (
    input         clk,
    input         ena,
    input         rst,
    output        DM_W,
    output        DM_R,
    input  [31:0] IM_instr,
    input  [31:0] DM_rdata,
    output [31:0] DM_wdata,
    output [31:0] PC_out,
    output [31:0] ALU_out,
    output MFCS,  
    output MTCS,  
    output ERETS,
    output [4:0] cp0_addr, 
    output [31:0] cp0_Wdata,
    output [4:0] cp0_cause
);

  wire ZF, SF, CF, OF;
  wire [4:0] ALUC;
  wire [31:0] A, B, F;

  wire [1:0] PCC;
  wire [2:0] RDC;
  wire ALUA;
  wire [1:0] ALUB;
  wire [31:0] PCin, Ain, Bin;

  wire [31:0] PC, NPC;

  wire [4:0] Rdc, Rsc, Rtc;
  wire [31:0] Rd, Rs, Rt;
  wire RF_W;
  
  wire CLZS;
  wire [31:0] CLZ_in, CLZ_out;
  
  wire DIVUS;
  wire [31:0] DIVUA, DIVUB, DIVUR, DIVUM;
  
  wire DIVS;
  wire [31:0] DIVA, DIVB, DIVR, DIVM;
  
  wire MULS;
  wire [31:0] MULA, MULB, MULR;
  
  wire MULUS;
  wire [31:0] MULUA, MULUB;
  wire [63:0] MULUR;
  
  wire HIWS, HIRS;
  wire LOWS, LORS;
  wire [31:0] HI_in, HI_out, LO_in, LO_out;
  
  wire JALRS;
  
  wire LBS, SBS, LBUS;
  wire [31:0] LB_in, LBU_in;
  wire [31:0] LB_out, LBU_out;
  wire [15:0] LB_imm, SB_imm, LBU_imm;
  wire [31:0] SB_in, SB_r, SB_out;
  
  wire LHS, SHS, LHUS;
  wire [31:0] LH_in, LHU_in;
  wire [31:0] LH_out, LHU_out;
  wire [15:0] LH_imm, SH_imm, LHU_imm;
  wire [31:0] SH_in, SH_r, SH_out;
  
  wire BGEZ;

  assign NPC         = PC + 4;
  assign DM_wdata    = SHS ? SH_out : (SBS ? SB_out : Rt);

  assign PC_out      = PC;
  assign ALU_out     = F;

  assign PCin  = BGEZ ? ($signed(Rs) >= 0 ? PC + IM_instr[15:0] * 4 + 4 : PC + 4) : (JALRS ? Rs : ((PCC==2'b10) ? Rs:((PCC==2'b11) ? {PC[31:28], IM_instr[25:0], 2'b0} :((PCC==2'b01) ? {{14{IM_instr[15]}}, IM_instr[15:0], 2'b0} + NPC : NPC))));
  
  assign Ain  = ALUA ? {27'b0, IM_instr[10:6]} : Rs;
  assign Bin  = ALUB[1] ? Rt : (ALUB[0] ? {{16{IM_instr[15]}}, IM_instr[15:0]} : {16'b0, IM_instr[15:0]});
  
  assign CLZ_in = CLZS ? Rs : 31'bz;
  
  assign DIVUA = DIVUS ? Rs : 31'bz;
  assign DIVUB = DIVUS ? Rt : 31'bz;
  
  assign DIVA = DIVS ? Rs : 31'bz;
  assign DIVB = DIVS ? Rt : 31'bz;
  
  assign MULA = MULS ? Rs : 31'bz;
  assign MULB = MULS ? Rt : 31'bz;
  
  assign MULUA = MULUS ? Rs : 31'bz;
  assign MULUB = MULUS ? Rt : 31'bz;
  
  assign LB_imm = LBS ? IM_instr[15:0] : 15'bz;
  assign LB_in = LBS ? DM_rdata : 31'bz;
  
  assign LBU_imm = LBUS ? IM_instr[15:0] : 15'bz;
  assign LBU_in = LBUS ? DM_rdata : 31'bz;
  
  assign SB_imm = SBS ? IM_instr[15:0] : 15'bz;
  assign SB_in = SBS ? DM_rdata : 31'bz;
  assign SB_r = SBS ? Rt : 31'bz;

  assign LH_imm = LHS ? IM_instr[15:0] : 15'bz;
  assign LH_in = LHS ? DM_rdata : 31'bz;
  
  assign LHU_imm = LHUS ? IM_instr[15:0] : 15'bz;
  assign LHU_in = LHUS ? DM_rdata : 31'bz;
  
  assign SH_imm = SHS ? IM_instr[15:0] : 15'bz;
  assign SH_in = SHS ? DM_rdata : 31'bz;
  assign SH_r = SHS ? Rt : 31'bz;
  
  assign HI_in = HIWS ? (MULUS ? MULUR[63:32] : (MULS ? 31'bz : (DIVS ? DIVM : (DIVUS ? DIVUM : Rs)))) : 31'bz;
  assign LO_in = LOWS ? (MULUS ? MULUR[31: 0] : (MULS ? 31'bz : (DIVS ? DIVR : (DIVUS ? DIVUR : Rs)))) : 31'bz;
  
  assign Rd   = LHUS ? LHU_out : (LORS ? LO_out : (HIRS ? HI_out : (LHS ? LH_out : (LBUS ? LBU_out : (LBS ? LB_out : (JALRS ? PC + 4 : (MULS ? MULR : (LORS ? LO_out : (HIRS ? HI_out : (CLZS ? CLZ_out : ((RDC==3'b100) ? F : ((RDC==3'b011) ? PC + 4 :((RDC==3'b010) ? DM_rdata : ((RDC==3'b001) ? {31'b0, SF} : {31'b0, OF}))))))))))))));
  assign Rdc  = LHUS ? IM_instr[20:16] : (LHS ? IM_instr[20:16] : (LBUS ? IM_instr[20:16] : (LBS ? IM_instr[20:16] : (JALRS ? IM_instr[15:11] : (MULS ? IM_instr[15:11] : (ALUB[1] ? ((RDC==3'b011) ? 5'b11111 : IM_instr[15:11]) : IM_instr[20:16]))))));
  assign Rsc  = IM_instr[25:21];
  assign Rtc  = IM_instr[20:16];


  RegFile cpu_ref (
      .ena (ena),
      .rst (rst),
      .clk (clk),
      .RF_W(RF_W),
      .Rdc (Rdc),
      .Rsc (Rsc),
      .Rtc (Rtc),
      .Rd  (Rd),
      .Rs  (Rs),
      .Rt  (Rt)
  );

  PC PC_init (
      .clk (clk),
      .rst (rst),
      .ena (ena),
      .Din (PCin),
      .Dout(PC)
  );

  ALU ALU_init (
      .A   (Ain),
      .B   (Bin),
      .F   (F),
      .ALUC(ALUC),
      .ZF  (ZF),
      .CF  (CF),
      .SF  (SF),
      .OF  (OF)
  );
    
  CLZ clz_init (
      .CLZ_in  (CLZ_in),
      .CLZ_out (CLZ_out),
      .CLZS    (CLZS)
  );
  
  DIVU divu_init (
      .DIVUA   (DIVUA),
      .DIVUB   (DIVUB),
      .DIVUS   (DIVUS),
      .DIVUR   (DIVUR),
      .DIVUM   (DIVUM)
  );
  
  DIV div_init (
      .DIVA   (DIVA),
      .DIVB   (DIVB),
      .DIVS   (DIVS),
      .DIVR   (DIVR),
      .DIVM   (DIVM)
  );
  
  MUL mul_init (
      .MULA  (MULA),
      .MULB  (MULB),
      .MULS  (MULS),
      .MULR  (MULR)
  );
  
  MULU mulu_init (
      .MULUA  (MULUA),
      .MULUB  (MULUB),
      .MULUS  (MULUS),
      .MULUR  (MULUR)
  );
  
  HI hi_init (
      .HI_in  (HI_in),
      .HIWS   (HIWS),
      .HIRS   (HIRS),
      .HI_out (HI_out),
      .clk    (clk)
  );
  
  LO lo_init (
      .LO_in  (LO_in),
      .LOWS   (LOWS),
      .LORS   (LORS),
      .LO_out (LO_out),
      .clk    (clk)
  );
  
  LB lb_init (
      .LBS      (LBS),
      .LB_in    (LB_in),
      .LB_imm   (LB_imm),
      .LB_out   (LB_out)
  );
  
  SB sb_init (
      .SB_in  (SB_in),
      .SB_r   (SB_r),
      .SBS    (SBS),
      .SB_imm (SB_imm),
      .SB_out (SB_out)
  );
  
  LBU lbu_init (
      .LBUS      (LBUS),
      .LBU_in    (LBU_in),
      .LBU_imm   (LBU_imm),
      .LBU_out   (LBU_out)
  );

  LH lh_init (
      .LHS      (LHS),
      .LH_in    (LH_in),
      .LH_imm   (LH_imm),
      .LH_out   (LH_out)
  );
  
  LHU lhu_init (
      .LHUS      (LHUS),
      .LHU_in    (LHU_in),
      .LHU_imm   (LHU_imm),
      .LHU_out   (LHU_out)
  );
  
  SH sh_init (
      .SH_in  (SH_in),
      .SH_r   (SH_r),
      .SHS    (SHS),
      .SH_imm (SH_imm),
      .SH_out (SH_out)
  );
  
  Controller Controller_init (
      .IM_instr(IM_instr),
      .ZF      (ZF),
      .ALUC    (ALUC),
      .PCC     (PCC),
      .RDC     (RDC),
      .ALUA    (ALUA),
      .ALUB    (ALUB),
      .DM_R    (DM_R),
      .DM_W    (DM_W),
      .RFC     (RF_W),
      .CLZS    (CLZS),
      .DIVUS   (DIVUS),
      .DIVS    (DIVS),
      .MULS    (MULS),
      .MULUS   (MULUS),
      .JALRS   (JALRS),
      .HIRS    (HIRS),
      .HIWS    (HIWS),
      .LORS    (LORS),
      .LOWS    (LOWS),
      .LBS     (LBS),
      .SBS     (SBS),
      .SHS     (SHS),
      .LHS     (LHS),
      .LBUS    (LBUS),
      .LHUS    (LHUS),
      .BGEZ    (BGEZ),
      .MFCS    (MFCS),
      .MTCS    (MTCS),
      .ERETS   (ERETS)
  );
  
endmodule
