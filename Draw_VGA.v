`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:42 04/13/2015 
// Design Name: 
// Module Name:    Draw_VGA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Aliens: 30x20 10spacing.
// Player: 30x20
//
//////////////////////////////////////////////////////////////////////////////////
module Draw_VGA(
    input [49:0] Aliens_Grid,
    input [8:0] AliensRow,
    input [9:0] AliensCol,
    input [8:0] PlayerRow,
    input [9:0] PlayerCol,
    input Clk,
    input Reset,
    input [8:0] BulletRow,
    input [9:0] BulletCol,
    input BulletExists,
	 input [9:0] CounterX,
	 input [9:0] CounterY,
	 input inDisplayArea,
	 input Reached_Bottom,
	 input Aliens_Defeated,
	 output R,
	 output G,
	 output B
    );
	 
	 
	 
	////Draw stuff 
	
	parameter AlienWidth = 30;
	parameter PlayerWidth = 30;
	parameter AlienWidthSpacing = 10;
	parameter AlienHeight = 20;
	parameter PlayerHeight = 20;
	parameter AlienHeightSpacing = 10;
	parameter NumCols = 10;
	parameter BulletWidth = 4;
	parameter BulletHeight = 8;
	
	//reg R, B;
	//reg vga_r_t, vga_g_t, vga_b_t;
	
	//assign vga_r = vga_r_t;
	//assign vga_g = vga_g_t;
	//assign vga_b = vga_b_t;
	
	reg R_t, B_t;
	reg [3:0] AlienX;
	reg [3:0] AlienY;
	reg isAlien;
	reg [9:0] CounterX_t;
	reg [9:0] CounterY_t;
	
	//Drawing Player
	assign G = ~Reached_Bottom && (CounterX >= PlayerCol) && (CounterX < (PlayerCol + PlayerWidth)) && (CounterY >= PlayerRow) 
					&& (CounterY < (PlayerRow + PlayerHeight));
	assign R = R_t;
	//assign G = G_t;
	assign B = B_t;
	
	//integer i,j;
	always @(*)
	begin
		if (Reset)
		begin
			R_t = 0;
			B_t = 0;
			AlienX = 0;
			AlienY = 0;
			isAlien = 0;
			CounterX_t = 10'bxxxxxxxxxx;
			CounterY_t = 10'bxxxxxxxxxx;
		end
		else if (~Reached_Bottom)
		begin
		
			//Drawing Aliens
			isAlien = 0;
			AlienX = 0;
			AlienY = 0;
			CounterX_t = CounterX;
			CounterY_t = CounterY;
			R_t = 0;
			B_t = 0;
			if (CounterX_t >= AliensCol && CounterY_t >= AliensRow)
			begin
				CounterX_t = CounterX_t - AliensCol;
				CounterY_t = CounterY_t - AliensRow;
				AlienX = CounterX_t / (AlienWidth + AlienWidthSpacing);
				AlienY = CounterY_t / (AlienHeight + AlienHeightSpacing);
				CounterX_t = CounterX_t % (AlienWidth + AlienWidthSpacing);
				CounterY_t = CounterY_t % (AlienHeight + AlienHeightSpacing);
				if (CounterX_t < AlienWidth && CounterY_t < AlienHeight && Aliens_Grid[AlienY * NumCols + AlienX] && CounterX < AliensCol + 10 * (AlienWidth + AlienWidthSpacing) && CounterY < AliensRow + 5 * (AlienHeight + AlienHeightSpacing))
					R_t = 1;
			end
			
			//Drawing Bullet
			if (BulletExists)
			begin
				if (CounterX >= BulletCol && CounterX < BulletCol + BulletWidth && CounterY >= BulletRow && CounterY < BulletRow + BulletHeight)
					B_t = 1;
			end
		end
		else
		begin
			R_t = 1;
		end
	end
	
/*	always @(posedge Clk)
	begin
		vga_r_t <= R & inDisplayArea;
		vga_g_t <= G & inDisplayArea;
		vga_b_t <= B & inDisplayArea;
	end*/


endmodule
