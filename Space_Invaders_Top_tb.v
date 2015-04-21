`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:23:16 04/15/2015
// Design Name:   Space_Invaders_Top
// Module Name:   C:/Users/Brian/USC/EE-254/Final Project/Space_Invaders/Space_Invaders_Top_tb.v
// Project Name:  Space_Invaders
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Space_Invaders_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Space_Invaders_Top_tb;

	// Inputs
	reg ClkPort;
	reg Sw0;
	reg Sw1;
	reg btnU;
	reg btnD;
	reg MISO;
	reg [2:0] SW;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;
	wire St_ce_bar;
	wire St_rp_bar;
	wire Mt_ce_bar;
	wire Mt_St_oe_bar;
	wire Mt_St_we_bar;
	wire An0;
	wire An1;
	wire An2;
	wire An3;
	wire Ca;
	wire Cb;
	wire Cc;
	wire Cd;
	wire Ce;
	wire Cf;
	wire Cg;
	wire Dp;
	wire LD0;
	wire LD1;
	wire LD2;
	wire LD3;
	wire LD4;
	wire LD5;
	wire LD6;
	wire LD7;
	wire SS;
	wire MOSI;
	wire SCLK;
	wire [2:0] LED;
	wire [3:0] AN;
	wire [6:0] SEG;

	// Instantiate the Unit Under Test (UUT)
	Space_Invaders_Top uut (
		.ClkPort(ClkPort), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_r(vga_r), 
		.vga_g(vga_g), 
		.vga_b(vga_b), 
		.Sw0(Sw0), 
		.Sw1(Sw1), 
		.btnU(btnU), 
		.btnD(btnD), 
		.St_ce_bar(St_ce_bar), 
		.St_rp_bar(St_rp_bar), 
		.Mt_ce_bar(Mt_ce_bar), 
		.Mt_St_oe_bar(Mt_St_oe_bar), 
		.Mt_St_we_bar(Mt_St_we_bar), 
		.An0(An0), 
		.An1(An1), 
		.An2(An2), 
		.An3(An3), 
		.Ca(Ca), 
		.Cb(Cb), 
		.Cc(Cc), 
		.Cd(Cd), 
		.Ce(Ce), 
		.Cf(Cf), 
		.Cg(Cg), 
		.Dp(Dp), 
		.LD0(LD0), 
		.LD1(LD1), 
		.LD2(LD2), 
		.LD3(LD3), 
		.LD4(LD4), 
		.LD5(LD5), 
		.LD6(LD6), 
		.LD7(LD7), 
		.MISO(MISO), 
		.SW(SW), 
		.SS(SS), 
		.MOSI(MOSI), 
		.SCLK(SCLK), 
		.LED(LED), 
		.AN(AN), 
		.SEG(SEG)
	);

	initial begin
		// Initialize Inputs
		ClkPort = 0;
		Sw0 = 0;
		Sw1 = 0;
		btnU = 0;
		btnD = 0;
		MISO = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

