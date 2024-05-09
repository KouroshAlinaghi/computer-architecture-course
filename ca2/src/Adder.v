module Adder(
    A, B,
    res
);
    input [31:0] A;
    input [13:0] B;

    output [13:0] res;

    assign res = A + B;
endmodule