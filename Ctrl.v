`include "instruction_def.v"
`include "ctrl_encode_def.v"

HAHAHAH
THIS IS DEV BRANCH
I CAN DO WHATEVER I WANT WITH THIS FILE
I'D DELETE THIS
AND ADD THIS

I'M TOTALY GOING TO BROKE THIS PROJECT



module Ctrl(
	jump,
	RegDst,
	Branch,
	NBranch,
	MemR,
	Mem2R,
	MemW,
	RegW,
	Alusrc,
	AluShift,
	ExtOp,
	Aluctrl,
	OpCode,
	funct);


	//TODO: 目前 jump nbranch alushift是悬空的

	input [5:0]		OpCode;				//指令操作码字段
	input [5:0]		funct;				//指令功能字段

	output reg jump;//						//指令跳转
	output reg RegDst;	// 1:[20:16] -> rt    0:[15:11] -> rd
	output reg Branch;	//					//分支
	output reg NBranch;
	output reg MemR;	//					//读存储器
	output reg Mem2R;	//					//数据存储器到寄存器堆
	output reg MemW;	//					//写数据存储器
	output reg RegW;						//寄存器堆写入数据
	output reg Alusrc;//						//运算器操作数选择
	output reg AluShift;
	output reg [1:0] ExtOp;	//					//位扩展/符号扩展选择
	output reg [4:0] Aluctrl;						//Alu运算选择


	always @(OpCode or funct) begin
	  case(OpCode)
	    `INSTR_RTYPE_OP:
	      begin
	        assign Branch = 0;
					assign NBranch= 0;
	        assign jump   = 0;
	        assign RegDst = 0;
	        assign MemR   = 0;
	        assign Mem2R  = 0;
	        assign MemW   = 0;

	        assign Alusrc = 0;
					assign AluShift=0;
	        assign ExtOp  = `EXT_ZERO;
	        case (funct)
	          `INSTR_ADDU_FUNCT:
	            begin
	              $display("[ADDU]");
	              assign Aluctrl = `ALUOp_ADDU;
								assign RegW   = 1;
	            end
	          `INSTR_SUBU_FUNCT:
	            begin
	              $display("[SUBU]");
	              assign Aluctrl = `ALUOp_SUBU;
								assign RegW   = 1;
	            end
						`INSTR_SLT_FUNCT:
							begin
								$display("[SLT]");
								assign Aluctrl = `ALUOp_SLT;
								assign RegW   = 1;
							end // end slt
						`INSTR_SLL_FUNCT:
							begin
								$display("[SLL]");
								assign AluShift = 1;
								assign Aluctrl  = `ALUOp_SLL;
								assign RegW   = 1;
							end // end sll
						`INSTR_SRL_FUNCT:
							begin
								$display("[SRL]");
								assign AluShift = 1;
								assign Aluctrl  = `ALUOp_SRL;
								assign RegW   = 1;
							end // end SRL
						`INSTR_AND_FUNCT:
							begin
								$display("[AND]");
								assign Aluctrl = `ALUOp_AND;
								assign RegW   = 1;
							end // end AND
						`INSTR_OR_FUNCT:
							begin
								$display("[OR]");
								assign Aluctrl = `ALUOp_OR;
								assign RegW   = 1;
							end // end OR
						`INSTR_XOR_FUNCT:
							begin
								$display("[XOR]");
								assign Aluctrl = `ALUOp_XOR;
								assign RegW   = 1;
							end // end XOR
						`INSTR_SRA_FUNCT:
							begin
								$display("[SRA]");
								assign AluShift = 1;
								assign Aluctrl  = `ALUOp_SRA;
								assign RegW   = 1;
							end // end SRA
						`INSTR_BREAK_FUNCT:
							begin
								$display("[BREAK]!");
								$finish;
							end //end break
						`INSTR_NOP_FUNCT:
							begin
								$display("[NOP]");
								assign RegW   = 0;
							end // end nop
	          default: ;
	        endcase
	      end // end R
	    `INSTR_ORI_OP:
	      begin
					$display("[ORI]");
	        assign Branch = 0;
					assign NBranch= 0;
	        assign jump   = 0;
	        assign RegDst = 1;
	        assign MemR   = 0;
	        assign Mem2R  = 0;
	        assign MemW   = 0;
	        assign RegW   = 1;
	        assign Alusrc = 1;
					assign AluShift=0;
	        assign ExtOp  = `EXT_ZERO;
	        assign Aluctrl= `ALUOp_OR;
	      end // end ORI
			`INSTR_LUI_OP:
				begin
					$display("[LUI]");
					assign Branch = 0;
					assign NBranch= 0;
					assign jump   = 0;
					assign RegDst = 1;
					assign MemR   = 0;
					assign Mem2R  = 0;
					assign MemW   = 0;
					assign RegW   = 1;
					assign Alusrc = 1;
					assign AluShift=0;
					assign ExtOp  = `EXT_HIGHPOS;
					assign Aluctrl= `ALUOp_ADDU;
				end // end LUI
			`INSTR_LW_OP:
				begin
					$display("[LW]");
					assign Branch = 0;
					assign NBranch= 0;
					assign jump   = 0;
					assign RegDst = 1;
					assign MemR   = 1;
					assign Mem2R  = 1;
					assign MemW   = 0;
					assign RegW   = 1;
					assign Alusrc = 1;
					assign AluShift=0;
					assign ExtOp  = `EXT_SIGNED;
					assign Aluctrl= `ALUOp_ADDU;
				end // end LW
			`INSTR_SW_OP:
				begin
					$display("[SW]");
					assign Branch = 0;
					assign NBranch= 0;
					assign jump   = 0;
					assign RegDst = 1;
					assign MemR   = 0;
					assign Mem2R  = 0;
					assign MemW   = 1;
					assign RegW   = 0;
					assign Alusrc = 1;
					assign AluShift=0;
					assign Aluctrl= `ALUOp_ADDU;
					assign ExtOp  = `EXT_SIGNED;
				end // end SW
			`INSTR_BEQ_OP:
				begin
					$display("[BEQ]");
					assign Branch = 1;
					assign NBranch= 0;
					assign jump   = 0;
					assign RegDst = 1;
					assign MemR   = 0;
					assign Mem2R  = 0;
					assign MemW		= 0;
					assign RegW		= 0;
					assign Alusrc = 0;
					assign AluShift=0;
					assign Aluctrl= `ALUOp_SUBU;
					assign ExtOp  = `EXT_SIGNED;
				end // end BEQ
			`INSTR_BNE_OP:
				begin
					$display("[BNE]");
					assign Branch = 0;
					assign NBranch= 1;
					assign jump   = 0;
					assign RegDst = 1;
					assign MemR   = 0;
					assign Mem2R  = 0;
					assign MemW		= 0;
					assign RegW		= 0;
					assign Alusrc = 0;
					assign AluShift=0;
					assign Aluctrl= `ALUOp_SUBU;
					assign ExtOp  = `EXT_SIGNED;
				end // end BNE
			`INSTR_J_OP:
			begin
				$display("[J]");
				assign Branch = 0;
				assign NBranch= 0;
				assign jump   = 1;
				assign RegDst = 1;
				assign MemR   = 0;
				assign Mem2R  = 0;
				assign MemW		= 0;
				assign RegW		= 0;
				assign Alusrc = 0;
				assign AluShift=0;
				assign Aluctrl= `ALUOp_SUBU;
				assign ExtOp  = `EXT_SIGNED;
			end // end J
			`INSTR_ADDI_OP:
			begin
				$display("[ADDI]");
				assign Branch = 0;
				assign NBranch= 0;
				assign jump   = 0;
				assign RegDst = 1;
				assign MemR   = 0;
				assign Mem2R  = 0;
				assign MemW		= 0;
				assign RegW		= 1;
				assign Alusrc = 1;
				assign AluShift=0;
				assign Aluctrl= `ALUOp_ADDU;
				assign ExtOp  = `EXT_SIGNED;
			end
	    default: $display("unkown command!!");
	  endcase
	end //end always





endmodule
