`timescale 1ns/100ps

 module Mips_tb();

   reg clk, rst;
   reg [10:0] i;

   // Mips U_mips(.Clk(clk),.Reset(rst));
   pipeMips U_mips(.clock(clk),.reset(rst));

   initial begin
      // $readmemh( "testcodehex.txt" , U_mips.U_IM.IMem ) ;
      // $monitor("PC = 0x%8X, IR = 0x%8X", U_mips.U_pcUnit.PC, U_mips.opCode );
      //$monitor("PC = 0x%8X", U_mips.U_pcUnit.PC );
      $readmemh("pipecodehex.txt", U_mips.P_IM.IMem);
      $monitor("PC = 0x%8X", U_mips.PC_UNIT.PC);

      for(i = 0; i < 20; i = i + 1)begin
        $display("im[%d]=%h",i,U_mips.P_IM.IMem[i]);
      end
      clk = 1 ;
      rst = 0 ;
      #5 rst = 1 ;
      #20 rst = 0 ;

      $dumpfile("dff.vcd");
      $dumpvars;
   end

   always
   begin
    $display("--------------NEW CYCLE-------------");
	   #(50) clk = ~clk;
  end
endmodule
