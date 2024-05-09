`timescale 1ns/1ns
module Datapath(
    clk, sclr, ld_a, ld_b, iz, sel_sub, shen_acc, shen_q, a_in, b_in,
    lt, ovf_from_dp, dvz, quotient
);
    input clk, sclr, ld_a, ld_b, iz, sel_sub, shen_acc, shen_q;
    input [9:0] a_in;
    input [9:0] b_in;

    output lt, ovf_from_dp, dvz;
    output [9:0] quotient;

    wire [9:0] a_reg;
    wire [9:0] b_reg;
    reg [10:0] acc_reg;
    wire [9:0] q_reg;

    wire [10:0] partial_acc;
    wire [10:0] sub_res;
    
    assign sub_res = acc_reg - {1'b0, b_reg};
    assign partial_acc = (sel_sub == 1) ? sub_res : acc_reg;
    assign serin_q = (sel_sub == 1) ? 1'b1 : 1'b0;
    assign lt = ~sub_res[10];
    assign ovf_from_dp = (q_reg[9:4] != 0);
    assign dvz = (b_in == 10'b0);
    assign quotient = q_reg;

    NomralReg10 AReg(clk, sclr, ld_a, a_in, a_reg);
    NomralReg10 BReg(clk, sclr, ld_b, b_in, b_reg);

    ShiftReg10 QReg(clk, sclr, iz, shen_q, serin_q, {a_reg[8:0], 1'b0}, q_reg);

    // ACC
    always @(posedge clk, posedge sclr) begin
        if (sclr)
            acc_reg <= 11'b0;
        else begin
            if (iz)
                acc_reg <= {10'b0, a_reg[9]};
            else if (shen_acc)
                acc_reg <= {partial_acc[9:0], q_reg[9]};
        end
    end
endmodule