module Mux2To1(
    opt_0, opt_1, sel,
    out
);
    input sel;
    input [31:0] opt_0;
    input [31:0] opt_1;

    output [31:0] out;
    
    assign out = (sel == 1'b0) ? opt_0 :
                 (sel == 1'b1) ? opt_1 :
                 32'bz;
endmodule