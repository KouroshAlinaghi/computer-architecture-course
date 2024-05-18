module Mux4To1(
    opt_0, opt_1, opt_2, opt_3, sel,
    out
);
    parameter N = 32;

    input [1:0] sel;
    input [N-1:0] opt_0, opt_1, opt_2, opt_3;
    
    output [N-1:0] out;

    assign out = (sel == 2'b00) ? opt_0 :
                 (sel == 2'b01) ? opt_1 :
                 (sel == 2'b10) ? opt_1 :
                 (sel = =2'b11) ? opt_3 :
                 {N{1'bz}};
endmodule

