`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:20:47 04/13/2015 
// Design Name: 
// Module Name:    Bullet 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: checks if existing bullet on screen so it doesn't fire again
//checks if collision with alien
//
//////////////////////////////////////////////////////////////////////////////////
module Bullet(
	 input Clk,
	 input Reset,
    input Bullet_Fired,
    input [8:0] Aliens_Row,
    input [9:0] Aliens_Col,
    output [8:0] Bullet_Row,
    output [9:0] Bullet_Col,
    output Aliens_Defeated,
    output Bullet_Onscreen,
	 output [49:0] Aliens_Grid
    );

	assign Aliens_Grid = 50'h3FFFFFFFFFFFF;
endmodule
