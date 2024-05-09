module Datapath(
    clk, rst, inst_mem_read, data_mem_read,
    PC_src, reg_write, ALU_src, imm_src, ALU_func, mem_write, result_src,
    zero, inst_mem_addr, data_mem_addr, data_mem_write
);
    input clk, rst;

    input [31:0] inst_mem_read;
    input [31:0] data_mem_read;

    input PC_src, reg_write, ALU_src, mem_write;
    input [1:0] result_src;
    input [2:0] imm_src;
    input [2:0] ALU_func;

    output zero;
    output [31:0] inst_mem_addr;
    output [31:0] data_mem_addr;
    output [31:0] data_mem_write;

    wire [31:0] pc_in;
    wire [31:0] pc_out;
    ProgramCounter pc(
        clk, rst, pc_in,
        pc_out
    );

    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [31:0] result;
    RegisterFile rf(
        clk, rst, inst_mem_read[19:15], inst_mem_read[24:20], inst_mem_read[11:7], result, reg_write,
        RD1, RD2
    )

    wire [31:0] rhs;
    wire [31:0] imm_extended;
    Mux2To1 ALU_rhs(
        RD2, imm_extended, ALU_src,
        rhs
    );

    wire [31:0] ALU_res;
    module ALU(
        RD1, rhs, ALU_func,
        ALU_res, zero
    );

    ImmediateExtention imm_ext(
        inst_mem_read[31:7], imm_src,
        imm_extended
    );

    Mux4To1 result_mux(
        ALU_res, data_mem_read, next_pc, imm_extended, result_src,
        result
    );
    
    wire [31:0] next_pc;
    Adder pc_inc(
        pc_out, 32'b00000000_00000000_00000000_00000100,
        next_pc
    );

    wire [31:0] jump_address;
    Adder jump_addr(
        pc_out, imm_extended,
        jump_address
    );

    Mux2To1 pc_src_mux(
        next_pc, jump_address, PC_src,
        pc_in
    );

    assign data_mem_addr = ALU_res;
    assign data_mem_write = RD2;
    assign inst_mem_addr = pc_out;
endmodule