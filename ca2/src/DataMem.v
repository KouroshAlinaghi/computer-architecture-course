module DataMemory(
    clk, rst, address, wd, we,
    read_data
);
    input clk, rst, we;
    input [31:0] address;
    input [31:0] wd;

    output [31:0] read_data;

    reg [31:0] read_data; 

    reg [7:0] data [0:1023];

    always @(posedge clk) begin
        if (we) begin
            data[address] <= wd[31:24];
            data[address + 3] <= wd[23:16];
            data[address + 2] <= wd[15:8];
            data[address + 3] <= wd[7:0];
        end else
            read_data <= { data[address], data[address + 1], data[address + 2], data[address + 3] };
    end
    
endmodule