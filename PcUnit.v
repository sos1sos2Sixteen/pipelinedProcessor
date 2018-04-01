
module PcUnit(PC,PcReSet,PcSel,nextPC,Clk,branchAddr);

	input   PcReSet;
	input 	PcSel;
	input   Clk;
	input [31:0] nextPC;
	input [31:0] branchAddr;

	output reg[31:0] PC;

	always@(posedge Clk or posedge PcReSet)
	begin
		if(PcReSet == 1)
			PC <= 32'h0000_3000;

		case(PcSel)
			1'b1:
			begin
				$display("[PC:BRANCH]");
				PC = branchAddr;
			end //end branch

			1'b0:
			begin
				$display("[PC:NORMAL]");
				PC = nextPC;
			end //end normal
		endcase

	end
endmodule
