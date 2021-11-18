`timescale 1ns / 1ps

module keypad_nandland(
    clk,
    Row,
    Col,
    DecodeOut,
	 out_7seg
    );

    input clk;						// 100MHz onboard clock
    input [3:0] Row;				// Rows on KYPD
    output [3:0] Col;			// Columns on KYPD
    output [3:0] DecodeOut;	// Output data
	 output reg [15:0]out_7seg;
	// Output wires and registers
	reg [3:0] Col;
	reg [3:0] DecodeOut;
	
	// Count register
	reg [19:0] sclk;


	always @(posedge clk) begin

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
					out_7seg = ~(16'b00000000_00000110);
					
				end
				//R2
				else if(Row == 4'b1011) 
					begin
						DecodeOut <= 4'b0100; 		//4
						out_7seg = ~(16'b00000000_01100100);
					end
				//R3
				else if(Row == 4'b1101) 
					begin
						DecodeOut <= 4'b0111; 		//7
						out_7seg = ~(16'b00000000_00000111);
					end
				//R4
				else if(Row == 4'b1110)
					begin
						DecodeOut <= 4'b0000; 		//f    		old-//0 
						out_7seg = ~(16'b01110001_00000000);
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
					out_7seg = ~(16'b00000000_01011011);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg = ~(16'b00000000_01101101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg = ~(16'b00000000_01111111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//0	//old-//F
					out_7seg = ~(16'b00000000_00111111);
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
					out_7seg = ~(16'b00000000_01001111);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg = ~(16'b00000000_01111101);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg = ~(16'b00000000_01101111);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg = ~(16'b01111001_00000000);
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
					out_7seg = ~(16'b01110111_00000000);
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					out_7seg = ~(16'b01111111_00000000);
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					out_7seg = ~(16'b00111001_00000000);
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					out_7seg = ~(16'b00111111_00000000);
				end
				sclk <= 20'b00000000000000000000;
			end

			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
	end

endmodule 
