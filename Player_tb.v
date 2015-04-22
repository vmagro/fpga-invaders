`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:57:10 04/20/2015
// Design Name:   Player
// Module Name:   C:/Users/Brian/GitHub/fpga-invaders/Player_tb.v
// Project Name:  Space_Invaders
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Player
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Player_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg [3:0] Joystick_data;

	// Outputs
	wire [8:0] Player_Row;
	wire [9:0] Player_Col;

	// Instantiate the Unit Under Test (UUT)
	Player uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Joystick_data(Joystick_data), 
		.Player_Row(Player_Row), 
		.Player_Col(Player_Col)
	);
	
	always begin #1; Clk = ~Clk; end

	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 1;
		Joystick_data = 5;

		// Wait 100 ns for global reset to finish
		#100;
		Reset = 0;
        
		// Add stimulus here
		#5;
		Joystick_data = 7;
		#5;
		Joystick_data = 5;
		#5;
		Joystick_data = 3;
		#5;
		Joystick_data = 5;
		#5;

	end
      
endmodule

