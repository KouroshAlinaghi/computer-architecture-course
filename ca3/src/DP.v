module Datapath(
    clk, rst, PCWrite, adrSrc, memWrite,
    IRWrite, resultSrc, ALUControl,
    ALUSrcA, ALUSrcB, immSrc, regWrite,
    opc, f3, f7, zero, neg
);
    input clk, rst, PCWrite, adrSrc, memWrite, IRWrite, regWrite;
    input [1:0] resultSrc, ALUSrcA, ALUSrcB;
    input [2:0] ALUControl, immSrc;
    output [6:0] opc;
    output [2:0] f3;
    output [6:0] f7;
    output zero, neg;

    wire [31:0] PC, Adr, ReadData, OldPC;
    wire [31:0] ImmExt, instr, Data;
    wire [31:0] RD1, RD2, A, B, SrcA, SrcB;
    wire [31:0] ALUResult, ALUOut, Result;

    Mux2To1 address_mux(
        .sel(adrSrc), .opt_0(PC), .opt_1(Result),
        .out(Adr)
    );

    Mux4To1 a_mux(
        .sel(ALUSrcA), .opt_0(PC), .opt_1(OldPC), .opt_2(A), .opt_3(32'd0),
        .out(SrcA)
    );

    Mux4To1 b_mux(
        .sel(ALUSrcB), .opt_0(B), .opt_1(ImmExt), .opt_2(32'd4), .opt_3(32'd0),
        .out(SrcB)
    );
    
    Mux4To1 res_mux(
        .sel(resultSrc), .opt_0(ALUOut), .opt_1(Data), .opt_2(ALUResult), .opt_3(ImmExt),
        .out(Result)
    );

    ImmExtension extention_unit(
        .immSrc(immSrc), .data(instr[31:7]),
        .w(ImmExt)
    );

    ALU alu(
        .func(ALUControl), .lhs(SrcA), .rhs(SrcB), 
        .zero(zero), .neg(neg), .res(ALUResult)
    );

    Memory memory(
        .address(Adr), .wd(B), .clk(clk), .we(memWrite),
        .read_data(ReadData)
    );

    RegisterFile reg_file(
        .clk(clk), .rst(rst), .we(regWrite), .wd(Result), .addr1(instr[19:15]), .addr2(instr[24:20]), .addr3(instr[11:7]),
        .read_data1(RD1), .read_data2(RD2)
    );

    Register pc_reg(
        .in(Result), .ld(PCWrite), .rst(rst), .clk(clk),
        .w(PC)
    );

    Register old_pc_reg(
        .in(PC), .ld(IRWrite), .rst(1'b0), .clk(clk),
        .w(OldPC)
    );

    Register instruction_reg(
        .in(ReadData), .ld(IRWrite), .rst(1'b0), .clk(clk),
        .w(instr)
    );

    Register memory_read_reg(
        .in(ReadData),  .ld(1'b1), .rst(1'b0), .clk(clk),
        .w(Data)
    );

    Register a_reg(
        .in(RD1), .ld(1'b1), .rst(1'b0), .clk(clk),
        .w(A)
    );
    
    Register b_reg(
        .in(RD2), .ld(1'b1), .rst(1'b0), .clk(clk),
        .w(B)
    );
    
    Register alu_res_reg(
        .in(ALUResult), .ld(1'b1), .rst(1'b0), .clk(clk),
        .w(ALUOut)
    );

    assign opc = instr[6:0];
    assign f3 = instr[14:12];
    assign f7 = instr[31:25];
endmodule
