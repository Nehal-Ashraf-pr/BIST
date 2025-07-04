`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:11 06/26/2025 
// Design Name: 
// Module Name:    LFSR_input 
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
module LFSR_input(
    input wire clk,
	 input wire reset,
	 output reg [7:0] q
	 );
	 
	 always@(posedge clk)begin
	 if(reset)
	    q<=8'd1;
	 else begin
	 q[0]<=q[7];
	 q[1]<=q[0]^q[7];
	 q[2]<=q[1];
	 q[3]<=q[2];
	 q[4]<=q[3]^q[7];
	 q[5]<=q[4]^q[7];
	 q[6]<=q[5];
	 q[7]<=q[6];
	 end
	 end

endmodule
