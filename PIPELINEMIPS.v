

module pipeMips (clock,reset);
  input clock;
  input reset;

  wire   pRegWrite = 1;


  //----------WIRES-----------
  //INTER-STEPS
  wire        M_IF_doBranch;
  wire [31:0] M_IF_BPC;
  wire [31:0] WB_ID_writeBack;
  wire [4:0]  WB_ID_gprWriteAddr;
  wire        WB_ID_gprWrite;


  //IF
  wire [31:0] IF_pc_im;
  wire [31:0] IF_pc_return;

  wire [31:0] IF_pc_next;
  wire [31:0] IF_ir_next;

  //ID
  wire [31:0] ID_last_PC;
  wire [31:0] ID_last_IR;
  wire [5:0]  ID_opcode_ctrl;
  wire [5:0]  ID_funct_ctrl;
  wire [5:0]  ID_shamt_next;       //TODO: shamt out of question
  wire [4:0]  ID_rs_gpr;
  wire [4:0]  ID_rt_gpr;
  wire [4:0]  ID_rd_gpr;

  wire [31:0] ID_gprA_next;
  wire [31:0] ID_gprB_next;

  wire [15:0] ID_imm_ext;
  wire [31:0] ID_extended_next;

  wire [1:0]  ID_extop_ext;
  wire        ID_regDst_next;
  wire [4:0]  ID_aluCtrl_next;
  wire        ID_aluSrc_next;
  wire        ID_pcSel_next;
  wire        ID_memR_next;
  wire        ID_memW_next;
  wire        ID_RegW_next;
  wire        ID_memToR_next;

  //EX
  wire [31:0] EX_last_PC;
  wire [31:0] EX_last_ext;
  wire [31:0] EX_branchAddr_next;
  wire [31:0] EX_aluResult_next;
  wire        EX_aluZero_next;
  wire [31:0] EX_last_gprA_alu;
  wire [31:0] EX_last_gprB_muxB;
  wire [31:0] EX_muxB_alu;
  wire        EX_last_aluSrc_muxB;
  wire        EX_last_regDst_muxR;
  wire [4:0]  EX_aluCtrl_alu;
  wire [4:0]  EX_last_rd_mux;
  wire [4:0]  EX_last_rt_mux;
  wire [4:0]  EX_muxR_next;
  wire        EX_last_pcSel;
  wire        EX_last_memR;
  wire        EX_last_memW;
  wire        EX_last_regW;
  wire        EX_last_memToR;

  //MEM
  wire        M_last_pcSel;
  wire        M_last_zero;
  wire [31:0] M_dmResult_next;
  wire [31:0] M_last_aluResult;
  wire [31:0] M_last_gprB;
  wire        M_last_memR;
  wire        M_last_memW;
  wire [4:0]  M_last_gprDes;
  wire        M_last_regW;
  wire        M_last_memToR;

  //WB

  wire [31:0] WB_last_memOut;
  wire [31:0] WB_last_aluOut;
  wire        WB_last_memToReg;



  //-------END WIRES----------


  // ----------I F------------
  PcUnit PC_UNIT(
    .Clk(clock),
    .PcReSet(reset),
    .PC(IF_pc_im),
    .PcSel(M_IF_doBranch),
    .nextPC(IF_pc_return),
    .branchAddr(M_IF_BPC)
    );

  assign IF_pc_return = IF_pc_im + 4;

  IM P_IM(
    .OpCode(IF_ir_next),
    .ImAdress(IF_pc_im[6:2])
    );

  IFID P_IFID(
    .clk(clock),
    .rst(reset),
    .Write(pRegWrite),
    .PC_in(IF_pc_return),.PC_out(ID_last_PC),
    .IR_in(IF_ir_next),.IR_out(ID_last_IR)
    );
  // -------END IF------------

  // --------I D--------------

  assign ID_opcode_ctrl = ID_last_IR[31:26];
  assign ID_shamt_next  = ID_last_IR[10:6];
  assign ID_funct_ctrl  = ID_last_IR[5:0];
  assign ID_rs_gpr      = ID_last_IR[25:21];
  assign ID_rt_gpr      = ID_last_IR[20:16];
  assign ID_rd_gpr      = ID_last_IR[15:11];
  assign ID_imm_ext     = ID_last_IR[15:0];

  GPR P_GPR(
    .DataOut1(ID_gprA_next),
    .DataOut2(ID_gprB_next),
    .clk(clock),
    .WData(WB_ID_writeBack),
    .WE(WB_ID_gprWrite),
    .WeSel(WB_ID_gprWriteAddr),
    .ReSel1(ID_rs_gpr),
    .ReSel2(ID_rt_gpr)
    );

  Extender EXT(
    .ExtOut(ID_extended_next),
    .DataIn(ID_imm_ext),
    .ExtOp(ID_extop_ext)
    );

  Ctrl ELOHIM(
    .jump(),                    //TODO: reserved for jump
    .RegDst(ID_regDst_next),
    .Branch(ID_pcSel_next),
    .NBranch(),                 //TODO: reserved for bne
    .MemR(ID_memR_next),
    .Mem2R(ID_memToR_next),
    .MemW(ID_memW_next),
    .RegW(ID_RegW_next),
    .Alusrc(ID_aluSrc_next),
    .AluShift(),                //TODO: reserved for shifts
    .ExtOp(ID_extop_ext),
    .Aluctrl(ID_aluCtrl_next),
    .OpCode(ID_opcode_ctrl),
    .funct(ID_funct_ctrl)
    );

  IDEX P_IDEX(
    .clk(clock),
    .rst(reset),
    .Write(pRegWrite),
    .PC_in(ID_last_PC),.PC_out(EX_last_PC),
    .rd_in(ID_rd_gpr),.rd_out(EX_last_rd_mux),
    .rt_in(ID_rt_gpr),.rt_out(EX_last_rt_mux),
    .ext_in(ID_extended_next),.ext_out(EX_last_ext),
    .gprA_in(ID_gprA_next),.gprA_out(EX_last_gprA_alu),
    .gprB_in(ID_gprB_next),.gprB_out(EX_last_gprB_muxB),
    .RegDst_in(ID_regDst_next),.RegDst_out(EX_last_regDst_muxR),
    .ALUop_in(ID_aluCtrl_next),.ALUop_out(EX_aluCtrl_alu),
    .ALUsrc_in(ID_aluSrc_next),.ALUsrc_out(EX_last_aluSrc_muxB),
    .Branch_in(ID_pcSel_next),.Branch_out(EX_last_pcSel),
    .Mwrite_in(ID_memW_next),.Mwrite_out(EX_last_memW),
    .Mread_in(ID_memR_next),.Mread_out(EX_last_memR),
    .RegWrite_in(ID_RegW_next),.RegWrite_out(EX_last_regW),
    .MtoR_in(ID_memToR_next),.MtoR_out(EX_last_memToR)
    );

  // -------END ID------------

  // --------E X---------------

  //计算分支的目标
  assign EX_branchAddr_next = EX_last_PC + (EX_last_ext << 2);
  assign EX_muxB_alu = (EX_last_aluSrc_muxB == 1)?
                        EX_last_ext : EX_last_gprB_muxB;
  assign EX_muxR_next = (EX_last_regDst_muxR == 1)?
                        EX_last_rt_mux : EX_last_rd_mux;


  Alu ALU(
    .AluResult(EX_aluResult_next),
    .Zero(EX_aluZero_next),
    .DataIn1(EX_last_gprA_alu),
    .DataIn2(EX_muxB_alu),
    .AluCtrl(EX_aluCtrl_alu)
    );


  EXMEM P_EXMEM(
    .clk(clock),
    .rst(reset),
    .Write(pRegWrite),
    .BPC_in(EX_branchAddr_next),.BPC_out(M_IF_BPC),
    .gprDes_in(EX_muxR_next),.gprDes_out(M_last_gprDes),
    .aluOut_in(EX_aluResult_next),.aluOut_out(M_last_aluResult),
    .gprB_in(EX_last_gprB_muxB),.gprB_out(M_last_gprB),
    .zero_in(EX_aluZero_next),.zero_out(M_last_zero),
    .pcSel_in(EX_last_pcSel),.pcSel_out(M_last_pcSel),
    .memR_in(EX_last_memR),.memR_out(M_last_memR),
    .memW_in(EX_last_memW),.memW_out(M_last_memW),
    .regW_in(EX_last_regW),.regW_out(M_last_regW),
    .memToR_in(EX_last_memToR),.memToR_out(M_last_memToR)
    );

  // -------END EX-------------


  // --------M E M-------------

  assign M_IF_doBranch = (M_last_zero && M_last_pcSel)?1'b1:1'b0;

  DMem DMEM(
    .DataOut(M_dmResult_next),
    .DataAdr(M_last_aluResult[4:0]),
    .DataIn(M_last_gprB),
    .DMemW(M_last_memW),
    .DMemR(M_last_memR),
    .clk(clock)
    );

  MEMWB P_MEMWB(
    .clk(clock),
    .rst(reset),
    .Write(pRegWrite),
    .gprDes_in(M_last_gprDes),.gprDes_out(WB_ID_gprWriteAddr),
    .aluOut_in(M_last_aluResult),.aluOut_out(WB_last_aluOut),
    .memOut_in(M_dmResult_next),.memOut_out(WB_last_memOut),
    .regW_in(M_last_regW),.regW_out(WB_ID_gprWrite),
    .memToR_in(M_last_memToR),.memToR_out(WB_last_memToReg)
    );
  // ------END MEM ------------

  // --------W B --------------

  assign WB_ID_writeBack = (WB_last_memToReg == 1)?
                            WB_last_memOut : WB_last_aluOut;


  // -----END WB---------------

endmodule // Mips
