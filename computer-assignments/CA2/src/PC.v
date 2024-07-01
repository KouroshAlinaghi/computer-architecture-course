module ProgramCounter(
    clk, rst, data_in,
    data_out
);
    input clk, rst;
    input [31:0] data_in;
    output [31:0] data_out;
    reg [31:0] data_out = 32'b0;

    always @(posedge clk) begin
        data_out <= data_in;
    end
    
endmodule