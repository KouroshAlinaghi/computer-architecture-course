`define IMM_I_TYPE 2'b00
`define IMM_S_TYPE 2'b01
`define IMM_B_TYPE 2'b10
`define IMM_LUI 2'b11

module ImmediateExtention(
    imm_data, imm_src,
    res
);
    input [24:0] imm_data;
    input [2:0] imm_src;

    output [31:0] res;
    reg [31:0] res;

    always @(imm_data, imm_src) begin
        case (imm_src)
            `IMM_I_TYPE: res = { {20{imm_data[24]}}, imm_data[24:12] };
            `IMM_S_TYPE: res = { {20{imm_data[24]}}, imm_data[24:18], imm_data[4:0] };
            `IMM_B_TYPE: res = { {19{imm_data[24]}}, imm_data[24], imm_data[0], imm_data[23:18], imm_data[4:1], 1'b0 };
            `IMM_LUI: res = { imm_data[24:5], 12'b0 };
            default: 
        endcase
    end
    
endmodule