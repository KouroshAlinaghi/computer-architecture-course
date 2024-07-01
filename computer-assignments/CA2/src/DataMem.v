module DataMemory(
    clk, rst, address, wd, we,
    read_data
);
    input clk, rst, we;
    input [31:0] address;
    input [31:0] wd;

    output [31:0] read_data;

    reg [7:0] data [0:1023];

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            data[i] = 8'b0;
    end

    assign read_data = { data[address], data[address + 1], data[address + 2], data[address + 3] };

    always @(posedge clk) begin
        if (we) begin
            data[address] <= wd[31:24];
            data[address + 1] <= wd[23:16];
            data[address + 2] <= wd[15:8];
            data[address + 3] <= wd[7:0];
        end
    end
    
endmodule