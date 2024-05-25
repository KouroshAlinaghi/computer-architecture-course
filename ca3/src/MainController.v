`define R_T     7'b0110011
`define I_T     7'b0010011
`define S_T     7'b0100011
`define B_T     7'b1100011
`define U_T     7'b0110111
`define J_T     7'b1101111
`define LW_T    7'b0000011
`define JALR_T  7'b1100111


`define IF     5'b00000
`define ID     5'b00001
`define EX1    5'b00010
`define EX2    5'b00011
`define EX3    5'b00100
`define EX4    5'b00101
`define EX5    5'b00110
`define EX6    5'b00111
`define EX7    5'b01000
`define EX8    5'b01001
`define EX9    5'b01010
`define MEM1   5'b01011
`define MEM2   5'b01100
`define MEM3   5'b01101
`define MEM4   5'b01110
`define MEM5   5'b01111
`define MEM6   5'b10000
`define WB     5'b10001

module MainController(
    clk, rst, opc, zero, 
    PCUpdate, adrSrc, memWrite, branch,
    IRWrite, resultSrc, ALUOp, neg,
    ALUSrcA, ALUSrcB, immSrc, regWrite
);
    input [6:0] opc;
    input clk, rst, zero , neg;

    output reg [1:0]  resultSrc, ALUSrcA, ALUSrcB, ALUOp;
    output reg [2:0] immSrc;
    output reg adrSrc, regWrite, memWrite, PCUpdate, branch, IRWrite;

    reg [4:0] ps = `IF;
    reg [4:0] ns = `IF;

    always @(ps, opc) begin
        case (ps)
            `IF: ns <= `ID;

            `ID: begin
                case (opc)
                   `R_T: ns <= `EX2;
                   `I_T: ns <= `EX1;
                   `S_T: ns <= `EX6;
                   `J_T: ns <= `EX4;
                   `B_T: ns <= `EX3;
                   `U_T: ns <= `MEM5;
                   `LW_T: ns <= `EX9;
                   `JALR_T: ns <= `EX8; 
                   default: ns <= `IF;
               endcase
            end

            `EX1: ns <= `MEM2;
            `EX2: ns <= `MEM4;
            `EX3: ns <= `IF;
            `EX4: ns <= `EX7;
            `EX5: ns <= `MEM2;
            `EX6: ns <= `MEM3;
            `EX7: ns <= `MEM6;
            `EX8: ns <= `EX5;
            `EX9: ns <= `MEM1;

            `MEM1: ns <= `WB;
            `MEM2: ns <= `IF;
            `MEM3: ns <= `IF;
            `MEM4: ns <= `IF;
            `MEM5: ns <= `IF;
            `MEM6: ns <= `IF;

            `WB  : ns <= `IF;
        endcase
    end


    always @(ps) begin
        {resultSrc, memWrite, ALUOp, ALUSrcA, ALUSrcB, immSrc, 
                regWrite, PCUpdate, branch, IRWrite, adrSrc} <= 15'b0;

        case (ps)
            `IF : begin
                IRWrite <= 1'b1;
                ALUSrcA <= 2'b00;
                ALUSrcB <= 2'b10;
                ALUOp <= 2'b00;
                resultSrc <= 2'b10;
                PCUpdate <= 1'b1;
                adrSrc <= 1'b0;
            end
        
            `ID: begin
                ALUSrcA <= 2'b01;
                ALUSrcB <= 2'b01;
                ALUOp <= 2'b00;
                immSrc <= 3'b010;
            end
        
            `EX1: begin 
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b01;
                immSrc <= 3'b000;
                ALUOp <= 2'b11;
            end

            `EX2: begin
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b10;
            end
        
            `EX3: begin
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b01;
                resultSrc <= 2'b0;
                branch <= 1'b1;
            end
        
            `EX4: begin
                ALUSrcA <= 2'b01;
                ALUSrcB <= 2'b10;
                ALUOp <= 2'b00;
            end
        
            `EX5: begin
                ALUSrcA <= 2'b01;
                ALUSrcB <= 2'b10;
                ALUOp  <= 2'b00;
                resultSrc <= 2'b00;
                PCUpdate <= 1'b1;
            end
        
            `EX6: begin
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b01;
                ALUOp <= 2'b00;
                immSrc <= 3'b001;
            end
        
            `EX7: begin
                regWrite <= 1'b1;
                ALUSrcA <= 2'b01;
                ALUSrcB <= 2'b01;
                immSrc <= 3'b011;
                ALUOp <= 2'b00;
            end

            `EX8: begin 
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b01;
                immSrc <= 3'b000;
                ALUOp <= 2'b00;
            end

            `EX9: begin 
                ALUSrcA <= 2'b10;
                ALUSrcB <= 2'b01;
                immSrc <= 3'b000;
                ALUOp <= 2'b00;
            end

            `MEM1: begin
                resultSrc <= 2'b00;
                adrSrc <= 1'b1;
            end
        
            `MEM2: begin
                resultSrc <= 2'b00;
                regWrite <= 1'b1;
            end
        
            `MEM3: begin
                resultSrc <= 2'b00;
                adrSrc <= 1'b1;
                memWrite  <= 1'b1;
            end
        
            `MEM4: begin
                resultSrc <= 2'b00;
                regWrite <= 1'b1;
            end
        
            `MEM5: begin
                resultSrc <= 2'b11;
                immSrc <= 3'b100;
                regWrite  <= 1'b1;
            end
        
            `MEM6: begin
                resultSrc <= 2'b00;
                PCUpdate <= 1'b1;
            end
        
            `WB: begin
                resultSrc <= 2'b01;
                regWrite <= 1'b1;
            end
        
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IF;
        else
            ps <= ns;
    end

endmodule
