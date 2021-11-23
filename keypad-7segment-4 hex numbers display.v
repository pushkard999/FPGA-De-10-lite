`timescale 1ns / 1ps

module keypad_if_else(
	 sw1_num1,		//main switch for 1st 4 no.s
	 sw2_num2,		//main switch for 2st 4 no.s
	 sw1,				//switch for 1st no.
	 sw2,				//switch for 2nd no.
	 sw3,				//switch for 3rd no.
	 sw4,				//switch for 4th no.
    clk,
    Row,
    Col,
    DecodeOut,
	 out_7seg
    );

   input clk;						// 100MHz onboard clock
   input [3:0] Row;				// Rows on KYPD
   output reg [3:0] Col;			// Columns on KYPD
   output reg [3:0] DecodeOut;	// Output data
	reg [7:0]out_7seg1;
	output reg [31:0] out_7seg;

	reg [19:0] sclk;				// Count register
	
	input sw1;
	input sw2;
	input sw3;
	input sw4;
	input sw1_num1;
	input sw2_num2;
	
	reg [7:0] temp1;
	reg [7:0] temp2;
	reg [7:0] temp3;
	reg [7:0] temp4;
	reg [15:0] num1;	// register for storing 1st, 4 hex no.s
	reg [15:0] num2;	// register for storing 2nd, 4 hex no.s
	reg [3:0] temp1_DecodeOut;	//register for temporary storage of 1st, 4 bit binary no.
	reg [3:0] temp2_DecodeOut;	//register for temporary storage of 2nd, 4 bit binary no.
	reg [3:0] temp3_DecodeOut;	//register for temporary storage of 3rd, 4 bit binary no.
	reg [3:0] temp4_DecodeOut;	//register for temporary storage of 4th, 4 bit binary no.
	

	always @(posedge clk) 
	begin

			
		if (sclk == 20'b00011000011010100000) 	// 1ms
			begin	
				Col <= 4'b0111;				//C1
				sclk <= sclk + 1'b1;
			end
			
			
		else if(sclk == 20'b00011000011010101000) 	// check row pins
			begin
				if (Row == 4'b0111) 				//R1
				begin
					DecodeOut <= 4'b0001;		//1
					out_7seg1 <= ~(8'b00000110);
				end
				
				else if(Row == 4'b1011) 		//R2
					begin
						DecodeOut <= 4'b0100; 	//4
						out_7seg1 <= ~(8'b01100110);
					end
				
				else if(Row == 4'b1101) 		//R3
					begin
						DecodeOut <= 4'b0111; 	//7
						out_7seg1 <= ~(8'b00000111);		
					end
				
				else if(Row == 4'b1110)			//R4
					begin
						DecodeOut <= 4'b1111; 	//f    		 
						out_7seg1 <= ~(8'b01110001);	
					end
					
				sclk <= sclk + 1'b1;
			end

		
		else if(sclk == 20'b00110000110101000000) 	// 2ms
		begin
			Col<= 4'b1011;		//C2
			sclk <= sclk + 1'b1;
		end
			
			
			else if(sclk == 20'b00110000110101001000) 		// check row pins
			begin
				
				if (Row == 4'b0111) 				//R1
				begin
					DecodeOut <= 4'b0010; 		//2
					out_7seg1 <= ~(8'b1011011);
				end
				
				else if(Row == 4'b1011) 		//R2
				begin
					DecodeOut <= 4'b0101; 		//5
					out_7seg1 <= ~(8'b01101101);
				end
				
				else if(Row == 4'b1101) 		//R3
				begin
					DecodeOut <= 4'b1000; 		//8
					out_7seg1 <= ~(8'b01111111);
				end
				
				else if(Row == 4'b1110) 		//R4
				begin
					DecodeOut <= 4'b0000; 		//0	
					out_7seg1 <= ~(8'b00111111);
				end
				sclk <= sclk + 1'b1;
			end

			
		else if(sclk == 20'b01001001001111100000) 	//3ms
		begin
			Col<= 4'b1101;						//C3
			sclk <= sclk + 1'b1;
		end
			
			else if(sclk == 20'b01001001001111101000) 	// check row pins
			begin
				if(Row == 4'b0111) 				//R1
				begin
					DecodeOut <= 4'b0011; 		//3	
					out_7seg1 <= ~(8'b01001111);
				end
				
				else if(Row == 4'b1011) 		//R2
				begin
					DecodeOut <= 4'b0110; 		//6
					out_7seg1 <= ~(8'b01111101);
				end
				
				else if(Row == 4'b1101) 		//R3
				begin
					DecodeOut <= 4'b1001; 		//9
					out_7seg1 <= ~(8'b01101111);
				end
				
				else if(Row == 4'b1110)			//R4
				begin
					DecodeOut <= 4'b1110; 		//E
					out_7seg1 <= ~(8'b00000000);
				end

				sclk <= sclk + 1'b1;
			end

			
		else if(sclk == 20'b01100001101010000000) 	//4ms
		begin
			Col<= 4'b1110;						//C4
			sclk <= sclk + 1'b1;
		end

			
			else if(sclk == 20'b01100001101010001000) 	// Check row pins
			begin
				
				if(Row == 4'b0111) 				//R1
				begin
					DecodeOut <= 4'b1010; 		//A
					out_7seg1 <= ~(8'b01110111);
				end
				
				else if(Row == 4'b1011) 		//R2
				begin
					DecodeOut <= 4'b1011; 		//B
					out_7seg1 <= ~(8'b01111111);
				end
				
				else if(Row == 4'b1101) 		//R3
				begin
					DecodeOut <= 4'b1100; 		//C
					out_7seg1 <= ~(8'b00111001);
				end
				
				else if(Row == 4'b1110)			//R4
				begin
					DecodeOut <= 4'b1101; 		//D
					out_7seg1 <= ~(8'b00111111);
				end
				sclk <= 20'b00000000000000000000;
			end
			
			else if(sw1_num1 == 1'b1)		//press switch sw8 on board
			begin
			   if(sw1 == 1'b1)				//press switch sw0 on board
					begin
						temp1 <= out_7seg1;
						out_7seg <= {8'b11111111, 8'b11111111, 8'b11111111, temp1};
						temp1_DecodeOut <= DecodeOut;	
					end
					
				else if(sw2 == 1'b1)			//press switch sw1 on board
					begin
						temp2 <= out_7seg1;
						out_7seg <= {8'b11111111, 8'b11111111, temp2, temp1};
						temp2_DecodeOut <= DecodeOut;
					end
					
				else if(sw3 == 1'b1)		//press switch sw2 on board
					begin
						temp3 <= out_7seg1;
						out_7seg <= {8'b11111111, temp3, temp2, temp1};
						temp3_DecodeOut <= DecodeOut;
					end
					
				else if(sw4 == 1'b1)		//press switch sw3 on board
					begin
						temp4 <= out_7seg1;
						out_7seg <= {temp4, temp3, temp2, temp1};
						temp4_DecodeOut <= DecodeOut;
						num1 <= {temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};		//storing 4 bit binary
						//out_7seg <= ~{temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};
					end
					
				end
				
			else if(sw2_num2 == 1'b1)	//press switch sw9 on board
			begin
			
			   if(sw1 == 1'b1)
					begin
						temp1 <= out_7seg1;
						out_7seg <= {8'b11111111, 8'b11111111, 8'b11111111, temp1};
						temp1_DecodeOut <= DecodeOut;
					end
					
				else if(sw2 == 1'b1)
					begin
						temp2 <= out_7seg1;
						out_7seg <= {8'b11111111, 8'b11111111, temp2, temp1};
						temp2_DecodeOut <= DecodeOut;
					end
					
				else if(sw3 == 1'b1)
					begin
						temp3 <= out_7seg1;
						out_7seg <= {8'b11111111, temp3, temp2, temp1};
						temp3_DecodeOut <= DecodeOut;
					end
					
				else if(sw4 == 1'b1)
					begin
						temp4 <= out_7seg1;
						out_7seg <= {temp4, temp3, temp2, temp1};
						temp4_DecodeOut <= DecodeOut;
						
						num2 <= {temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};
						
						//out_7seg <= ~{temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};
					end
					
				end
				
			else begin		// Otherwise increment
				sclk <= sclk + 1'b1;
			end			
	end
endmodule 
