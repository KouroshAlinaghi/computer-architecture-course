module Register(
    clk, rst, in, ld,
    w
);
    input [31:0] in;
    input ld, clk, rst;

    output reg [31:0] w = 32'b0;

    always @(posedge clk, posedge rst) begin
        if (rst)
            w <= 32'b0;
        else if (ld)
            w <= in;
    end
endmodule
