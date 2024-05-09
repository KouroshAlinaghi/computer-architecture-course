module InstructionMemory(
    clk, rst, address,
    read_data
);
    input clk, rst;
    input [31:0] address;
    output [31:0] read_data;
    reg [31:0] read_data; 

    reg [31:0] data [0:1023];

    always @(address) begin
        read_data <= data[address];
    end
endmodule