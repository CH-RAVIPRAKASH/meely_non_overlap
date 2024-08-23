
`include "melay_non_over.v"

module tb;

	parameter S_R=4'b0001;
	parameter S_B=4'b0010;
	parameter S_BC=4'b0100;
	parameter S_BCB=4'b1000;

	reg clk_i,rst_i,in,valid_i;
	wire out;
    integer count;

 melay_non_over dut (clk_i,rst_i,in,valid_i,out);

 always begin
	clk_i=0;#5;
	clk_i=1;#5;
 end

 initial begin
	clk_i=0;rst_i=1;
	in=0;
	valid_i=0;
	count=0;
    repeat(2)@(posedge clk_i);
	rst_i=0;
	repeat(50) begin
	@(posedge clk_i);
		valid_i=1;
		in=$random;
	end
		@(posedge clk_i);
		valid_i=0;
		in=0;
		$display("number of times pattern detected count=%0d",count);
 end

always @(posedge out) begin
	count=count+1;
end

initial #1000 $finish();

endmodule
