module Mux2To1(
    opt_if_zero, opt_if_one, sel,
    out
);
    parameter N = 32;
    
    input sel;
    input [N-1:0] opt_if_zero, opt_if_one;

    output [N-1:0] out;
    
    assign out = ~sel ? opt_if_zero : opt_if_one;
endmodule
