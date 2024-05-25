`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define SLT 3'b101
`define XOR 3'b100
`define SLTU 3'b111

module ALU(
    func, lhs, rhs,
    zero, neg, res
);
    input [2:0] func;
    input [31:0] lhs;
    input [31:0] rhs;
    
    output zero, neg;
    output reg [31:0] res = 32'b0;
    
    always @(lhs, rhs, func) begin
        case (func)
            `ADD: res = lhs + rhs;
            `SUB: res = lhs - rhs;
            `AND: res = lhs & rhs;
            `OR: res = lhs | rhs;
            `SLT: res = $signed(lhs) < $signed(rhs) ? 32'd1 : 32'd0;
            `SLTU: res = lhs < rhs ? 32'b1 : 32'b0;
            `XOR: res = lhs ^ rhs;
            default: res = 32'bz;
        endcase
    end

    assign zero = (res == 32'b0) ? 1'b1 : 1'b0;
    assign neg = res[31];
endmodule
