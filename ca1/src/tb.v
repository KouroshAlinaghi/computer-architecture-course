`timescale 1ns/1ns
module DividerTB;
	reg clk = 0;
  	reg sclr = 0;
  	reg start = 0;
  	reg [9:0] a_bus;
  	reg [9:0] b_bus;
  	wire [9:0] out_bus;
    wire dvz, ovf, busy, valid;

    Divider UUT1(start, clk, sclr, a_bus, b_bus, dvz, ovf, busy, valid, out_bus);

	initial begin
    	repeat (1000) #(50) clk = ~clk;
  	end

  	initial begin
        a_bus = 10'b00_1011_0011;
        b_bus = 10'b00_0000_1001;
        #30 start = 1;
        #60 start = 0;
        #10000;

	    $stop;
  	end
endmodule