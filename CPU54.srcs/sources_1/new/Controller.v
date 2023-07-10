`timescale 1ns / 1ps
module Controller (
    input  [31:0] IM_instr,
    input         ZF,
    output [ 4:0] ALUC,
    output [ 1:0] PCC,
    output [ 2:0] RDC,
    output ALUA,
    output [ 1:0] ALUB,
    output CLZS,
    output DIVUS,
    output DIVS,
    output MULS,
    output MULUS,
    output JALRS,
    output HIRS,
    output HIWS,
    output LORS,
    output LOWS,
    output LBS,
    output LBUS,
    output LHUS,
    output SBS,
    output SHS,
    output LHS,
    output DM_R,
    output DM_W,
    output RFC,
    output BGEZ,
    output MFCS,
    output MTCS,
    output ERETS
);

  wire add_, addu_, sub_, subu_, and_, or_, xor_, nor_;
  wire slt_, sltu_, sll_, srl_, sra_, sllv_, srlv_, srav_, jr_;
  assign add_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_000);
  assign addu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_001);
  assign sub_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_010);
  assign subu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_011);
  assign and_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_100);
  assign or_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_101);
  assign xor_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_110);
  assign nor_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_111);
  assign slt_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_010);
  assign sltu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_011);
  assign sll_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_000);
  assign srl_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_010);
  assign sra_  = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_011);
  assign sllv_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_100);
  assign srlv_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_110);
  assign srav_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_111);
  assign jr_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_000);

  wire addi_, addiu_, andi_, ori_, xori_, lw_, sw_, beq_, bne_;
  wire slti_, sltiu_, lui_;
  assign addi_  = (IM_instr[31:26] == 6'b001_000);
  assign addiu_ = (IM_instr[31:26] == 6'b001_001);
  assign andi_  = (IM_instr[31:26] == 6'b001_100);
  assign ori_   = (IM_instr[31:26] == 6'b001_101);
  assign xori_  = (IM_instr[31:26] == 6'b001_110);
  assign lw_    = (IM_instr[31:26] == 6'b100_011);
  assign sw_    = (IM_instr[31:26] == 6'b101_011);
  assign beq_   = (IM_instr[31:26] == 6'b000_100);
  assign bne_   = (IM_instr[31:26] == 6'b000_101);
  assign slti_  = (IM_instr[31:26] == 6'b001_010);
  assign sltiu_ = (IM_instr[31:26] == 6'b001_011);
  assign lui_   = (IM_instr[31:26] == 6'b001_111);

  wire j_, jal_;
  assign j_     = (IM_instr[31:26] == 6'b000_010);
  assign jal_   = (IM_instr[31:26] == 6'b000_011);
  
  wire clz_;
  assign clz_   = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b100_000); 
  
  wire divu_;
  assign divu_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_011); 
  
  wire div_;
  assign div_    = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_010);
  
  wire mflo_, mtlo_, mfhi_, mthi_, mfc0_, mtc0_;
  assign mfc0_   = (IM_instr[31:26] == 6'b010_000 && IM_instr[5:0] == 6'b000_000);
  assign mfhi_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_000);
  assign mflo_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_010);
  assign mtc0_   = (IM_instr[31:26] == 6'b010_000 && IM_instr[5:0] == 6'b000_000);
  assign mthi_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_001);
  assign mtlo_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_011);
  
  wire mul_, mulu_;
  assign mul_    = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b000_010);
  assign mulu_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b0110_01);

  wire jalr_;
  assign jalr_   = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_001);
  
  wire lb_, sb_, lbu_, lhu_;
  assign lb_     = (IM_instr[31:26] == 6'b100_000);
  assign sb_     = (IM_instr[31:26] == 6'b101_000);
  assign lbu_    = (IM_instr[31:26] == 6'b100_100);
  assign lhu_    = (IM_instr[31:26] == 6'b100_101);
  
  wire lh_, sh_;
  assign lh_     = (IM_instr[31:26] == 6'b100_001);
  assign sh_     = (IM_instr[31:26] == 6'b101_001);
  
  wire bgez_    = (IM_instr[31:26] == 6'b000_001);
  
  wire eret_   = (IM_instr[31:26] == 6'b010_000 && IM_instr[5:0] == 6'b011_000);

  // ALUC
  assign ALUC[0]  = addu_ || addiu_ || lw_ || sw_ || subu_ || beq_ || bne_ || or_ || ori_ || nor_ || sltu_ || sltiu_ || srl_ || sllv_ || srav_;
  assign ALUC[1]  = sub_ || subu_ || beq_ || bne_ || xor_ || xori_ || nor_ || sll_ || srl_ || srlv_ || srav_;
  assign ALUC[2]  = and_ || andi_ || or_ || ori_ || xor_ || xori_ || nor_ || sra_ || sllv_ || srlv_ || srav_;
  assign ALUC[3]  = slt_ || sltu_ || slti_ || sltiu_ || sll_ || srl_ || sra_ || sllv_ || srlv_ || srav_;
  assign ALUC[4]  = lui_;

  // DMC
  assign DM_R   = lw_ || lb_ || lh_ || sb_ || lbu_ || sh_ || lhu_;
  assign DM_W   = sw_ || sb_ || sh_;

  // RFC(RF_W)
  assign RFC      = !(sw_ || jr_ || j_ || beq_ || bne_ || sb_ || sh_);

  // pc 
  // beq || bne 01, jr 10, jal || j 11
  assign PCC[0] = (beq_ && ZF) || (bne_ && !ZF) || jal_ || j_;
  assign PCC[1] = jr_ || jal_ || j_;

  // rd MUX
  // (slt_ || sltu_) && !(slti_ || sltiu_) 001  lw_ 010 jal_ || jalr_ 011 !(slt_ || sltu_ || slti_ || sltiu_ || lw_ || jal_ || jalr_) 100
  assign RDC[0] = ((slt_ || sltu_) && !(slti_ || sltiu_)) || jal_;
  assign RDC[1] = lw_ || jal_;
  assign RDC[2] = !(slt_ || sltu_ || slti_ || sltiu_ || lw_ || jal_);

  // alu a MUX
  assign ALUA  = (sll_ || srl_ || sra_);

  // alu b MUX
  // sw_ || lw_ || addi_ || addiu_ || slti_ || sltiu_; 01 !(addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || sw_ || slti_ || sltiu_ || lui_); 10
  assign ALUB[0]  = sw_ || lw_ || addi_ || addiu_ || slti_ || sltiu_ || sb_ || sh_ || lb_ || lbu_ || lh_ || lhu_;
  assign ALUB[1]  = !(addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || sw_ || slti_ || sltiu_ || lui_ || sb_ || sh_ || lb_ || lbu_ || lh_ || lhu_);
  
  // clz MUX
  assign CLZS = clz_;
  
  // divu MUX
  assign DIVUS = divu_;
  
  // hi write MUX
  assign HIWS = divu_ || div_ || mthi_ || mulu_ || mul_;
  
  // hi read MUX
  assign HIRS = mfhi_;
  
  // lo write MUX
  assign LOWS = divu_ || div_ || mtlo_ || mulu_ || mul_;
  
  // lo read MUX
  assign LORS = mflo_;
  
  // div MUX
  assign DIVS = div_;
  
  // mul MUX
  assign MULS = mul_;
  
  // mulu MUX
  assign MULUS = mulu_;
  
  // jalr MUX
  assign JALRS = jalr_;
  
  // lb MUX
  assign LBS = lb_;
  
  // lh MUX
  assign LHS = lh_;
  
  // lbu MUX
  assign LBUS = lbu_;
  
  // lhu MUX
  assign LHUS = lhu_;
  
  // sb MUX
  assign SBS = sb_;
  
  // sh MUX
  assign SHS = sh_;
  
  // bgez MUX
  assign BGEZ = bgez_;
  
  // mfco MUX
  assign MFCS = mfc0_;
  
  // mtc0 MUX
  assign MTCS = mtc0_;
  
  // eret MUX
  assign ERETS = eret_;

endmodule
