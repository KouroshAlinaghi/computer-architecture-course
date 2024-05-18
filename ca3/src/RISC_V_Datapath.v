module RISC_V_Datapath(
    clk, rst, PCWrite, adrSrc, memWrite,
    IRWrite, resultSrc, ALUControl,
    ALUSrcA, ALUSrcB, immSrc, regWrite,
    op, func3, func7, zero, neg
);
    input clk, rst, PCWrite, adrSrc, memWrite, IRWrite, regWrite;
    input [1:0] resultSrc, ALUSrcA, ALUSrcB;
    input [2:0] ALUControl, immSrc;
    output [6:0] op;
    output [2:0] func3;
    output func7, zero, neg;

    wire [31:0] PC, Adr, ReadData, OldPC;
    wire [31:0] ImmExt, instr, Data;
    wire [31:0] RD1, RD2, A, B, SrcA, SrcB;
    wire [31:0] ALUResult, ALUOut,Result;

    Register PCR(
        .in(Result), .en(PCWrite), .rst(rst), .clk(clk), .out(PC)
    );

    Register OldPCR(
        .in(PC), .en(IRWrite), .rst(1'b0), .clk(clk), .out(OldPC)
    );

    Register IR(
        .in(ReadData), .en(IRWrite), .rst(1'b0), .clk(clk), .out(instr)
    );

    Register MDR(
        .in(ReadData),  .en(1'b1), .rst(1'b0), .clk(clk), .out(Data)
    );

    Register AR(
        .in(RD1), .en(1'b1), .rst(1'b0), .clk(clk), .out(A)
    );
    
    Register BR(
        .in(RD2), .en(1'b1), .rst(1'b0), .clk(clk), .out(B)
    );
    
    Register ALUR(
        .in(ALUResult), .en(1'b1), .rst(1'b0), .clk(clk), .out(ALUOut)
    );

    Mux2to1 AdrMux(.sel(adrSrc),    .opt_if_zero(PC),     .opt_if_one(Result), .out(Adr));

    Mux4to1 AMux       (.sel(ALUSrcA),   .opt_0(PC),     .opt_1(OldPC),  .opt_2(A),         .opt_3(32'd0),  .out(SrcA));
    Mux4to1 BMux       (.sel(ALUSrcB),   .opt_0(B),      .opt_1(ImmExt), .opt_2(32'd4),     .opt_3(32'd0),  .out(SrcB));
    Mux4to1 ResultMux  (.sel(resultSrc), .opt_0(ALUOut), .opt_1(Data),   .opt_2(ALUResult), .opt_3(ImmExt), .out(Result));

    ImmExtension Extend(
        .immSrc(immSrc), .data(instr[31:7]), .w(ImmExt)
    );

    ALU ALU_Instance(
        .opc(ALUControl), .lhs(SrcA), .rhs(SrcB), 
        .zero(zero), .neg(neg), .res(ALUResult)
    );

    Memory M(
        .memAdr(Adr), .writeData(B), .clk(clk), 
        .memWrite(memWrite), .readData(ReadData)
    );

    RegisterFile RF(
        .clk(clk),
        .rst(rst),
        .we(regWrite),
        .wd(Result), 
        .read_data1(RD1), .read_data2(RD2),
        .addr1(instr[19:15]), 
        .addr2(instr[24:20]),
        .addr3(instr[11:7])
    );

    assign op = instr[6:0];
    assign func3 = instr[14:12];
    assign func7 = instr[30];
endmodule
