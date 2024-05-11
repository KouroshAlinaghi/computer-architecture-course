module InstructionMemory(
    clk, rst, address,
    read_data
);
    input clk, rst;
    input [31:0] address;
    output [31:0] read_data;
    reg [31:0] read_data; 

    reg [7:0] data [0:1023];

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            data[i] = 8'b0;
        $readmemb("src/instructions.mem", data, 0, 131);
    end

    always @(address) begin
        read_data <= { data[address], data[address + 1], data[address + 2], data[address + 3] };
    end
endmodule