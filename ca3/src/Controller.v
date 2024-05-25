module Controller(
    clk, rst, opc, f3, f7, zero, neg,
    PCWrite, adrSrc, memWrite,
    IRWrite, resultSrc, ALUControl,
    ALUSrcA, ALUSrcB, immSrc, regWrite
);
    input [6:0] opc;
    input [2:0] f3;
    input [6:0] f7;
    input clk, rst, zero , neg;
    
    output PCWrite, adrSrc, memWrite, IRWrite, regWrite;
    output [1:0] resultSrc, ALUSrcA, ALUSrcB;
    output [2:0] ALUControl, immSrc;
    
    wire PCUpdate, branch, branchRes;
    wire [1:0] ALUOp;

    MainController main_c(
        .clk(clk), .rst(rst), .opc(opc),
        .zero(zero), .neg(neg), .PCUpdate(PCUpdate),
        .adrSrc(adrSrc), .memWrite(memWrite),
        .branch(branch), .resultSrc(resultSrc),
        .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB),
        .immSrc(immSrc), .regWrite(regWrite),
        .IRWrite(IRWrite), .ALUOp(ALUOp)
    );
    
    ALUDecoder alu_decoder(
        .f3(f3), .f7(f7), .ALUOp(ALUOp), .ALUControl(ALUControl)
    );    
    
    BranchController BranchDecoder(
        .f3(f3), .branch(branch), 
        .neg(neg), .zero(zero), .w(branchRes)
    ); 

    assign PCWrite = (PCUpdate | branchRes);    
endmodule
