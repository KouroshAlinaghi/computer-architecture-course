`define S_T   2'b00
`define B_T   2'b01
`define R_T   2'b10
`define I_T   2'b11

`define ADD  3'b000
`define SUB  3'b001
`define AND  3'b010
`define OR   3'b011
`define SLT  3'b101
`define XOR  3'b100
`define SLTU 3'b111

module ALUDecoder(
    f3, f7, ALUOp,
    ALUControl
);
    input [2:0] f3;
    input [6:0] f7;
    input [1:0] ALUOp;

    output reg [2:0] ALUControl = `ADD;
    
    always @(ALUOp, f3, f7) begin
        case (ALUOp)
            `S_T: ALUControl <= `ADD;
            `B_T: ALUControl <= `SUB;
            
            `R_T: begin
                case ({f7, f3})
                    10'b0000000_000: ALUControl <= `ADD;
                    10'b0100000_000: ALUControl <= `SUB;
                    10'b0000000_111: ALUControl <= `AND;
                    10'b0000000_110: ALUControl <= `OR;
                    10'b0000000_010: ALUControl <= `SLT;
                    10'b0000000_011: ALUControl <= `SLTU;
                    default: ALUControl <= `ADD;
                endcase
            end

            `I_T: begin
                case (f3)
                    3'b000: ALUControl <= `ADD;
                    3'b100: ALUControl <= `XOR;
                    3'b110: ALUControl <= `OR;
                    3'b010: ALUControl <= `SLT;
                    3'b011: ALUControl <= `SLTU;
                    default: ALUControl <= `ADD;
                endcase 
            end

            default: ALUControl <= `ADD;
        endcase
    end
endmodule
