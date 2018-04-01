module EXMEM (
  clk,rst,
  Write,
  BPC_in,BPC_out,
  gprDes_in,gprDes_out,
  aluOut_in,aluOut_out,
  gprB_in,gprB_out,
  zero_in,zero_out,
  pcSel_in,pcSel_out,
  memR_in,memR_out,
  memW_in,memW_out,
  regW_in,regW_out,
  memToR_in,memToR_out
  );


  input clk,rst,Write;
  input [31:0] BPC_in;
  input [4:0]  gprDes_in;
  input [31:0] aluOut_in;
  input [31:0] gprB_in;
  input        zero_in;
  input        pcSel_in;
  input        memR_in;
  input        memW_in;
  input        regW_in;
  input        memToR_in;

  output reg [31:0] BPC_out;
  output reg [4:0]  gprDes_out;
  output reg [31:0] aluOut_out;
  output reg [31:0] gprB_out;
  output reg        zero_out;
  output reg        pcSel_out;
  output reg        memR_out;
  output reg        memW_out;
  output reg        regW_out;
  output reg        memToR_out;


  always @(posedge clk or negedge rst)
  begin

    if (rst)
    begin
      $display("[EX/MEM flush]");

      BPC_out = 0;
      gprDes_out = 0;
      aluOut_out = 0;
      gprB_out = 0;
      zero_out = 0;
      pcSel_out = 0;
      memR_out = 0;
      memW_out = 0;
      regW_out = 0;
      memToR_out = 0;

    end //end if

    else if (Write)
    begin
      BPC_out = BPC_in;
      gprDes_out = gprDes_in;
      aluOut_out = aluOut_in;
      gprB_out = gprB_in;
      zero_out = zero_in;
      pcSel_out = pcSel_in;
      memR_out = memR_in;
      memW_out = memW_in;
      regW_out = regW_in;
      memToR_out = memToR_in;

    end // end else
  end //end alway
endmodule
