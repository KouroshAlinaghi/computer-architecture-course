`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b010
`define BGE 3'b011

module BranchController(
    f3, branch, neg, zero,
    w
);
    input branch, zero, neg;
    input [2:0] f3;

    output reg w = 1'b0;
    
    always @(f3, zero, neg, branch) begin
        case (f3)
            `BEQ: w <= branch & zero;
            `BNE: w <= branch & ~zero;
            `BLT: w <= branch & neg;
            `BGE: w <= branch & (zero | ~neg);
            default: w <= 1'b0;
        endcase
    end
endmodule
