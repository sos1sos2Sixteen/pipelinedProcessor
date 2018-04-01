module MEMWB (
  clk,rst,
  Write,
  gprDes_in,gprDes_out,
  aluOut_in,aluOut_out,
  memOut_in,memOut_out,
  regW_in,regW_out,
  memToR_in,memToR_out
  );

  input clk,rst,Write;
  input [4:0] gprDes_in;
  input [31:0] aluOut_in;
  input [31:0] memOut_in;
  input        regW_in;
  input        memToR_in;

  output reg [4:0]  gprDes_out;
  output reg [31:0] aluOut_out;
  output reg [31:0] memOut_out;
  output reg        regW_out;
  output reg        memToR_out;

  reg [4:0] gprDes_mid;
  reg [31:0] aluOut_mid;
  reg [31:0] memOut_mid;
  reg        regW_mid;
  reg        memToR_mid;


  always @ ( negedge clk ) begin
    gprDes_mid = gprDes_in;
    aluOut_mid = aluOut_in;
    memOut_mid = memOut_in;
    regW_mid = regW_in;
    memToR_mid = memToR_in;
  end



  always @(posedge clk or negedge rst)
  begin

    if (rst)
    begin
      $display("[MEM/WB flush]");

      gprDes_out = 0;
      aluOut_out = 0;
      memOut_out = 0;
      regW_out = 0;
      memToR_out = 0;

    end //end if

    else if(Write)
    begin
      gprDes_out <= gprDes_mid;
      aluOut_out <= aluOut_mid;
      memOut_out <= memOut_mid;
      regW_out <= regW_mid;
      memToR_out <= memToR_mid;

    end // end else
  end


endmodule // MEMWB
