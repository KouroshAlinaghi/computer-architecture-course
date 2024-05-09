module ShiftReg10(clk, sclr, ld, shen, serin, pin, out);
	input clk, sclr, ld, shen, serin;
	input [9:0] pin;
	output [9:0] out;
	reg [9:0] out = 10'b00_0000_0000;
	
    always @(posedge clk, posedge sclr) begin
        if (sclr)
            out <= 10'b0;
        else begin
            if (ld)
                out <= pin;
            else if (shen)
				out <= {out[8:0], serin};
        end
    end
endmodule