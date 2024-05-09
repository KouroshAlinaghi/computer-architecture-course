module DataMemory(
    clk, rst, address, wd, we,
    read_data
);
    input clk, rst, we;
    input [31:0] address;
    input [31:0] wd;

    output [31:0] read_data;

    reg [31:0] read_data; 

    reg [31:0] data [0:1023];

    always @(posedge clk) begin
        if (we)
            data[address] <= wd;
        else
            read_data <= data[address];
    end
    
endmodule