`timescale 1ns / 1ps
`define biased_exponent 15


module Display_Mult(
			clock, 
			out_7seg,
			 sw1,
			 sw2,
			 sw3,
			 sw4
			 );
				
				
	
	input sw1;
	input sw2;
	input sw3;
	input sw4;
	//input sw5;
	
	inout [31:0] out_7seg;
    
    input clock;
	 reg [15:0] num_1,num_2;
	 
	

    reg [15:0] F;
	 
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
	 
	initial begin
	
		num_1 = 16'b0100010010000000;
		num_2 = 16'b1011100000000000;
		//num_1 = 16'b1100010000011010;	//-4.1
		//num_2 = 16'b0100010110000000;	//5.5	 result 0xCDA4  0b1100110110100100
		//num_1 = 16'b0100010000011010; //4.1
		//num_2 = 16'b0100010110000000;	//5.5	//result 0x4DA4  0b0100110110100100
		 //num_1 = 16'b0100_0001_0000_0000;
		 //num_2 = 16'b1011_1100_1100_1101;
		 //num_1 = 16'b0100_0100_1000_0000;	//
		 //num_2 = 16'b1011_0100_1100_1101; //answer = 1011_1101_0110_0111	//b d 6 7
		 S1 = num_1 [15];
		 S2 = num_2 [15];
		  
	    E1 = num_1 [14:10];
	    E2 = num_2 [14:10];
	    F1 = num_1 [9:0];
	    F2 = num_2 [9:0];
	end


    always @(posedge clock) begin	
        
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
        F <= {S,temp_Exponent_Sum_Final,final_fraction};
		  
		  //out_7seg <= F;
       
    end
	 
	 
	     mult_output mult_out(.mult_result(F), .clk(clock), 
		  .sw1(sw1), .sw2(sw2), .sw3(sw3), .sw4(sw4), .out_7seg(out_7seg));

endmodule 

module mult_output(
	mult_result,
	 clk,
	 sw1,
	 sw2,
	 sw3,
	 sw4,
	 out_7seg

);

	input clk;
	input sw1;	//press to display 1st no.
	input sw2;	//press to display 2st no.
	input sw3;	//press to display 3st no.
	input sw4;	//press to display 4st no.
	
	inout reg [31:0] out_7seg;	//for dsiplaying output on 4 7segment dsiplay
	
	//16bit in\put value i.e. result of mutiplication
	input [15:0] mult_result;	//16bit in\put value i.e. result of mutiplication
	
		
	reg [3:0] temp_result1;	//takes 4 bit at a time for case statments
	reg [3:0] temp_result2;
	reg [3:0] temp_result3;
	reg [3:0] temp_result4;

	reg [7:0] out_7seg1;		//takes 8 bits at a time for 7-segment
	reg [7:0] out_7seg2;
	reg [7:0] out_7seg3;
	reg [7:0] out_7seg4;
	

integer i=0;
reg [3:0] temp_result;

always @ (posedge clk)
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
				4'b1110: out_7seg1 <= ~(8'b10011110);	//14 e
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
				4'b1110: out_7seg2 <= ~(8'b10011110);	//14 e
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
				4'b1110: out_7seg3 <= ~(8'b10011110);	//14 e
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
				4'b1110: out_7seg4 <= ~(8'b10011110);	//14 e
				4'b1111: out_7seg4 <= ~(8'b01110001);	//15 f
			
			
				default: out_7seg4 <= ~(8'b1111_1111);
			
		endcase
		

		
		out_7seg <= {out_7seg4, out_7seg3, out_7seg2, out_7seg1};	//display 4th,3rd,2nd,1st no.
			
		
		
		end	
	
endmodule 
