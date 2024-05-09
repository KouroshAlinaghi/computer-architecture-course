// ALU opc
`define ADD_ANYWAY 2'b00
`define SUB_ANYWAY 2'b01
`define R_TYPE 2'b10
`define I_TYPE 2'b11

// imm src
`define IMM_I_TYPE 3'b000
`define IMM_S_TYPE 3'b001
`define IMM_B_TYPE 3'b010
`define IMM_LUI 3'b011
`define IMM_JAL 3'b100

// opcodes
`define LW 7'b0000011
`define SW 7'b0100011
`define RT 7'b0110011
`define BT 7'b1100011
`define IT 7'b0010011
`define LUI 7'b0110111
`define JAL 7'b1101111
`define JALR 7'b1100111

// f3 branch type
`define EQ 3'b000
`define NE 3'b001
`define LT 3'b100
`define GE 3'b101

module MainController(
    clk, rst, zero, opc, f3, neg,
    PC_src, reg_write, ALU_src, imm_src, mem_write, result_src, ALU_op, is_jalr
);
    input clk, rst, zero, neg;
    input [2:0] f3;
    input [6:0] opc;

    output PC_src, reg_write, ALU_src, mem_write, is_jalr;
    output [1:0] result_src;
    output [2:0] imm_src;
    output [1:0] ALU_op;

    reg PC_src, reg_write, ALU_src, mem_write, is_jalr;
    reg [1:0] result_src;
    reg [2:0] imm_src;
    reg [1:0] ALU_op;

    always @(zero, opc) begin
        {PC_src, reg_write, ALU_src, mem_write} = 4'b0000;
        result_src = 2'b00;
        imm_src = `IMM_I_TYPE;
        ALU_op = `ADD_ANYWAY;
        is_jalr = 1'b0;
        case (opc)
            `LW: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0110;
                result_src = 2'b01;
                imm_src = `IMM_I_TYPE;
                ALU_op = `ADD_ANYWAY;
                is_jalr = 1'b0;
            end
            `SW: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0011;
                result_src = 2'b00;
                imm_src = `IMM_S_TYPE;
                ALU_op = `SUB_ANYWAY;
                is_jalr = 1'b0;
            end
            `RT: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0100;
                result_src = 2'b00;
                imm_src = `IMM_I_TYPE;
                ALU_op = `R_TYPE;
                is_jalr = 1'b0;
            end
            `BT: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0000;
                result_src = 2'b00;
                imm_src = `IMM_B_TYPE;
                ALU_op = `SUB_ANYWAY;
                is_jalr = 1'b0;
                case (f3)
                    `EQ: PC_src = zero;
                    `NE: PC_src = ~zero;
                    `LT: PC_src = neg;
                    `GE: PC_src = ~neg | zero;
                    default : PC_src = 1'b0;
                endcase
            end
            `IT: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0110;
                result_src = 2'b00;
                imm_src = `IMM_I_TYPE;
                ALU_op = `I_TYPE;
                is_jalr = 1'b0;
            end
            `LUI: begin
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0110;
                result_src = 2'b11;
                imm_src = `IMM_LUI;
                ALU_op = `I_TYPE;
                is_jalr = 1'b0;
            end
            `JAL: begin
                {PC_src, reg_write, ALU_src, mem_write} = 4'b1110;
                result_src = 2'b10;
                imm_src = `IMM_JAL;
                ALU_op = `I_TYPE;
                is_jalr = 1'b0;
            end
            `JALR: begin
                {PC_src, reg_write, ALU_src, mem_write} = 4'b1110;
                result_src = 2'b10;
                imm_src = `IMM_I_TYPE;
                ALU_op = `ADD_ANYWAY;
                is_jalr = 1'b1;
            end
            default: begin 
                {PC_src, reg_write, ALU_src, mem_write} = 4'b0000;
                result_src = 2'b00;
                imm_src = `IMM_I_TYPE;
                ALU_op = `ADD_ANYWAY;
                is_jalr = 1'b0;
            end
        endcase
    end
endmodule