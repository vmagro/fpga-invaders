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
    output [8:0] AliensRow,
	 output [9:0] AliensCol,
    output Reached_Bottom
    );
	 
	 reg [8:0] AliensRow_t;
	 reg [9:0] AliensCol_t;
	 reg MovingRight;
	 
	 assign AliensRow = AliensRow_t;
	 assign AliensCol = AliensCol_t;
	 
	 parameter HorizontalMovement = 5;
	 parameter VerticalMovement = 10;
	 
	 always @(posedge Clk, posedge Reset)
	 begin
		if (Reset)
		begin
			AliensRow_t <= 0;
			AliensCol_t <= 10;
			MovingRight <= 1;
		end
		else
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
				
		end
	 end
	 
	 


endmodule
