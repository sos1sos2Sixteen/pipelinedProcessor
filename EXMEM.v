module EXMEM (
  clk,rst,
  Write,
  BPC_in,BPC_out,
  gprDes_in,gprDes_out,
  aluOut_in,aluOut_out,
  gprB_in,gprB_out,
  zero_in,zero_out,
  pcSel_in,pcSel_out,
  nbranch_in,nbranch_out,
  memR_in,memR_out,
  memW_in,memW_out,
  regW_in,regW_out,
  memToR_in,memToR_out,
  do_flush,
  );


  input clk,rst,Write;
  input do_flush;

  input [31:0] BPC_in;
  input [4:0]  gprDes_in;
  input [31:0] aluOut_in;
  input [31:0] gprB_in;
  input        zero_in;
  input        pcSel_in;
  input        nbranch_in;
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
  output reg        nbranch_out;
  output reg        memR_out;
  output reg        memW_out;
  output reg        regW_out;
  output reg        memToR_out;

  reg [31:0] BPC_mid;
  reg [4:0]  gprDes_mid;
  reg [31:0] aluOut_mid;
  reg [31:0] gprB_mid;
  reg        zero_mid;
  reg        pcSel_mid;
  reg        nbranch_mid;
  reg        memR_mid;
  reg        memW_mid;
  reg        regW_mid;
  reg        memToR_mid;


  always @ (negedge clk)
  begin
    if(do_flush)
    begin
      BPC_mid = 0;
      gprDes_mid = 0;
      aluOut_mid = 0;
      gprB_mid  = 0;
      zero_mid = 0;
      pcSel_mid = 0;
      nbranch_mid = 0;
      memR_mid = 0;
      memW_mid = 0;
      regW_mid = 0;
      memToR_mid = 0;

    end //end if
    else if(Write)
    begin
      BPC_mid = BPC_in;
      gprDes_mid = gprDes_in;
      aluOut_mid = aluOut_in;
      gprB_mid = gprB_in;
      zero_mid = zero_in;
      pcSel_mid = pcSel_in;
      nbranch_mid = nbranch_in;
      memR_mid = memR_in;
      memW_mid = memW_in;
      regW_mid = regW_in;
      memToR_mid = memToR_in;
    end
  end

  // always @ ( posedge rst ) begin
  //
  //
  // end


  always @(posedge clk or posedge rst)
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
      nbranch_out = 0;
      memR_out = 0;
      memW_out = 0;
      regW_out = 0;
      memToR_out = 0;
      BPC_mid = 0;
      gprDes_mid = 0;
      aluOut_mid = 0;
      gprB_mid = 0;
      zero_mid = 0;
      pcSel_mid = 0;
      nbranch_mid = 0;
      memR_mid = 0;
      memW_mid = 0;
      regW_mid = 0;
      memToR_mid = 0;

    end //end if

    else if (Write)
    begin
      BPC_out = BPC_mid;
      gprDes_out = gprDes_mid;
      aluOut_out = aluOut_mid;
      gprB_out = gprB_mid;
      zero_out = zero_mid;
      pcSel_out = pcSel_mid;
      nbranch_out = nbranch_mid;
      memR_out = memR_mid;
      memW_out = memW_mid;
      regW_out = regW_mid;
      memToR_out = memToR_mid;

    end // end else
  end //end alway
endmodule
