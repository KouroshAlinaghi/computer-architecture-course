module InstructionMemory(
    clk, rst, address,
    read_data
);
    input clk, rst;
    input [31:0] address;
    output [31:0] read_data;
    reg [31:0] read_data; 

    reg [7:0] data [0:1023];

    initial begin
        $readmemb("../ins.txt", data);
    end

    always @(address) begin
        read_data <= { data[address], data[address + 1], data[address + 2], data[address + 3] };
    end
endmodule