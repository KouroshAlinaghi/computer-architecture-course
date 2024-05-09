parameter INPUT_SIZE = 32;

module Mux4To1(
    opt_0, opt_1, opt_2, opt_3, sel,
    out
);
    input [1:0] sel;
    input [INPUT_SIZE - 1:0] opt_0;
    input [INPUT_SIZE - 1:0] opt_1;
    input [INPUT_SIZE - 1:0] opt_2;
    input [INPUT_SIZE - 1:0] opt_3;

    output [INPUT_SIZE - 1:0] out;

    assign out = (sel == 2'b00) ? opt_0 :
                 (sel == 2'b01) ? opt_1 :
                 (sel == 2'b10) ? opt_1 :
                 opt_3;

endmodule