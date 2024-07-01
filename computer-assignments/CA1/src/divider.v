`timescale 1ns/1ns
module Divider(
    start, clk, sclr, a_in, b_in,
    dvz, ovf, busy, valid, q_out
);

    input [9:0] a_in;
    input [9:0] b_in;
    input start, clk, sclr;
    output dvz, ovf, busy, valid;
    output [9:0] q_out;

    wire ovf_from_dp, lt, dvz_from_dp;
    wire ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q;

    Controller cu(
        start, clk, sclr, ovf_from_dp, lt, dvz_from_dp,
        ovf, dvz, busy, valid, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q
    );

    Datapath dp(
        clk, sclr, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q, a_in, b_in,
        lt, ovf_from_dp, dvz_from_dp, q_out
    );
endmodule