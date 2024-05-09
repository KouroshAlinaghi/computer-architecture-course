module Controller(
    clk, rst, zero, opc, f3, f7,
    PC_src, reg_write, ALU_src, imm_src, ALU_func, mem_write, result_src
);
    input clk, rst, zero;
    input [6:0] opc;
    input [2:0] f3;
    input [6:0] f7;

    output PC_src, reg_write, ALU_src, mem_write;
    output [1:0] result_src;
    output [2:0] imm_src;
    output [2:0] ALU_func;

    wire [1:0] ALU_op;

    MainController mc(
        clk, rst, zero, opc,
        PC_src, reg_write, ALU_src, imm_src, mem_write, result_src, ALU_op
    );

    ALUDecoder decoder(
        clk, rst, ALU_op, f3, f7,
        ALU_func
    );
endmodule