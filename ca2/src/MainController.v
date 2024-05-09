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
`define JT 7'b1101111

module MainController(
    clk, rst, zero, opc,
    PC_src, reg_write, ALU_src, imm_src, mem_write, result_src, ALU_op
);
    input clk, rst, zero;
    input [6:0] opc;

    output PC_src, reg_write, ALU_src, mem_write;
    output [1:0] result_src;
    output [2:0] imm_src;
    output [1:0] ALU_op;

    reg PC_src, reg_write, ALU_src, imm_src, mem_write, result_src;
    reg [2:0] imm_src;
    reg [1:0] ALU_op;

    always @(zero, opc) begin
        {PC_src, reg_write, ALU_src, result_src, mem_write} = 5'b00000;
        imm_src = `IMM_I_TYPE;
        ALU_op = `ADD_ANYWAY;
        case (opc)
            `LW: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b0110;
                result_src = 2'b01;
                imm_src = `IMM_I_TYPE;
                ALU_op = `ADD_ANYWAY;
            end
            `SW: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b0011;
                result_src = 2'b00;
                imm_src = `IMM_S_TYPE;
                ALU_op = `SUB_ANYWAY;
            end
            `RT: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b0100;
                result_src = 2'b00;
                imm_src = `IMM_I_TYPE;
                ALU_op = `R_TYPE;
            end
            `BT: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b1000;
                result_src = 2'b00;
                imm_src = `IMM_B_TYPE;
                ALU_op = `SUB_ANYWAY;
            end
            `IT: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b0110;
                result_src = 2'b00
                imm_src = `IMM_I_TYPE;
                ALU_op = `I_TYPE;
            end
            `LUI: begin
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b0110;
                result_src = 2'b11;
                imm_src = `IMM_I_TYPE;
                ALU_op = `I_TYPE;
            end
            `JT: begin
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 4'b1110;
                result_src = 2'b10;
                imm_src = `IMM_I_TYPE;
                ALU_op = `I_TYPE;
            end
            default: begin 
                {PC_src, reg_write, ALU_src, result_src, mem_write} = 5'b00000;
                imm_src = `IMM_I_TYPE;
                ALU_op = `ADD_ANYWAY;
            end
        endcase
    end
endmodule