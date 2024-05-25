module CPU(
    clk, rst
);
    input clk, rst;
    
    wire [2:0] f3, ALUControl, immSrc;
    wire [6:0] f7;

    wire zero, neg, memWrite, regWrite, PCWrite, adrSrc, IRWrite;

    wire [1:0] resultSrc, ALUSrcA, ALUSrcB;
    
    wire [6:0] opc; 

    Controller CU(
        .clk(clk), .rst(rst), .opc(opc), 
        .f3(f3), .immSrc(immSrc), 
        .f7(f7), .zero(zero), 
        .neg(neg), .PCWrite(PCWrite),
        .adrSrc(adrSrc), .memWrite(memWrite), 
        .IRWrite(IRWrite), .resultSrc(resultSrc), 
        .ALUControl(ALUControl), .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB), .regWrite(regWrite)
    );

    Datapath DP(
        .clk(clk), .rst(rst), .neg(neg),
        .PCWrite(PCWrite), .adrSrc(adrSrc),
        .memWrite(memWrite), .IRWrite(IRWrite), 
        .resultSrc(resultSrc), .immSrc(immSrc), 
        .ALUControl(ALUControl), .opc(opc),
        .ALUSrcA(ALUSrcA), .f3(f3),
        .ALUSrcB(ALUSrcB), .zero(zero),
        .regWrite(regWrite), .f7(f7)
    );
endmodule