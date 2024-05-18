module RegisterFile(
    clk, rst, addr1, addr2, addr3, wd, we,
    read_data1, read_data2
);
    input clk, rst, we;
    input [4:0] addr1;
    input [4:0] addr2;
    input [4:0] addr3;
    
    input [31:0] wd;
    
    output [31:0] read_data1;
    reg [31:0] read_data1 = 32'b0; 
    output [31:0] read_data2;
    reg [31:0] read_data2 = 32'b0; 

    reg [31:0] data [0:31];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            data[i] = 32'b0;
    end

    always @(addr1, addr2) begin
        read_data1 <= data[addr1];
        read_data2 <= data[addr2];    
    end

    always @(posedge clk, rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                data[i] = 32'b0;
            end
        end 
        else begin if (we)
            data[addr3] <= wd;
        end
    end
    
endmodule
