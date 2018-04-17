module Forwarding (
  EX_M_regWrite,
  EX_M_rd,
  ID_EX_rs,
  ID_EX_rt,
  M_WB_regWrite,
  M_WB_rd,
  forwardA,
  forwardB
  );
  //处理 EX-EX旁路 MEM-EX旁路
  //这是一个纯组合单元

  input       EX_M_regWrite;
  input [4:0] EX_M_rd;
  input [4:0] ID_EX_rs;
  input [4:0] ID_EX_rt;
  input       M_WB_regWrite;
  input [4:0] M_WB_rd;

  output [1:0] forwardA;
  output [1:0] forwardB;

  // assign forwardA = (EX_M_regWrite &&
  //                   (EX_M_rd != 0) &&
  //                   (EX_M_rd == ID_EX_rs)) ?
  //                   2'b10 : 2'b00;
  // assign forwardB = (EX_M_regWrite &&
  //                   (EX_M_rd != 0) &&
  //                   (EX_M_rd == ID_EX_rt)) ?
  //                   2'b10 : 2'b00;
  assign forwardA = (EX_M_regWrite &&
                    (EX_M_rd != 0) &&
                    (EX_M_rd == ID_EX_rs)) ?
                    2'b10 :
                    (M_WB_regWrite &&
                      M_WB_rd != 0 &&
                      M_WB_rd == ID_EX_rs)? 2'b11 : 2'b00;

  assign forwardB = (EX_M_regWrite &&
                    (EX_M_rd != 0) &&
                    (EX_M_rd == ID_EX_rt)) ?
                    2'b10 :
                    (M_WB_regWrite &&
                      M_WB_rd != 0 &&
                      M_WB_rd == ID_EX_rt)? 2'b11 : 2'b00;

  // 10 -> ex ex 冒险
  // 11 -> mem ex 冒险
  // 00 -> 无冒险



endmodule // Forwarding
