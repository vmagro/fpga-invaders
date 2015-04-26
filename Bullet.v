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
	input [8:0] Player_Row,
	input [9:0] Player_Col,
	output reg [8:0] Bullet_Row,
	output reg [9:0] Bullet_Col,
	output Aliens_Defeated,
	output Bullet_Onscreen,
	output reg [49:0] Aliens_Grid
);


	reg[3:0] AlienX;
	reg[3:0] AlienY;
	reg[9:0] x_t;
	reg[9:0] y_t;

	parameter AlienWidth = 30;
	parameter PlayerWidth = 30;
	parameter AlienWidthSpacing = 10;
	parameter AlienHeight = 20;
	parameter PlayerHeight = 20;
	parameter AlienHeightSpacing = 10;
	parameter NumCols = 10;
	parameter BulletWidth = 4;
	parameter BulletHeight = 8;

	assign Bullet_Onscreen = ((Bullet_Row > 0) && (Bullet_Row < 480));
	assign Aliens_Defeated = (Aliens_Grid == 0);

	always @(posedge Clk) begin
		if (Reset || Aliens_Defeated) begin
		  Aliens_Grid <= 50'h3FFFFFFFFFFFF;
		  Bullet_Row <= 500;
		  Bullet_Col <= 350;
		end
		else begin
			if (Bullet_Fired && ~Bullet_Onscreen) begin
				Bullet_Row <= Player_Row;
				Bullet_Col <= Player_Col + PlayerWidth / 2;
			end
			if (Bullet_Onscreen) begin
				Bullet_Row <= Bullet_Row - 20;
			end
			if (Bullet_Col >= Aliens_Col && Bullet_Row >= Aliens_Row) begin
				x_t = Bullet_Col + (BulletWidth / 2) - Aliens_Col;
				y_t = Bullet_Row + (BulletHeight / 2) - Aliens_Row;
				AlienX = x_t / (AlienWidth + AlienWidthSpacing);
				AlienY = y_t / (AlienHeight + AlienHeightSpacing);
				x_t = x_t % (AlienWidth + AlienWidthSpacing);
				y_t = y_t % (AlienHeight + AlienHeightSpacing);
				if (x_t < AlienWidth && y_t < AlienHeight && Aliens_Grid[AlienY * NumCols + AlienX]&& Bullet_Col < Aliens_Col + 10 * (AlienWidth + AlienWidthSpacing) && Bullet_Row < Aliens_Row + 5 * (AlienHeight + AlienHeightSpacing)) begin
					Aliens_Grid[AlienY * NumCols + AlienX] <= 0;
					Bullet_Row <= 500;
				end
			end
		end
	end
endmodule