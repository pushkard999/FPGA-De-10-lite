module mult_output(
	 mult_result,
	 clk,
	 out_7seg

);
  
  //this code will display outputon 4 7segment display when mult_result gets 16 bit binary input

	input clk;
	
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
