module Mux2To1(
    opt_if_zero, opt_if_one, sel,
    out
);
    parameter INPUT_SIZE = 32;

    input sel;
    input [INPUT_SIZE - 1:0] opt_if_zero;
    input [INPUT_SIZE - 1:0] opt_if_one;    

    output [INPUT_SIZE - 1:0] out;

    assign out = (sel == 1'b1) ? opt_if_one : opt_if_zero;

endmodule