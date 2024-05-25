module Memory(
    clk, address, wd, we, 
    read_data
);
    input [31:0] address, wd;
    input we, clk;

    output [31:0] read_data;

    reg [7:0] data [0:$pow(2, 16)-1];

    integer i;
    initial begin
        for (i = 0; i < $pow(2, 16); i = i + 1)
            data[i] = 32'b0;

        $readmemb("data.mem", data);
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