`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module Space_Invaders_Top(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, Sw0, Sw1, btnU, btnD,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	//An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	//LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7,
	MISO, SW, SS, MOSI, SCLK, LED, AN, SEG,
	JB1);
	
	input ClkPort, Sw0, btnU, btnD, Sw0, Sw1;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	//output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	//output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	reg vga_r, vga_g, vga_b;
	
	//audio
	output JB1;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk, button_clk;
	wire game_clk;
	
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, Sw0);
	BUF BUF3 (start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk/*, posedge reset*/)  
	begin : CLOCK_DIVIDER
/*     if (reset)
			DIV_CLK <= 0;
      else*/
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign	game_clk = DIV_CLK[21];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
/*	reg [9:0] position;
	
	always @(posedge DIV_CLK[21])
		begin
			if(reset)
				position<=240;
			else if(joystick_data > 4'b0110)
				position<=position+2;
			else if(joystick_data < 4'b0100)
				position<=position-2;	
		end

	wire R = CounterY>=(position-10) && CounterY<=(position+10) && CounterX[8:5]==7;
	wire G = CounterX>100 && CounterX<200 && CounterY[5:3]==7;
	wire B = 0;
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end*/

	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
/*	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign LD0 = (p1_score == 4'b1010);
	assign LD1 = (p2_score == 4'b1010);
	
	assign LD2 = start;
	assign LD4 = reset;
	
	assign LD3 = (state == `QI);
	assign LD5 = (state == `QGAME_1);	
	assign LD6 = (state == `QGAME_2);
	assign LD7 = (state == `QDONE);
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = joystick_data;
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
*/	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	
	///
	///New Stuff
	///
	
	// ===========================================================================
	// 										Port Declarations
	// ===========================================================================
			//input CLK;					// 100Mhz onboard clock
			//input RST;					// Button D
			input MISO;					// Master In Slave Out, Pin 3, Port JA
			input [2:0] SW;			// Switches 2, 1, and 0
			output SS;					// Slave Select, Pin 1, Port JA
			output MOSI;				// Master Out Slave In, Pin 2, Port JA
			output SCLK;				// Serial Clock, Pin 4, Port JA
			output [2:0] LED;			// LEDs 2, 1, and 0
			output [3:0] AN;			// Anodes for Seven Segment Display
			output [6:0] SEG;			// Cathodes for Seven Segment Display

	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================
			wire SS;						// Active low
			wire MOSI;					// Data transfer from master to slave
			wire SCLK;					// Serial clock that controls communication
			reg [2:0] LED;				// Status of PmodJSTK buttons displayed on LEDs
			wire [3:0] AN;				// Anodes for Seven Segment Display
			wire [6:0] SEG;			// Cathodes for Seven Segment Display

			// Holds data to be sent to PmodJSTK
			wire [7:0] sndData;

			// Signal to send/receive data to/from PmodJSTK
			wire sndRec;

			// Data read from PmodJSTK
			wire [39:0] jstkData;

			// Signal carrying output data that user selected
			wire [9:0] posData;
			
			//Joystick hundred's place data
			wire [3:0] joystick_data;

	// ===========================================================================
	// 										Implementation
	// ===========================================================================


			//-----------------------------------------------
			//  	  			PmodJSTK Interface
			//-----------------------------------------------
			PmodJSTK PmodJSTK_Int(
					.CLK(board_clk),
					.RST(reset),
					.sndRec(sndRec),
					.DIN(sndData),
					.MISO(MISO),
					.SS(SS),
					.SCLK(SCLK),
					.MOSI(MOSI),
					.DOUT(jstkData)
			);
			


			//-----------------------------------------------
			//  		Seven Segment Display Controller
			//-----------------------------------------------
			ssdCtrl DispCtrl(
					.CLK(board_clk),
					.RST(reset),
					.DIN(posData),
					.AN(AN),
					.SEG(SEG),
					.bcd_data_11_to_8(joystick_data)
			);
			
			

			//-----------------------------------------------
			//  			 Send Receive Generator
			//-----------------------------------------------
			ClkDiv_5Hz genSndRec(
					.CLK(board_clk),
					.RST(reset),
					.CLKOUT(sndRec)
			);
			

			// Use state of switch 0 to select output of X position or Y position data to SSD
			//assign posData = (SW[0] == 1'b1) ? {jstkData[9:8], jstkData[23:16]} : {jstkData[25:24], jstkData[39:32]};
			assign posData = {jstkData[9:8], jstkData[23:16]};

			// Data to be sent to PmodJSTK, lower two bits will turn on leds on PmodJSTK
			assign sndData = {8'b100000, {SW[1], SW[2]}};

			// Assign PmodJSTK button status to LED[2:0]
			always @(sndRec or reset or jstkData) begin
					if(reset == 1'b1) begin
							LED <= 3'b000;
					end
					else begin
							LED <= {jstkData[1], {jstkData[2], jstkData[0]}};
					end
			end
	
	
	
	
	////
	////New Alien Stuff
	////


	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================
			wire [49:0] Aliens_Grid;
			wire [8:0] AliensRow;
			wire [9:0] AliensCol;
			wire [8:0] PlayerRow;
			wire [9:0] PlayerCol;
			wire [8:0] BulletRow;
			wire [9:0] BulletCol;
			//reg BulletExists;
			
			wire Reached_Bottom;
			
			wire Bullet_Fired;
			wire Aliens_Defeated;
			wire Bullet_Onscreen;
			wire Bullet_Shot;
			wire Collision;
			
			wire R, G, B;
			

	// ===========================================================================
	// 										Implementation
	// ===========================================================================
	
			//-----------------------------------------------
			//  	  			Draw_VGA Interface
			//-----------------------------------------------

			Draw_VGA Draw_VGA_1(
				 .Aliens_Grid(Aliens_Grid),
				 .AliensRow(AliensRow),
				 .AliensCol(AliensCol),
				 .PlayerRow(PlayerRow),
				 .PlayerCol(PlayerCol),
				 .Clk(clk),
				 .Reset(reset),
				 .BulletRow(BulletRow),
				 .BulletCol(BulletCol),
				 .BulletExists(Bullet_Onscreen),
				 .CounterX(CounterX),
				 .CounterY(CounterY),
				 .inDisplayArea(inDisplayArea),
				 .R(R),
				 .G(G),
				 .B(B),
				 .Reached_Bottom(Reached_Bottom),
				 .Aliens_Defeated(Aliens_Defeated)
			);
			
			always @(posedge clk)
			begin
				vga_r <= R & inDisplayArea;
				vga_g <= G & inDisplayArea;
				vga_b <= B & inDisplayArea;
			end
			
			//-----------------------------------------------
			//  	  			Aliens Interface
			//-----------------------------------------------
			
			Aliens Aliens_1(
				 .Clk(game_clk),
				 .Reset(reset),
				 .AliensRow(AliensRow),
				 .AliensCol(AliensCol),
				 .Reached_Bottom(Reached_Bottom),
				 .Aliens_Grid(Aliens_Grid),
				 .Aliens_Defeated(Aliens_Defeated)
			);
			
			//-----------------------------------------------
			//  	  			Player Interface
			//-----------------------------------------------
			
			Player Player_1(
				 .Clk(game_clk),
				 .Reset(reset),
				 .Joystick_data(joystick_data),
				 .Player_Row(PlayerRow),
				 .Player_Col(PlayerCol)
			);
			
			//-----------------------------------------------
			//  	  			Bullet Interface
			//-----------------------------------------------

			Bullet Bullet_1(
				 .Clk(game_clk),
				 .Reset(reset),
				 .Bullet_Fired(Bullet_Fired),
				 .Aliens_Row(AliensRow),
				 .Aliens_Col(AliensCol),
				 .Player_Row(PlayerRow),
				 .Player_Col(PlayerCol),
				 .Bullet_Row(BulletRow),
				 .Bullet_Col(BulletCol),
				 .Aliens_Defeated(Aliens_Defeated),
				 .Bullet_Onscreen(Bullet_Onscreen),
				 .Aliens_Grid(Aliens_Grid),
				 .Bullet_Shot(Bullet_Shot),
				 .Collision(Collision)
			);
			
			assign Bullet_Fired = jstkData[1];
			
			//-----------------------------------------------
			//  	  			Sound Interface
			//-----------------------------------------------
			
			audio audio_1(
				.clk(board_clk),
				.rst(reset),
				.shot(Bullet_Shot),
				.collision(Collision),
				.pin(JB1)
			);
	
endmodule
