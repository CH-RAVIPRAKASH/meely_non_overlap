
module melay_non_over(clk_i,rst_i,in,valid_i,out);


	parameter S_R=4'b0001;
	parameter S_B=4'b0010;
	parameter S_BC=4'b0100;
	parameter S_BCB=4'b1000;

	input clk_i,rst_i,in,valid_i;
	output reg out;

//internal registers
    reg [3:0] present_state;
    reg [3:0] next_state;

always @(posedge clk_i) begin
	if (rst_i==1) begin
			out=0;
			present_state=S_R;
			next_state=S_R;
	end
	else begin
			if (valid_i==1) begin
				case(present_state) 
				S_R:begin
					if (in == 1) begin
						out=0;
						next_state=S_B;
					end
					else begin
						out=0;
						next_state=S_R;
					end
					end
				S_B:begin
					if (in == 1) begin
						out=0;
						next_state=S_B;
					end
					else begin
						out=0;
						next_state=S_BC;
					end
					end
				S_BC:begin
					if (in == 1) begin
						out=0;
						next_state=S_BCB;
					end
					else begin
						out=0;
						next_state=S_R;
					end
					end
				S_BCB:begin
					if (in == 1) begin
						out=1;
						next_state=S_R;
					end
					else begin
						out=0;
						next_state=S_R;
					end
				end
			endcase
		end
  end

end

always @(next_state) begin  // to update the case condition 
	present_state=next_state;
end

endmodule
