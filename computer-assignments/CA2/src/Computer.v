module Computer(
    clk, rst
);
    input clk, rst;

    wire [31:0] inst_mem_read;
    wire [31:0] data_mem_read;
    
    wire mem_write;
    wire [31:0] inst_mem_addr;
    wire [31:0] data_mem_addr;
    wire [31:0] data_mem_write;

    CPU risc_v(
        clk, rst, inst_mem_read, data_mem_read,
        mem_write, inst_mem_addr, data_mem_addr, data_mem_write
    );

    InstructionMemory im(
        clk, rst, inst_mem_addr,
        inst_mem_read
    );

    DataMemory dm(
        clk, rst, data_mem_addr, data_mem_write, mem_write,
        data_mem_read
    );
endmodule