module Stall (
  ID_EX_memRead,
  ID_EX_rt,
  IF_ID_rs,
  IF_ID_rt,
  do_stall
  );

  input [4:0] ID_EX_rt;
  input [4:0] IF_ID_rs;
  input [4:0] IF_ID_rt;
  input       ID_EX_memRead;

  output      do_stall;

  //1 -> do stall
  // 0 -> do not stall
  assign do_stall =
        ((ID_EX_memRead) &&
        ((ID_EX_rt == IF_ID_rs) ||
        (ID_EX_rt == IF_ID_rt)))?
        1'b1:1'b0;

endmodule // Stall
