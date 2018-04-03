module IDEX (
  clk,
  rst,
  Write,
  PC_in,PC_out,
  rd_in,rd_out,
  rt_in,rt_out,
  ext_in,ext_out,
  gprA_in,gprA_out,
  gprB_in,gprB_out,
  RegDst_in,RegDst_out,
  ALUop_in,ALUop_out,
  ALUsrc_in,ALUsrc_out,
  Branch_in,Branch_out,
  Mwrite_in,Mwrite_out,
  Mread_in,Mread_out,
  RegWrite_in,RegWrite_out,
  MtoR_in,MtoR_out
  );


  input clk;
  input rst;
  input Write;


  input [31:0] PC_in;
  reg [31:0] PC_mid;
  output reg  [31:0] PC_out;

  input [4 :0] rd_in;
  reg [4:0] rd_mid;
  output reg  [4 :0] rd_out;

  input [4 :0] rt_in;
  reg [4:0] rt_mid;
  output reg  [4 :0] rt_out;

  input [31:0] ext_in;
  reg [31:0] ext_mid;
  output reg  [31:0] ext_out;

  input [31:0] gprA_in;
  reg [31:0] gprA_mid;
  output reg  [31:0] gprA_out;

  input [31:0] gprB_in;
  reg [31:0] gprB_mid;
  output reg  [31:0] gprB_out;

  input RegDst_in;
  reg RegDst_mid;
  output reg  RegDst_out;

  input [4 :0] ALUop_in;
  reg [4:0] ALUop_mid;
  output reg  [4 :0] ALUop_out;

  input ALUsrc_in;
  reg ALUsrc_mid;
  output reg  ALUsrc_out;

  input Branch_in;
  reg Branch_mid;
  output reg  Branch_out;

  input Mwrite_in;
  reg Mwrite_mid;
  output reg  Mwrite_out;

  input Mread_in;
  reg Mread_mid;
  output reg  Mread_out;

  input RegWrite_in;
  reg RegWrite_mid;
  output reg  RegWrite_out;

  input MtoR_in;
  reg MtoR_mid;
  output reg  MtoR_out;


  always @ ( negedge clk ) begin
    if(Write)
    begin
      PC_mid = PC_in;
      rd_mid = rd_in;
      rt_mid = rt_in;
      gprA_mid = gprA_in;
      gprB_mid = gprB_in;
      RegDst_mid = RegDst_in;
      ALUop_mid = ALUop_in;
      ALUsrc_mid = ALUsrc_in;
      Branch_mid = Branch_in;
      Mread_mid = Mread_in;
      Mwrite_mid = Mwrite_in;
      RegWrite_mid = RegWrite_in;
      MtoR_mid = MtoR_in;
      ext_mid  = ext_in;
    end
  end

  always @(posedge clk or negedge rst)
  begin
    if (rst)
    begin
      $display("[ID/EX flush]");
      PC_out = 0;
      rd_out = 0;
      rt_out = 0;
      ext_out = 0;
      gprA_out = 0;
      gprB_out = 0;
      RegDst_out = 0;
      ALUop_out = 0;
      ALUsrc_out = 0;
      Branch_out = 0;
      Mwrite_out = 0;
      Mread_out = 0;
      RegWrite_out = 0;
      MtoR_out = 0;
    end //end if

    else if(Write)
    begin
      $display("[----------------------------------ID/EX PIPELINE REGISTER WORKING!!]");
      PC_out = PC_mid;
      rd_out = rd_mid;
      rt_out = rt_mid;
      gprA_out = gprA_mid;
      gprB_out = gprB_mid;
      RegDst_out = RegDst_mid;
      ALUop_out = ALUop_mid;
      ALUsrc_out = ALUsrc_mid;
      Branch_out = Branch_mid;
      Mread_out = Mread_mid;
      Mwrite_out = Mwrite_mid;
      RegWrite_out = RegWrite_mid;
      MtoR_out = MtoR_mid;
      ext_out  = ext_mid;
    end //end else
  end //end always
endmodule
