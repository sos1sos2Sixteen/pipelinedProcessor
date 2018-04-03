module pipeline_ctrl (
  clock,
  branch,
  pipeline_lock,
  pipeline_clear;
  );

  input branch;
  input clock;

  output reg [3:0] pipeline_lock;
  output reg [3:0] pipeline_clear;

  always @ ( posedge clock ) begin
    if(branch)
    begin
      $display("[PIPELINE CTRL]:BRANCH!");
      pipeline_lock = 4'b0001;
      pipeline_clear = 4'b1100;
    end // end if

    else
    begin
      $display("[PIPELINE CTRL]:NOTHING");
      pipeline_lock = 4'b1111;   //0:不让写 1:让写
      pipeline_clear = 4'b0000;  //0:不清零 1:清零
    end // end else
  end

endmodule // pipeline_ctrl
