`include "ctrl_encode_def.v"

module Alu(AluResult,Zero,DataIn1,DataIn2,AluCtrl);

	input  [31:0] 	DataIn1;		//运算数据1
	input  [31:0]		DataIn2;		//运算数据2
	input  [4:0]		AluCtrl;		//运算器控制信号

	output reg[31:0]		AluResult;		//运算器输出结果
	output reg				Zero;			//结果是否为零
	reg [31:0] temp = 0;

	initial								//初始化数据
	begin
		Zero = 0;
		AluResult = 0;
	end

	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
	  case (AluCtrl)
	    `ALUOp_ADDU: AluResult = DataIn1 + DataIn2;
	    `ALUOp_SUBU: AluResult = DataIn1 - DataIn2;
	    `ALUOp_OR  : AluResult = DataIn1 | DataIn2;
			`ALUOp_SLT :
				begin
					assign temp = DataIn1 - DataIn2;
					AluResult = {31'b0, temp[31]};
				end // end slt
			`ALUOp_SLL : AluResult = DataIn2 << DataIn1;
			`ALUOp_SRL : AluResult = DataIn2 >> DataIn1;
			`ALUOp_AND : AluResult = DataIn1 & DataIn2;
			`ALUOp_XOR : AluResult = DataIn1 ^ DataIn2;
			`ALUOp_SRA :
				begin
					for(temp = 0;temp < 32; temp = temp + 1)
					begin
						if(temp < DataIn1)
						begin
							AluResult[31 - temp] = DataIn2[31];
						end //end if
						else
							AluResult[31 - temp] = DataIn2[31 - (temp - DataIn1)];
						begin
						end //end else
					end //end for
				end // end SRA
	    default: ;
	  endcase

	assign Zero = (AluResult == 0) ? 1 : 0;

	end




endmodule
