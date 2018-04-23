module IDEX (
  clk,
  rst,
  Write,
  PC_in,PC_out,
  rd_in,rd_out,
  rt_in,rt_out,
  rs_in,rs_out,
  ext_in,ext_out,
  shamt_in,shamt_out,
  gprA_in,gprA_out,
  gprB_in,gprB_out,
  RegDst_in,RegDst_out,
  ALUop_in,ALUop_out,
  ALUsrc_in,ALUsrc_out,
  AluShift_in,AluShift_out,
  nbranch_in,nbranch_out,
  Branch_in,Branch_out,
  Mwrite_in,Mwrite_out,
  Mread_in,Mread_out,
  RegWrite_in,RegWrite_out,
  MtoR_in,MtoR_out,
  do_flush
  );


  input clk;
  input rst;
  input Write;
  input do_flush;


  input [31:0] PC_in;
  input [4:0]  rd_in;
  input [4:0]  rt_in;
  input [4:0]  rs_in;
  input [31:0] ext_in;
  input [4:0]  shamt_in;
  input [31:0] gprA_in;
  input [31:0] gprB_in;
  input        RegDst_in;
  input [4:0]  ALUop_in;
  input        ALUsrc_in;
  input        AluShift_in;
  input        Branch_in;
  input        nbranch_in;
  input        Mwrite_in;
  input        Mread_in;
  input        RegWrite_in;
  input        MtoR_in;

  reg [31:0] PC_mid;
  reg [4:0]  rd_mid;
  reg [4:0]  rt_mid;
  reg [4:0]  rs_mid;
  reg [31:0] ext_mid;
  reg [4:0]  shamt_mid;
  reg [31:0] gprA_mid;
  reg [31:0] gprB_mid;
  reg        RegDst_mid;
  reg [4:0]  ALUop_mid;
  reg        ALUsrc_mid;
  reg        AluShift_mid;
  reg        Branch_mid;
  reg        nbranch_mid;
  reg        Mwrite_mid;
  reg        Mread_mid;
  reg        RegWrite_mid;
  reg        MtoR_mid;

  output reg [31:0] PC_out;
  output reg [4:0]  rd_out;
  output reg [4:0]  rt_out;
  output reg [4:0]  rs_out;
  output reg [31:0] ext_out;
  output reg [4:0]  shamt_out;
  output reg [31:0] gprA_out;
  output reg [31:0] gprB_out;
  output reg        RegDst_out;
  output reg [4:0]  ALUop_out;
  output reg        ALUsrc_out;
  output reg        AluShift_out;
  output reg        Branch_out;
  output reg        nbranch_out;
  output reg        Mwrite_out;
  output reg        Mread_out;
  output reg        RegWrite_out;
  output reg        MtoR_out;


  always @ ( negedge clk ) begin
    if(do_flush)
    begin
      PC_mid = 0;
      rd_mid = 0;
      rt_mid = 0;
      rs_mid = 0;
      ext_mid = 0;
      shamt_mid = 0;
      gprA_mid = 0;
      gprB_mid = 0;
      RegDst_mid = 0;
      ALUop_mid = 0;
      ALUsrc_mid = 0;
      AluShift_mid = 0;
      Branch_mid = 0;
      nbranch_mid = 0;
      Mwrite_mid = 0;
      Mread_mid = 0;
      RegWrite_mid = 0;
      MtoR_mid = 0;
    end

    else if(Write)
    begin
      PC_mid = PC_in;
      rd_mid = rd_in;
      rt_mid = rt_in;
      rs_mid = rs_in;
      shamt_mid = shamt_in;
      gprA_mid = gprA_in;
      gprB_mid = gprB_in;
      RegDst_mid = RegDst_in;
      ALUop_mid = ALUop_in;
      ALUsrc_mid = ALUsrc_in;
      Branch_mid = Branch_in;
      nbranch_mid = nbranch_in;
      AluShift_mid = AluShift_in;
      Mread_mid = Mread_in;
      Mwrite_mid = Mwrite_in;
      RegWrite_mid = RegWrite_in;
      MtoR_mid = MtoR_in;
      ext_mid  = ext_in;
    end
  end


  always @(posedge clk or posedge rst)
  begin



    if (rst)
    begin
      $display("[ID/EX flush]");
      PC_out = 0;
      rd_out = 0;
      rt_out = 0;
      rs_out = 0;
      ext_out = 0;
      shamt_out = 0;
      gprA_out = 0;
      gprB_out = 0;
      RegDst_out = 0;
      ALUop_out = 0;
      ALUsrc_out = 0;
      AluShift_out = 0;
      Branch_out = 0;
      nbranch_out = 0;
      Mwrite_out = 0;
      Mread_out = 0;
      RegWrite_out = 0;
      MtoR_out = 0;

      PC_mid = 0;
      rd_mid = 0;
      rt_mid = 0;
      rs_mid = 0;
      ext_mid = 0;
      shamt_mid = 0;
      gprA_mid = 0;
      gprB_mid = 0;
      RegDst_mid = 0;
      ALUop_mid = 0;
      ALUsrc_mid = 0;
      AluShift_mid = 0;
      Branch_mid = 0;
      nbranch_mid = 0;
      Mwrite_mid = 0;
      Mread_mid = 0;
      RegWrite_mid = 0;
      MtoR_mid = 0;
    end //end if

    else if(Write)
    begin
      $display("[----------------------------------ID/EX PIPELINE REGISTER WORKING!!]");
      PC_out = PC_mid;
      rd_out = rd_mid;
      rt_out = rt_mid;
      rs_out = rs_in;
      shamt_out = shamt_in;
      gprA_out = gprA_mid;
      gprB_out = gprB_mid;
      RegDst_out = RegDst_mid;
      ALUop_out = ALUop_mid;
      ALUsrc_out = ALUsrc_mid;
      AluShift_out = AluShift_mid;
      Branch_out = Branch_mid;
      nbranch_out = nbranch_mid;
      Mread_out = Mread_mid;
      Mwrite_out = Mwrite_mid;
      RegWrite_out = RegWrite_mid;
      MtoR_out = MtoR_mid;
      ext_out  = ext_mid;
    end //end else
  end //end always
endmodule
