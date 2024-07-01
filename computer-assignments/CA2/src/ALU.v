`define ADD_FUNC 3'b000
`define SUB_FUNC 3'b001
`define AND_FUNC 3'b010
`define OR_FUNC 3'b011
`define XOR_FUNC 3'b100
`define SLT_FUNC 3'b101
`define SLTU_FUNC 3'b110

module ALU(
    lhs, rhs, func,
    res, zero, neg
);
    input [31:0] lhs;
    input [31:0] rhs;
    input [2:0] func;

    output zero, neg;
    output [31:0] res;

    reg [31:0] res = 32'b0;

    assign zero = (res == 32'b0) ? 1'b1 : 1'b0;
    assign neg = res[31];

    always @(lhs, rhs, func) begin
        case (func)
            `ADD_FUNC: res = lhs + rhs;
            `SUB_FUNC: res = lhs - rhs;
            `AND_FUNC: res = lhs & rhs;
            `OR_FUNC: res = lhs | rhs;
            `XOR_FUNC: res = lhs ^ rhs;
            `SLT_FUNC: res = ($signed(lhs) < $signed(rhs)) ? 32'b1 : 32'b0;
            `SLTU_FUNC: res = (lhs < rhs) ? 32'b1 : 32'b0;
            default: res = lhs + rhs;
        endcase
    end
endmodule