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
  output reg  [31:0] PC_out;

  input [4 :0] rd_in;
  output reg  [4 :0] rd_out;

  input [4 :0] rt_in;
  output reg  [4 :0] rt_out;

  input [31:0] ext_in;
  output reg  [31:0] ext_out;

  input [31:0] gprA_in;
  output reg  [31:0] gprA_out;

  input [31:0] gprB_in;
  output reg  [31:0] gprB_out;

  input RegDst_in;
  output reg  RegDst_out;

  input [4 :0] ALUop_in;
  output reg  [4 :0] ALUop_out;

  input ALUsrc_in;
  output reg  ALUsrc_out;

  input Branch_in;
  output reg  Branch_out;

  input Mwrite_in;
  output reg  Mwrite_out;

  input Mread_in;
  output reg  Mread_out;

  input RegWrite_in;
  output reg  RegWrite_out;

  input MtoR_in;
  output reg  MtoR_out;



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
      PC_out = PC_in;
      rd_out = rd_in;
      rt_out = rt_in;
      gprA_out = gprA_in;
      gprB_out = gprB_in;
      RegDst_out = RegDst_in;
      ALUop_out = ALUop_in;
      ALUsrc_out = ALUsrc_in;
      Branch_out = Branch_in;
      Mread_out = Mread_in;
      Mwrite_out = Mwrite_in;
      RegWrite_out = RegWrite_in;
      MtoR_out = MtoR_in;
      ext_out  = ext_in;
    end //end else
  end //end always
endmodule
