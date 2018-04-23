module pipeline_ctrl (
  branch,
  jump,
  pipeline_lock,
  pipeline_clear,
  );

  input branch;
  input jump;

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


  //pipeline lock 是锁定信号,在此期间对应寄存器的write信号无效,无法读取下阶段的内容
  //其中1是正常 0是不允许写
  assign pipeline_lock = jump?4'b1111:4'b1111;


  // branch?4'b1111:4'b1111;

  //这个设置要注意两方面
  //1. 四位数字的最低位(最右)是起始的寄存器,即IF/ID寄存器
  //2. branch信号的来源寄存器需要正确处理,不能当场清零,应该让他的上级寄存器清零,自己不锁定也不清零;正常流向下一级

  //pipeline clear 是复位信号 其中设为1是'复位',0是'正常'
  assign #5 pipeline_clear= branch?4'b0011:4'b0000;



  // assign pipeline_lock = do_stall?
  //         4'b1110:(branch?4'b1111:4'b1111);
  // assign #5 pipeline_clear= do_stall?
  //         4'b0010:(branch?4'b0011:4'b0000);

endmodule // pipeline_ctrl
