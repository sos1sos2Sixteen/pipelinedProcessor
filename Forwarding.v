module Forwarding (
  EX_M_regWrite,
  EX_M_rd,
  ID_EX_rs,
  ID_EX_rt,
  forwardA,
  forwardB
  );
  //处理 EX-EX旁路 MEM-EX旁路
  //这是一个纯组合单元

  input       EX_M_regWrite;
  input [4:0] EX_M_rd;
  input [4:0] ID_EX_rs;
  input [4:0] ID_EX_rt;

  output forwardA;
  output forwardB;

  assign forwardA = (EX_M_regWrite &&
                    (EX_M_rd != 0) &&
                    (EX_M_rd == ID_EX_rs)) ?
                    1 : 0;
  assign forwardB = (EX_M_regWrite &&
                    (EX_M_rd != 0) &&
                    (EX_M_rd == ID_EX_rt)) ?
                    1 : 0;



endmodule // Forwarding
