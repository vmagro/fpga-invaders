`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:43:22 04/15/2015
// Design Name:   Draw_VGA
// Module Name:   C:/Users/Brian/USC/EE-254/Final Project/Space_Invaders/Draw_VGA_tb.v
// Project Name:  Space_Invaders
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Draw_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Draw_VGA_tb;

	// Inputs
	reg [49:0] Aliens_Grid;
	reg [8:0] AliensRow;
	reg [9:0] AliensCol;
	reg [8:0] PlayerRow;
	reg [9:0] PlayerCol;
	reg Clk;
	reg Reset;
	reg [8:0] BulletRow;
	reg [9:0] BulletCol;
	reg BulletExists;
	reg [9:0] CounterX;
	reg [9:0] CounterY;
	reg inDisplayArea;

	// Outputs
	wire R;
	wire G;
	wire B;
	
	//integer i;

	// Instantiate the Unit Under Test (UUT)
	Draw_VGA uut (
		.Aliens_Grid(Aliens_Grid), 
		.AliensRow(AliensRow), 
		.AliensCol(AliensCol), 
		.PlayerRow(PlayerRow), 
		.PlayerCol(PlayerCol), 
		.Clk(Clk), 
		.Reset(Reset), 
		.BulletRow(BulletRow), 
		.BulletCol(BulletCol), 
		.BulletExists(BulletExists), 
		.CounterX(CounterX), 
		.CounterY(CounterY), 
		.inDisplayArea(inDisplayArea), 
		.R(R), 
		.G(G), 
		.B(B)
	);
	
	always begin #1; Clk = ~Clk; end

	initial begin
		// Initialize Inputs
		Aliens_Grid = 50'h3FFFFFFFFFFFF;
		AliensRow = 0;
		AliensCol = 0;
		PlayerRow = 0;
		PlayerCol = 0;
		Clk = 0;
		Reset = 1;
		BulletRow = 0;
		BulletCol = 0;
		BulletExists = 0;
		CounterX = 0;
		CounterY = 0;
		inDisplayArea = 1;
		

		// Wait 100 ns for global reset to finish
		#100;
      Reset = 0;

		// Add stimulus here
		
		//for (i=0; i < 200; i = i+1)
		forever
		begin
			#1
			CounterX <= CounterX + 1;
			if(CounterX == 640)
				begin
					CounterX <= 0;
					CounterY <= CounterY + 1;
					 if(CounterY == 480) 
						begin CounterY <= 0; end
				end
		end				

/*      	#1
				CounterX <= CounterX + 1;
				if(CounterX == 500)
				begin
					CounterX <= 0;
					CounterY <= CounterY + 1;
					 if(CounterY == 400) 
						begin CounterY <= 0; end
				end
				
					#1
				CounterX <= CounterX + 1;
				if(CounterX == 500)
				begin
					CounterX <= 0;
					CounterY <= CounterY + 1;
					if(CounterY == 400)
						begin CounterY <= 0; end
				end*/
	end
endmodule

