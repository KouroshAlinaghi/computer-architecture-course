module NomralReg10(clk, sclr, ld, pin, out);
	input clk, sclr, ld;
	input [9:0] pin;
	output [9:0] out;
	reg [9:0] out = 10'b00_0000_0000;
	
    always @(posedge clk, posedge sclr) begin
        if (sclr)
            out <= 10'b0;
        else if (ld)
        	out <= pin;
    end
endmodule