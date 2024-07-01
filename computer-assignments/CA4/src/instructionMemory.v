module instructionMemory(A, RD);
        input [31:0] A;
        output [31:0] RD;
        wire [31:0] khoone;

        reg [31:0] memory [0:16384]; // 2^14
        initial begin
                $readmemb("instructions.mem", memory);
        end

        assign khoone = {2'b0, A[31:2]};
        assign RD = memory[khoone];
endmodule