`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:49 04/07/2015 
// Design Name: 
// Module Name:    analog_speaker 
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
module audio(
    input clk,
	 input rst,
	 input shot,
	 input collision,
    output reg pin
    );
	 
reg[32:0] shooting;
reg[32:0] colliding;

reg[32:0] div_clk;

always @(posedge clk) begin
	if (~rst) begin
		div_clk <= 0;
		pin <= 0;
		
		shooting <= 0;
		colliding <= 0;
	end
	
	div_clk <= div_clk + 1;
	
	if (shot && shooting == 0) begin
		shooting <= 12000000;
		div_clk <= 0;
	end
	
	if (collision && colliding == 0) begin
		colliding <= 12000000;
		shooting <= 0;
		div_clk <= 0;
	end
	
	if (shooting > 0) begin
		pin <= div_clk[16];
		shooting <= shooting - 1;
	end
	
	if (colliding > 0) begin
		pin <= div_clk[19];
		colliding <= colliding - 1;
	end
end

endmodule
