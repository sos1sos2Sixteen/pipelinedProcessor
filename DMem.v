`timescale 1ns/100ps


module DMem(DataOut,DataAdr,DataIn,DMemW,DMemR,clk);							//TODO 数据存储的地址是字地址 汇编的地址是字节地址
	input [4:0] DataAdr;
	input [31:0] DataIn;
	input 		 DMemR;
	input 		 DMemW;
	input 		 clk;

	output[31:0] DataOut;

	reg [31:0]  DMem[1023:0];

	always@(posedge clk) #5
	begin
		if(DMemW)
		begin
			DMem[DataAdr] = DataIn;
		end
		else
		begin
			DMem[DataAdr] = DMem[DataAdr];
		end

			$display("[DMem Write]");
			$display("addr = %8X",DataAdr);//addr to DMy
      $display("Data in = %8X",DataIn);//data to DM
      $display("Mem[00-07] = %8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",DMem[0],DMem[1],DMem[2],DMem[3],DMem[4],DMem[5],DMem[6],DMem[7]);

	end


	assign DataOut = DMem[DataAdr];


endmodule
