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

  reg [31:0]  PC_mid;
  reg [31:0]  IR_mid;

  output reg [31:0] PC_out;
  output reg [31:0] IR_out;

  always @ ( negedge clk ) begin
    if(Write)
    begin
      PC_mid = PC_in;
      IR_mid = IR_in;
    end //end if
  end

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
      PC_out = PC_mid;
      IR_out = IR_mid;
    end // end else
  end //end always




endmodule
