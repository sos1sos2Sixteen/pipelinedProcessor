module IFID (
  clk,rst,
  Write,
  PC_in,PC_out,
  IR_in,IR_out,
  );

  input clk;
  input rst;
  input Write;
  input [31:0] PC_in;
  input [31:0] IR_in;

  output reg [31:0] PC_out;
  output reg [31:0] IR_out;

  always @(posedge clk or negedge rst)
  begin
    if (rst)
    begin
      $display("[IF/ID flush]");
      PC_out = 0;
      IR_out = 0;
    end //end if

    else if(Write)
    begin
      PC_out = PC_in;
      IR_out = IR_in;
    end // end else
  end //end always




endmodule
