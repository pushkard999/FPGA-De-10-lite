// Code your design here
`timescale 1ns/1ps
module push(clk, in, rst, binary, temp);
  input clk;
  input rst;
  input [15:0] in;
  output reg [15:0] binary;
  input [15:0] temp;
  //reg num;
  
  always @(posedge clk)
    begin
      
      if(rst)
        begin
         	binary = (in + temp);
        end
        
      else
        begin
            binary = (binary << 4);
	    binary = (binary + temp);
       end
    end
      
 endmodule
      
   

//test bench
`timescale 1ns/1ps

module tb_push(); 
  reg clk, rst;
  reg [15:0] temp;
  reg [15:0] in;
  wire [15:0] binary;

  push pu(clk, in, rst, binary, temp);
  
  always #2 clk = ~clk;
  
  initial begin
  clk = 1;
  rst = 1;
  in = 16'b0000000000000000;
  temp = 16'b0000000000000001;
  #2
  #2 rst = 0; temp = 16'b0000000000000010; 
  #2
  #2 temp = 16'b0000000000000100; 
  #2
  #2 temp = 16'b0000000000001000;
  #2 rst = 1;
    
  $finish;
  end
  
  initial begin
      $monitor("clk = %d, rst = %d, binary = %b, temp = %b", clk, rst, binary, temp);
  end
  
endmodule
   
   
  
  
