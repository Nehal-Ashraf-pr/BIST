`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:16 06/26/2025 
// Design Name: 
// Module Name:    MISR_golden_sign 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MISR_golden_sign(
    input clk,
	 input reset,
	 output reg[73:0] MISR
    );
	
	wire [7:0]sum;
   wire cout;
	wire [7:0]sub;
	wire borrow;
	wire [15:0] mul;
	wire [7:0] out_xor;
	wire [7:0] out_xnor;
	wire [7:0] out_NAND;
	wire [7:0] out_LL;
	wire [7:0] out_LR;
	
	
	CUT_ALU misr_in(.clk(clk),.reset(reset),
	         .sum(sum),
				.cout(cout),
				.sub(sub),
				.borrow(borrow),				
				.mul(mul),
				.out_xor(out_xor),
				.out_xnor(out_xnor),
				.out_NAND(out_NAND),
				.out_LL(out_LL),
				.out_LR(out_LR)
				);
				
				wire [73:0] MISR_in;
				assign MISR_in={sum,cout,sub,borrow,mul,out_xor,out_xnor,out_NAND,out_LL,out_LR};
				
		
	  initial MISR=74'd0;
	  
	  wire [73:0] w1;
	  //assign w1=74'd0;
	  shifter_2 s0(.a(MISR_in[0]),.b(w1[73]),.c(w1[0]),.clk(clk),.reset(reset));
	  
	  genvar i;
	  generate
	  for(i=1;i<=73;i=i+1) begin: gen_loop
	          if(i==69||i==70||i==73) begin:fb_loop
				 shifter_3 s3(.a(MISR_in[i]),.b(w1[i-1]),.fb(w1[73]),.c(w1[i]),.clk(clk),.reset(reset));
				 end
	         else begin:norm_loop
	           shifter_2 s1(.a(MISR_in[i]),.b(w1[i-1]),.c(w1[i]),.clk(clk),.reset(reset));
				  end
	  end
	  endgenerate
	  
	  
	  always@(posedge clk)begin
			  if(reset)
			  MISR<=74'd0;
			  else 
			  MISR<=w1;
			end
			
			
	  
endmodule

module shifter_2(
    input a,
	 input b,
	 input clk,
	 input reset,
	 output reg c
	 );
	 
	 always@(posedge clk)begin
	 if(reset)
	    c<=1'b0;
		 else
	 c<=a^b;
	 end
	 
endmodule

module shifter_3(
    input a,
	 input b,
	 input fb,
	 input reset,
	 input clk,
	 output reg c
	 );
	 
	 always@(posedge clk)begin
	 if(reset)
	    c<=1'b0;
		 else
	 c<=a^b^fb;
	 end
	 
endmodule
