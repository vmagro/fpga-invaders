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
	
	//assign Aliens_Grid = 50'h3FFFFFFFFFFFF;
	
	parameter AlienWidth = 30;
	parameter PlayerWidth = 30;
	parameter AlienWidthSpacing = 10;
	parameter AlienHeight = 20;
	parameter PlayerHeight = 20;
	parameter AlienHeightSpacing = 10;
	parameter NumCols = 10;
	
	integer i, j;
	
	assign Bullet_Onscreen = ((Bullet_Row > 0) && (Bullet_Row < 480));
	assign Aliens_Defeated = (Aliens_Grid == 0);
	
	always @(posedge Clk) begin
		if (Reset) begin
			Aliens_Grid <= 50'h3FFFFFFFFFFFF;
			Bullet_Row <= 500;
			Bullet_Col <= 9'bXXXXXXXXX;
		end
		else begin
			if (Bullet_Fired && ~Bullet_Onscreen) begin
				Bullet_Row <= Player_Row;
				Bullet_Col <= Player_Col;
			end
			if (Bullet_Onscreen) begin
				Bullet_Row <= Bullet_Row - 10;
			end
			for (i=0; i < 5; i = i+1) begin
				for (j=0; j < 10; j = j+1) begin
					//is it in the right row to hit an alien?
					if ((Bullet_Row >= (j * (AlienWidth + AlienWidthSpacing))) && (Bullet_Row <= (j * (AlienWidth + AlienWidthSpacing) + AlienWidth))) begin
						if ((Bullet_Col >= (i * (AlienHeight + AlienHeightSpacing))) && (Bullet_Col <= (i * (AlienHeight + AlienHeightSpacing)))) begin
							Aliens_Grid[i * NumCols + j] <= 0;
						end
					end
				end
			end
		end
	end
endmodule
