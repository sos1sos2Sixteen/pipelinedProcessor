module pipeline_ctrl (
  clock,
  branch,
  pipeline_lock,
  pipeline_clear
  );

  input branch;
  input clock;

  // output reg [3:0] pipeline_lock;
  // output reg [3:0] pipeline_clear;

  // always @ ( posedge clock ) begin
  //   if(branch)
  //   begin
  //     $display("[PIPELINE CTRL]:BRANCH!");
  //     pipeline_lock = 4'b0001;
  //     pipeline_clear = 4'b1100;
  //   end // end if
  //
  //   else
  //   begin
  //     $display("[PIPELINE CTRL]:NOTHING");
  //     pipeline_lock = 4'b1111;   //0:不让写 1:让写
  //     pipeline_clear = 4'b0000;  //0:不清零 1:清零
  //   end // end else
  // end

  output [3:0] pipeline_lock;
  output [3:0] pipeline_clear;

  // assign pipeline_lock = branch?4'b0001:4'b1111;
  // assign pipeline_clear= branch?4'b1100:4'b0000;

  assign pipeline_lock = branch?4'b1100:4'b1111;
  assign #5 pipeline_clear= branch?4'b0011:4'b0000;

endmodule // pipeline_ctrl
