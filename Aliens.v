`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:40 04/13/2015 
// Design Name: 
// Module Name:    Aliens 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: logic for which direction they move or shift down
//
//////////////////////////////////////////////////////////////////////////////////
module Aliens(
    input Clk,
    input Reset,
	 input [49:0] Aliens_Grid,
    output [8:0] AliensRow,
	 output [9:0] AliensCol,
    output Reached_Bottom
    );
	 
	 reg [8:0] AliensRow_t;
	 reg [9:0] AliensCol_t;
	 reg MovingRight;
	 reg Reached_Bottom_t;
	 
	 assign AliensRow = AliensRow_t;
	 assign AliensCol = AliensCol_t;
	 assign Reached_Bottom = Reached_Bottom_t;
	 //assign Reached_Bottom = AliensRow_t + Total_Alien_Height > Player_Row;
	 
	 parameter HorizontalMovement = 5;
	 parameter VerticalMovement = 10;
	 parameter AlienHeight = 20;
	 parameter AlienHeightSpacing = 10;	 
	 parameter Player_Row = 420;
	 
	 always @(posedge Clk, posedge Reset)
	 begin
		if (Reset)
		begin
			AliensRow_t <= 0;
			AliensCol_t <= 10;
			MovingRight <= 1;
			Reached_Bottom_t <= 0;
		end
		else if (~Reached_Bottom)
		begin
			if (MovingRight)
			begin
				AliensCol_t <= AliensCol_t + HorizontalMovement;
				if (AliensCol_t + 390 > 625)
				begin
					MovingRight <= ~MovingRight;
					AliensRow_t <= AliensRow_t + VerticalMovement;
					AliensCol_t <= AliensCol_t;
				end
			end
			else
			begin
				AliensCol_t <= AliensCol_t - HorizontalMovement;
				if (AliensCol_t < 10)
				begin
					MovingRight <= ~MovingRight;
					AliensRow_t <= AliensRow_t + VerticalMovement;
					AliensCol_t <= AliensCol_t;
				end
			end
			if ((AliensRow_t + AlienHeight * 5 + AlienHeightSpacing * 4 > Player_Row) && Aliens_Grid[49:40])
				Reached_Bottom_t <= 1;
			else if ((AliensRow_t + AlienHeight * 4 + AlienHeightSpacing * 3 > Player_Row) && Aliens_Grid[39:30])
				Reached_Bottom_t <= 1;
			else if ((AliensRow_t + AlienHeight * 3 + AlienHeightSpacing * 2 > Player_Row) && Aliens_Grid[29:20])
				Reached_Bottom_t <= 1;	
			else if ((AliensRow_t + AlienHeight * 2 + AlienHeightSpacing * 1 > Player_Row) && Aliens_Grid[19:10])
				Reached_Bottom_t <= 1;
			else if ((AliensRow_t + AlienHeight > Player_Row) && Aliens_Grid[9:0])
				Reached_Bottom_t <= 1;
		end
	 end
	 
	 


endmodule
