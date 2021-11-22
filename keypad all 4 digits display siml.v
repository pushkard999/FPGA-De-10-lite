`timescale 1ns / 1ps

module keypad_if_else(
	 sw1,
	 sw2,
	 sw3,
	 sw4,
    clk,
    Row,
    Col,
    DecodeOut,
	 out_7seg1,
	 out_7seg2,
	 out_7seg3,
	 out_7seg4
    );

    input clk;						// 100MHz onboard clock
    input [3:0] Row;				// Rows on KYPD
    output [3:0] Col;			// Columns on KYPD
    output [3:0] DecodeOut;	// Output data
	 output reg [7:0]out_7seg1;
	 output reg [7:0]out_7seg2;
	 output reg [7:0]out_7seg3;
	 output reg [7:0]out_7seg4;

	reg [3:0] Col;						// Output wires and registers
	reg [3:0] DecodeOut;
	
	reg [19:0] sclk;				// Count register
	
	//reg [15:0] add1;
	//reg [3:0] add2;
	input sw1;
	input sw2;
	input sw3;
	input sw4;
	
	initial 
		begin
			//add1 = 0;
			//add2 = 0;
			out_7seg1 = 8'b11111111;
			out_7seg2 = 8'b11111111;
			out_7seg3 = 8'b11111111;
			out_7seg4 = 8'b11111111;
			
			//sw1 = 0;
//			sw2 = 1'b0;
//			sw3 = 1'b0;
//			sw4 = 1'b0;
	
		end

	always @(posedge clk) begin
		
//if(sw1 == 1'b1)begin
			// 1ms
			if (sclk == 20'b00011000011010100000) 
				begin
					//C1
					Col <= 4'b0111;
					sclk <= sclk + 1'b1;
					
				end
			
			// check row pins
		else if(sclk == 20'b00011000011010101000) 
			begin
				//R1
				if (Row == 4'b0111) 
				begin
					DecodeOut <= 4'b0001;		//1
					out_7seg1 <= ~(8'b00000110);
	
				end
				//R2
				else if(Row == 4'b1011) 
					begin
						DecodeOut <= 4'b0100; 		//4
						
						out_7seg1 <= ~(8'b01100110);
				
					end
				//R3
				else if(Row == 4'b1101) 
					begin
						DecodeOut <= 4'b0111; 		//7
						out_7seg1 <= ~(8'b00000111);
									
					end
				//R4
				else if(Row == 4'b1110)
					begin
						DecodeOut <= 4'b0000; 		//f    		old-//0 
						out_7seg1 <= ~(8'b01110001);
						
					end
					
				sclk <= sclk + 1'b1;

				
			end

		// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 		//2
					out_7seg1 <= ~(8'b1011011);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg1 <= ~(8'b01101101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg1 <= ~(8'b01111111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//0	//old-//F
					out_7seg1 <= ~(8'b00111111);
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011; 		//3	
					out_7seg1 <= ~(8'b01001111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg1 <= ~(8'b01111101);
				end
				//R3
				else if(Row == 4'b11`01) begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg1 <= ~(8'b01101111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg1 <= ~(8'b00000000);
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010; //A
					out_7seg1 <= ~(8'b01110111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					out_7seg1 <= ~(8'b01111111);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					out_7seg1 <= ~(8'b00111001);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					out_7seg1 <= ~(8'b00111111);
				end
				sclk <= 20'b00000000000000000000;
			end
			
			
			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
			
	end			

			
			
	if(sw2 == 1'b1)begin
			
			
			// 1ms
			if (sclk == 20'b00011000011010100000) 
				begin
					//C1
					Col <= 4'b0111;
					sclk <= sclk + 1'b1;
					
				end
			
			// check row pins
			else if(sclk == 20'b00011000011010101000) 
			begin
				//R1
				if (Row == 4'b0111) 
				begin
					DecodeOut <= 4'b0001;		//1
					out_7seg2 <= ~(8'b00000110);
	
				end
				//R2
				else if(Row == 4'b1011) 
					begin
						DecodeOut <= 4'b0100; 		//4
						
						out_7seg2 <= ~(8'b01100110);
				
					end
				//R3
				else if(Row == 4'b1101) 
					begin
						DecodeOut <= 4'b0111; 		//7
						out_7seg2 <= ~(8'b00000111);
									
					end
				//R4
				else if(Row == 4'b1110)
					begin
						DecodeOut <= 4'b0000; 		//f    		old-//0 
						out_7seg2 <= ~(8'b01110001);
						
					end
					
				sclk <= sclk + 1'b1;

				
			end

		// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 		//2
					out_7seg2 <= ~(8'b1011011);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg2 <= ~(8'b01101101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg2 <= ~(8'b01111111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//0	//old-//F
					out_7seg2 <= ~(8'b00111111);
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011; 		//3	
					out_7seg2 <= ~(8'b01001111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg2 <= ~(8'b01111101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg2 <= ~(8'b01101111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg2 <= ~(8'b00000000);
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010; //A
					out_7seg2 <= ~(8'b01110111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					out_7seg2 <= ~(8'b01111111);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					out_7seg2 = ~(8'b00111001);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					out_7seg2 <= ~(8'b00111111);
				end
				sclk <= 20'b00000000000000000000;
			end
			
			
			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
			
		end
			
			
			
	if(sw3 == 1'b1)begin
			
		
			// 1ms
			if (sclk == 20'b00011000011010100000) 
				begin
					//C1
					Col <= 4'b0111;
					sclk <= sclk + 1'b1;
					
				end
			
			// check row pins
			else if(sclk == 20'b00011000011010101000) 
			begin
				//R1
				if (Row == 4'b0111) 
				begin
					DecodeOut <= 4'b0001;		//1
					out_7seg3 <= ~(8'b00000110);
	
				end
				//R2
				else if(Row == 4'b1011) 
					begin
						DecodeOut <= 4'b0100; 		//4
						
						out_7seg3 <= ~(8'b01100110);
				
					end
				//R3
				else if(Row == 4'b1101) 
					begin
						DecodeOut <= 4'b0111; 		//7
						out_7seg3 <= ~(8'b00000111);
									
					end
				//R4
				else if(Row == 4'b1110)
					begin
						DecodeOut <= 4'b0000; 		//f    		old-//0 
						out_7seg3 <= ~(8'b01110001);
						
					end
					
				sclk <= sclk + 1'b1;

				
			end

		// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 		//2
					out_7seg3 <= ~(8'b1011011);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg3 <= ~(8'b01101101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg3 <= ~(8'b01111111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//0	//old-//F
					out_7seg3 <= ~(8'b00111111);
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011; 		//3	
					out_7seg3 <= ~(8'b01001111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg3 <= ~(8'b01111101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg3 <= ~(8'b01101111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg3 <= ~(8'b00000000);
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010; //A
					out_7seg3 <= ~(8'b01110111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					out_7seg3 <= ~(8'b01111111);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					out_7seg3 <= ~(8'b00111001);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					out_7seg3 <= ~(8'b00111111);
				end
				sclk <= 20'b00000000000000000000;
			end
			
			
			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
	end
			
			
			
			
			
			
			
		if(sw4 == 1'b1)begin
			
			// 1ms
			if (sclk == 20'b00011000011010100000) 
				begin
					//C1
					Col <= 4'b0111;
					sclk <= sclk + 1'b1;
					
				end
			
			// check row pins
			else if(sclk == 20'b00011000011010101000) 
			begin
				//R1
				if (Row == 4'b0111) 
				begin
					DecodeOut <= 4'b0001;		//1
					out_7seg4 <= ~(8'b00000110);
	
				end
				//R2
				else if(Row == 4'b1011) 
					begin
						DecodeOut <= 4'b0100; 		//4
						
						out_7seg4 <= ~(8'b01100110);
				
					end
				//R3
				else if(Row == 4'b1101) 
					begin
						DecodeOut <= 4'b0111; 		//7
						out_7seg4 <= ~(8'b00000111);
									
					end
				//R4
				else if(Row == 4'b1110)
					begin
						DecodeOut <= 4'b0000; 		//f    		old-//0 
						out_7seg4 <= ~(8'b01110001);
						
					end
					
				sclk <= sclk + 1'b1;

				
			end

		// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 		//2
					out_7seg4 <= ~(8'b1011011);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg4 <= ~(8'b01101101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg4 <= ~(8'b01111111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//0	//old-//F
					out_7seg4 <= ~(8'b00111111);
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011; 		//3	
					out_7seg4 <= ~(8'b01001111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg4 <= ~(8'b01111101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg4 <= ~(8'b01101111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg4 <= ~(8'b00000000);
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010; //A
					out_7seg4 <= ~(8'b01110111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					out_7seg4 <= ~(8'b01111111);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					out_7seg4 <= ~(8'b00111001);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					out_7seg4 <= ~(8'b00111111);
				end
				sclk <= 20'b00000000000000000000;
			end
			
			
			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
			
		end
			
			
			
	end

endmodule 
