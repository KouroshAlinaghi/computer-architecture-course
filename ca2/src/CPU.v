module CPU(
    clk, rst, inst_mem_read, data_mem_read,
    mem_write, inst_mem_addr, data_mem_addr, data_mem_write
);
    input clk, rst;

    input [31:0] inst_mem_read;
    input [31:0] data_mem_read;
    
    output mem_write;
    output [31:0] inst_mem_addr;
    output [31:0] data_mem_addr;
    output [31:0] data_mem_write;

    // controlling signals
    wire PC_src, reg_write, ALU_src, mem_write;
    wire [2:0] imm_src;
    
    input [1:0] result_src;
    wire [2:0] ALU_func;

    wire zero;

    Datapath dp(
        clk, rst, inst_mem_read, data_mem_read,
        PC_src, reg_write, ALU_src, imm_src, ALU_func, mem_write, result_src,
        zero, inst_mem_addr, data_mem_addr, data_mem_write
    );

    Controller cu(
        clk, rst, zero, inst_mem_read[6:0], inst_mem_read[14:12], inst_mem_read[31:25],
        PC_src, reg_write, ALU_src, imm_src, ALU_func, mem_write, result_src
    );
endmodule