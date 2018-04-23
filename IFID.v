module IFID (
  clk,rst,
  Write,
  PC_in,PC_out,
  IR_in,IR_out,
  do_stall,
  do_flush,
  );



  input clk;
  input rst;
  input Write;
  input do_stall;
  input do_flush;
  input [31:0] PC_in;
  input [31:0] IR_in;

  reg [31:0]  PC_mid;
  reg [31:0]  IR_mid;

  output reg [31:0] PC_out;
  output reg [31:0] IR_out;


  always @ ( negedge clk ) begin
    if(do_flush)
    begin
      PC_mid = 0;
      IR_mid = 0;
    end


    else if(Write&&(~do_stall))
    begin
      PC_mid = PC_in;
      IR_mid = IR_in;
    end //end if
  end

  always @(posedge clk or posedge rst)
  begin
    if (rst)
    begin
      $display("[IF/ID flush]");
      PC_out = 0;
      IR_out = 0;
      PC_mid = 0;
      IR_mid = 0;
    end //end if

    else if(Write)
    begin
      PC_out = PC_mid;
      IR_out = IR_mid;
    end // end else
  end //end always




endmodule
