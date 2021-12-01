
`timescale 1ns / 1ps
`define biased_exponent 15

//working code for displaying multplication output, perform multi, take & display input from keypad

module integrate(
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
	 out_7seg,
	 sw_temp1,
	 sw_temp2,
	 sw_temp3
    );
	 
	//always2 declaration
	input sw_temp1;
	input sw_temp2;
	input sw_temp3;
	
	 reg S1;
	 reg S2;
	 
	 
	 reg [4:0] E1;
	 reg [4:0] E2;
	 reg [9:0] F1;
	 reg [9:0] F2;
    reg [25:0]temp_fraction; //Fraction
    reg[2:0] rounding_action;
    reg [9:0]final_fraction;// Fraction

    reg [4:0]temp_exponent_sum,temp_Exponent_Sum_Final;//Exponent

    reg signed [4:0] exponent_count; //Exponent

    reg [10:0]temp_F1, temp_F2;
    reg S; //Signed bit
	 
	  reg [15:0] mult_result;	//16bit in\put value i.e. result of mutiplication
	 
	 //end always2
	 
	 
	 //always3 decl
	 reg [3:0] temp_result1;	//takes 4 bit at a time for case statments
	reg [3:0] temp_result2;
	reg [3:0] temp_result3;
	reg [3:0] temp_result4;

	//reg [7:0] out_7seg1;		//takes 8 bits at a time for 7-segment
	reg [7:0] out_7seg2;
	reg [7:0] out_7seg3;
	reg [7:0] out_7seg4;
	 
	 
	 //end always3
	
	
	
	
	
	
	
	

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
	reg [15:0] num_1;	// register for storing 1st, 4 hex no.s
	reg [15:0] num_2;	// register for storing 2nd, 4 hex no.s
	reg [3:0] temp1_DecodeOut;	//register for temporary storage of 1st, 4 bit binary no.
	reg [3:0] temp2_DecodeOut;	//register for temporary storage of 2nd, 4 bit binary no.
	reg [3:0] temp3_DecodeOut;	//register for temporary storage of 3rd, 4 bit binary no.
	reg [3:0] temp4_DecodeOut;	//register for temporary storage of 4th, 4 bit binary no.
	

	always @(posedge clk) 
	begin

	if(sw_temp1 == 1'b1)begin
	
	
		//num_1 <= 16'b0100010010000000;
		//num_2 <= 16'b1011100000000000;
			
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
					out_7seg1 <= ~(8'b01111001);
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
					out_7seg1 <= ~(8'b01111100);
				end
				
				else if(Row == 4'b1101) 		//R3
				begin
					DecodeOut <= 4'b1100; 		//C
					out_7seg1 <= ~(8'b00111001);
				end
				
				else if(Row == 4'b1110)			//R4
				begin
					DecodeOut <= 4'b1101; 		//D
					out_7seg1 <= ~(8'b01011110);
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
						num_1 <= {temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};		//storing 4 bit binary
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
						
						num_2 <= {temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};
						
						//out_7seg <= ~{temp4_DecodeOut, temp3_DecodeOut, temp2_DecodeOut, temp1_DecodeOut};
					end
					
				end
				
			else begin		// Otherwise increment
				sclk <= sclk + 1'b1;
			end	
	
	end
	
	
	
	
	
	
	
	else if(sw_temp2 == 1'b1)
	begin
	
	
	
			 S1 <= num_1 [15];
			 S2 <= num_2 [15];
			  
			 E1 <= num_1 [14:10];
			 E2 <= num_2 [14:10];
			 F1 <= num_1 [9:0];
			 F2 <= num_2 [9:0];

		 
		 
		 
		 
		 
        //=======================Fractional part operation
        
        temp_F1 <= {1'b1, F1}; //1_Fraction1
        temp_F2 <= {1'b1, F2}; //1_Fraction2
        temp_fraction <= temp_F1 * temp_F2;

        
        if (temp_fraction[22]==1) begin
            rounding_action <= temp_fraction[11:9];

            case (rounding_action)
                0,1,2,3: final_fraction <= temp_fraction[21:12];

                5,6,7: final_fraction <= temp_fraction[21:12] + 1'b1;
                
                4: final_fraction <= {temp_fraction[21:13], 1'b0}; 
                
                default: final_fraction <= temp_fraction[21:12];

            endcase
            exponent_count <= 2; 
        end

        else if (temp_fraction[21]==1) begin

            rounding_action <= temp_fraction[10:8];

            case (rounding_action)
                0,1,2,3: final_fraction <= temp_fraction[20:11];

                5,6,7: final_fraction <= temp_fraction[20:11] + 1'b1;
                
                4: final_fraction <= {temp_fraction[20:12], 1'b0}; 
                
                default: final_fraction <= temp_fraction[20:11];

            endcase
            exponent_count <= 1;
        end

        else if (temp_fraction[20]==1) begin
            
            rounding_action <= temp_fraction[9:7];

            case (rounding_action)
                0,1,2,3 : final_fraction <= temp_fraction[19:10];
                
                5,6,7: final_fraction <= temp_fraction[19:10] + 1'b1;
                
                4: final_fraction <= {temp_fraction[19:11], 1'b0};
                
                default: final_fraction <= temp_fraction[19:10];

            endcase
            exponent_count <= 0;

        end


        else if (temp_fraction[19]==1) begin
            final_fraction <= temp_fraction[18:9];

            rounding_action <= temp_fraction[8:6];

            case (rounding_action)
                0,1,2,3 : final_fraction <= temp_fraction[18:9];
                
                5,6,7: final_fraction <= temp_fraction[18:9] + 1'b1;
                
                4: final_fraction <= {temp_fraction[19:10], 1'b0};
                
                default: final_fraction <= temp_fraction[18:9];

            endcase
            
            exponent_count <= -1;
        end

        else 
            final_fraction <= temp_fraction; 
        
//------------------------------------------------------------------------------------//

        //=================Exponent operation

        temp_exponent_sum <= (E1 + E2) - `biased_exponent; //True Exponent
        temp_Exponent_Sum_Final <= temp_exponent_sum + exponent_count; //Final Exponent value
        S = S1 ^ S2; //To find the Sign Bit


        // Output of Multiplication
        mult_result <= {S,temp_Exponent_Sum_Final,final_fraction};
		  
		  //out_7seg <= F;
       
    end
		 
		 
	
	
	
	
	
	
								else if(sw_temp3 == 1'b1)
								begin
								
								
								
									 temp_result1 <= mult_result [3:0];
									 temp_result2 <= mult_result [7:4];
									 temp_result3 <= mult_result [11:8];
									 temp_result4 <= mult_result [15:12];
								
								
									case (temp_result1)
											4'b0000: out_7seg1 <= ~(8'b00111111);	//0
											4'b0001:	out_7seg1 <= ~(8'b00000110);	//1
											4'b0010: out_7seg1 <= ~(8'b01011011);  //2
											4'b0011: out_7seg1 <= ~(8'b01001111);	//3
											4'b0100: out_7seg1 <= ~(8'b01100110);	//4
											4'b0101: out_7seg1 <= ~(8'b01101101);	//5
											4'b0110: out_7seg1 <= ~(8'b01111101);	//6
											4'b0111: out_7seg1 <= ~(8'b00000111);	//7
											4'b1000: out_7seg1 <= ~(8'b01111111);	//8
											4'b1001: out_7seg1 <= ~(8'b01101111);	//9
											4'b1010: out_7seg1 <= ~(8'b01110111);	//10 a
											4'b1011: out_7seg1 <= ~(8'b01111100);	//11 b
											4'b1100: out_7seg1 <= ~(8'b00111001);	//12 c
											4'b1101: out_7seg1 <= ~(8'b01011110);	//13 d
											4'b1110: out_7seg1 <= ~(8'b01111001);	//14 e 1001_1110 correct-01111001
											4'b1111: out_7seg1 <= ~(8'b01110001);	//15 f
										
											default: out_7seg1 <= ~(8'b1111_1111);
										
									endcase
									
											case (temp_result2)
											4'b0000: out_7seg2 <= ~(8'b00111111);	//0
											4'b0001:	out_7seg2 <= ~(8'b00000110);	//1
											4'b0010: out_7seg2 <= ~(8'b01011011);  //2
											4'b0011: out_7seg2 <= ~(8'b01001111);	//3
											4'b0100: out_7seg2 <= ~(8'b01100110);	//4
											4'b0101: out_7seg2 <= ~(8'b01101101);	//5
											4'b0110: out_7seg2 <= ~(8'b01111101);	//6
											4'b0111: out_7seg2 <= ~(8'b00000111);	//7
											4'b1000: out_7seg2 <= ~(8'b01111111);	//8
											4'b1001: out_7seg2 <= ~(8'b01101111);	//9
											4'b1010: out_7seg2 <= ~(8'b01110111);	//10 a
											4'b1011: out_7seg2 <= ~(8'b01111100);	//11 b
											4'b1100: out_7seg2 <= ~(8'b00111001);	//12 c
											4'b1101: out_7seg2 <= ~(8'b01011110);	//13 d
											4'b1110: out_7seg2 <= ~(8'b01111001);	//14 e
											4'b1111: out_7seg2 <= ~(8'b01110001);	//15 f
									
											default: out_7seg2 <= ~(8'b1111_1111);
										
									endcase
									
											case (temp_result3)
											4'b0000: out_7seg3 <= ~(8'b00111111);	//0
											4'b0001:	out_7seg3 <= ~(8'b00000110);	//1
											4'b0010: out_7seg3 <= ~(8'b01011011);  //2
											4'b0011: out_7seg3 <= ~(8'b01001111);	//3
											4'b0100: out_7seg3 <= ~(8'b01100110);	//4
											4'b0101: out_7seg3 <= ~(8'b01101101);	//5
											4'b0110: out_7seg3 <= ~(8'b01111101);	//6
											4'b0111: out_7seg3 <= ~(8'b00000111);	//7
											4'b1000: out_7seg3 <= ~(8'b01111111);	//8
											4'b1001: out_7seg3 <= ~(8'b01101111);	//9
											4'b1010: out_7seg3 <= ~(8'b01110111);	//10 a
											4'b1011: out_7seg3 <= ~(8'b01111100);	//11 b
											4'b1100: out_7seg3 <= ~(8'b00111001);	//12 c
											4'b1101: out_7seg3 <= ~(8'b01011110);	//13 d
											4'b1110: out_7seg3 <= ~(8'b01111001);	//14 e
											4'b1111: out_7seg3 <= ~(8'b01110001);	//15 f
										
											default: out_7seg3 <= ~(8'b1111_1111);
										
									endcase
									
											case (temp_result4)
											4'b0000: out_7seg4 <= ~(8'b00111111);	//0
											4'b0001:	out_7seg4 <= ~(8'b00000110);	//1
											4'b0010: out_7seg4 <= ~(8'b01011011);  //2
											4'b0011: out_7seg4 <= ~(8'b01001111);	//3
											4'b0100: out_7seg4 <= ~(8'b01100110);	//4
											4'b0101: out_7seg4 <= ~(8'b01101101);	//5
											4'b0110: out_7seg4 <= ~(8'b01111101);	//6
											4'b0111: out_7seg4 <= ~(8'b00000111);	//7
											4'b1000: out_7seg4 <= ~(8'b01111111);	//8
											4'b1001: out_7seg4 <= ~(8'b01101111);	//9
											4'b1010: out_7seg4 <= ~(8'b01110111);	//10 a
											4'b1011: out_7seg4 <= ~(8'b01111100);	//11 b
											4'b1100: out_7seg4 <= ~(8'b00111001);	//12 c
											4'b1101: out_7seg4 <= ~(8'b01011110);	//13 d
											4'b1110: out_7seg4 <= ~(8'b01111001);	//14 e
											4'b1111: out_7seg4 <= ~(8'b01110001);	//15 f
										
										
											default: out_7seg4 <= ~(8'b1111_1111);
										
									endcase
									
									out_7seg <= {out_7seg4, out_7seg3, out_7seg2, out_7seg1};	//display 4th,3rd,2nd,1st no.
								
								end
	
	
	
	
	
				else
				begin
					out_7seg <= {8'b11111111, 8'b11111111, 8'b11111111, 8'b11111111};
				
				end
	 
	
	end
endmodule 
