`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define SLT 3'b101
`define XOR 3'b100
`define SLTU 3'b111

module ALU(opc, lhs, rhs, zero, neg, res);
    parameter N = 32;

    input [2:0] opc;
    input [N-1:0] lhs, rhs;
    
    output zero, neg;
    output reg [N-1:0] res;
    
    always @(lhs or rhs or opc) begin
        case (opc)
            `ADD: res = lhs + rhs;
            `SUB: res = lhs - rhs;
            `AND: res = lhs & rhs;
            `OR: res = lhs | rhs;
            `SLT: res = $signed(lhs) < $signed(rhs) ? 32'd1 : 32'd0;
            `SLTU: res = lhs < rhs ? 32'b1 : 32'b0;
            `XOR: res = lhs ^ rhs;
            default: res = {N{1'bz}};
        endcase
    end

    assign zero = (~|res);
    assign neg = res[N-1];
endmodule
