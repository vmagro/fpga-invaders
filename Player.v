`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:11:52 04/13/2015 
// Design Name: 
// Module Name:    Player 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: boundary checking
//
//////////////////////////////////////////////////////////////////////////////////
module Player(
    input Clk,
    input Reset,
    input [3:0] Joystick_data,
    output [8:0] Player_Row,
    output [9:0] Player_Col
    );
	 
	 reg [8:0] Player_Row_t;
	 reg [9:0] Player_Col_t;
	 
	 assign Player_Row = Player_Row_t;
	 assign Player_Col = Player_Col_t;
	 
	 always @(posedge Clk, posedge Reset)
	 begin
		if (Reset)
		begin
			Player_Col_t <= 310;
			Player_Row_t <= 400;
		end
		else if (Joystick_data > 6 && Player_Col_t < 600)
			Player_Col_t <= Player_Col_t + 5;
		else if (Joystick_data < 4 && Player_Col_t > 5)
			Player_Col_t <= Player_Col_t - 5;
	 end


endmodule
