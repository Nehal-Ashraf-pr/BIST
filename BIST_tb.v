`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:31:53 06/26/2025
// Design Name:   LFSR_input
// Module Name:   D:/ISEex/ALU_BIST/lfsr_tb.v
// Project Name:  ALU_BIST
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LFSR_input
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BIST_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] q;
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
	wire [73:0] MISR;
	
	parameter Golden=74'd5690799878988334810892;//1347fb692ca37a6c70c in hex at 2165ns q=153 after this q again repeats from 1

	// Instantiate the Unit Under Test (UUT)
	LFSR_input uut (
		.clk(clk), 
		.reset(reset), 
		.q(q)
	);

   CUT_ALU test(.clk(clk),.reset(reset),
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
				
				MISR_golden_sign sign(.clk(clk),.reset(reset),.MISR(MISR));
				
    initial clk=0;
    always #5 clk=~clk;
	 
	initial begin
		// Initialize Inputs
		reset = 1;
		// Wait 100 ns for global reset to finish
		#10 reset=0;
		
		$monitor("t=%0t,q=%d,MISR=%h",$time,q,MISR);
		
		#2165;
		// Add stimulus here

	end
      
endmodule

