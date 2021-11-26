`timescale 1ns / 1ps


module mult_output(
	 clk,
	 sw1,
	 sw2,
	 sw3,
	 sw4,
	 out_7seg

);

	input clk;
	input sw1;
	input sw2;
	input sw3;
	input sw4;
	output reg [31:0] out_7seg;
	
	//input [15:0] in_mult_result;
	//input [15:0] mult_result;	//16bit in\put value i.e. result of mutiplication
	reg [15:0] mult_result;	//16bit in\put value i.e. result of mutiplication
	
	reg [3:0] temp_result;
	reg [7:0] out_7seg1;
	
	reg [7:0] temp1;		//temporary variables
	reg [7:0] temp2;
	reg [7:0] temp3;
	reg [7:0] temp4;

	initial begin
		//mult_result = in_mult_result;
		mult_result = 16'b1111_0011_1010_0001;	//2 3 4 1 binary equi.
		//temp_result = mult_result [3:0];
		
	end

always @ (posedge clk)
	 begin 
	
		case (temp_result)
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
				4'b1010: out_7seg1 <= ~(8'b01110111);	//10
				4'b1011: out_7seg1 <= ~(8'b01111100);	//11
				4'b1100: out_7seg1 <= ~(8'b00111001);	//12
				4'b1101: out_7seg1 <= ~(8'b01011110);	//13
				4'b1110: out_7seg1 <= ~(8'b10011110);	//14
				4'b1111: out_7seg1 <= ~(8'b01110001);	//15
			
			
				default: out_7seg1 <= ~(8'b1111_1111);
			
		endcase
		
			
			 if(sw1 == 1'b1) 				//press switch sw1 on board
				begin
				temp_result <= mult_result [3:0];
				temp1 <= out_7seg1;
				out_7seg <= {8'b11111111, 8'b11111111, 8'b11111111, temp1};
				
				end
			
			else if(sw2 == 1'b1)			//press switch sw2 on board
				begin
						temp_result <= mult_result [7:4];
						temp2 <= out_7seg1;
						out_7seg <= {8'b11111111, 8'b11111111, temp2, temp1};
				end
						
			else if(sw3 == 1'b1)		//press switch sw3 on board
				begin
						temp_result <= mult_result [11:8];
						temp3 <= out_7seg1;
						out_7seg <= {8'b11111111, temp3, temp2, temp1};
				end
						
			else if(sw4 == 1'b1)		//press switch sw4 on board
				begin
						temp4 <= out_7seg1;
						temp_result <= mult_result [15:12];
						out_7seg <= {temp4, temp3, temp2, temp1};
				end		
			
			else
				begin
					out_7seg <= {8'b11111111, 8'b11111111, 8'b11111111, 8'b11111111};
				end		
		
		end	
	
endmodule 
