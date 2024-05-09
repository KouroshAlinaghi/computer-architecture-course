// ALU_op codes
`define ADD_ANYWAY 2'b00
`define SUB_ANYWAY 2'b01
`define R_TYPE 2'b10
`define I_TYPE 2'b11

// ALU_func codes
`define ADD_FUNC 3'b000
`define SUB_FUNC 3'b001
`define AND_FUNC 3'b010
`define OR_FUNC 3'b011
`define XOR_FUNC 3'b100
`define SLT_FUNC 3'b101
`define SLTU_FUNC 3'b110


module ALUDecoder(
    clk, rst, ALU_op, f3, f7,
    ALU_func
);
    input clk, rst, zero;
    input [2:0] f3;
    input [6:0] f7;

    output [2:0] ALU_func;
    reg [2:0] ALU_func;

    always @(ALU_op, f3, f7) begin
        case (ALU_op)
            
            `ADD_ANYWAY: ALU_func = `ADD_FUNC;
            `SUB_ANYWAY: ALU_func = `SUB_FUNC;
            
            `R_TYPE: begin
                case ({f7, f3})
                    10'b0000000_000: ALU_func = `ADD_FUNC;
                    10'b0100000_000: ALU_func = `SUB_FUNC;
                    10'b0100000_111: ALU_func = `AND_FUNC;
                    10'b0100000_110: ALU_func = `OR_FUNC;
                    10'b0100000_010: ALU_func = `SLT_FUNC;
                    10'b0100000_011: ALU_func = `SLTU_FUNC;
                    default: ALU_func = ALU_func;
                endcase
            end

            `I_TYPE: begin
                case (f3)
                    3'b000: ALU_func = `ADD_FUNC;
                    3'b100: ALU_func = `XOR_FUNC;
                    3'b110: ALU_func = `OR_FUNC;
                    3'b010: ALU_func = `SLT_FUNC;
                    3'b011: ALU_func = `SLTU_FUNC;
                    default: ALU_func = ALU_func;
                endcase 
            end

            default: ALU_func = `ADD_FUNC;
        endcase
    end
endmodule