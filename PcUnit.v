
module PcUnit(
	PC,
	PcReSet,
	PcSel,
	dojump,
	nextPC,
	Clk,
	branchAddr,
	jumpAddr,
	do_stall
	);

	input   		 PcReSet;
	input 			 PcSel;
	input 			 dojump;
	input   		 Clk;
	input [31:0] nextPC;
	input [31:0] branchAddr;
	input [31:0] jumpAddr;
	input 			 do_stall;

	reg [31:0] realBranchAddr;
	reg [31:0] realJumpAddr;

	output reg[31:0] PC;

	wire [1:0] selector = {PcSel,dojump};
	//将pcSel即branch信号与jump信号整合方便接下来选择分支
	//其中有
	// 00 -> NORMAL
	// 01 -> JUMP
	// 11 -> invalid
	// 10 -> BRANCH

	always @ ( negedge Clk ) begin
		realBranchAddr = branchAddr;
		realJumpAddr   = jumpAddr;
	end

	always@(posedge Clk or posedge PcReSet)
	begin
		if(PcReSet == 1)
			PC <= 32'h0000_3000;

		$display("[PC:GET CONTROL]:%b",selector);
		case(selector)
			2'b10:
			begin
				$display("[PC:BRANCH]");
				PC = realBranchAddr;
			end //end branch

			2'b00:
			begin
				if(!do_stall)
				begin
					$display("[PC:NORMAL]");
					PC = nextPC;
				end // end if
				else
				begin
					$display("[PC:do stall]");
				end // end else
			end //end normal

			2'b01:
			begin
				$display("[PC:JUMP]");
				PC = realJumpAddr;
			end // end jump

			default:
			begin
				$display("[PC:IN VALID OPERATION]");
			end
		endcase

	end
endmodule
