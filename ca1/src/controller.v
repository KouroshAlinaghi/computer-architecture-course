`timescale 1ns/1ns

`define idle 4'b0000
`define waiting 4'b0001
`define check_dvz 4'b0010
`define init 4'b0011
`define loop1 4'b0100
`define loop2 4'b1001
`define check_ovf 4'b0101
`define hold_dvz 4'b0110
`define hold_ovf 4'b0111
`define hold_valid 4'b1000

module Controller(
    start, clk, sclr, ovf_from_dp, lt, dvz_from_dp,
    ovf, dvz, busy, valid, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q
);
    input start, clk, sclr, ovf_from_dp, lt, dvz_from_dp;
    output ovf, dvz, busy, valid, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q;
    reg ovf, dvz, busy, valid, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q, iz_cnt, cen;

    reg [4:0] ps = `idle, ns = `idle;

    wire co;
    wire [3:0] cnt_val;
    Counter4Bit counter(clk, sclr, cen, iz_cnt, co, cnt_val);

    always @(posedge clk, posedge sclr) begin
        case (ps)
            `idle: ns = start ? `waiting : `idle;
            `waiting: ns = start ? `waiting : `check_dvz;
            `check_dvz: ns = dvz_from_dp ? `hold_dvz : `init;
            `hold_dvz: ns = `idle;
            `init: ns = `loop1;
            `loop1: ns = `loop2;
            `loop2: ns = co ? `hold_valid : `check_ovf;
            `hold_valid: ns = `idle;
            `check_ovf: ns = (ovf_from_dp & cnt_val == 4'b1100) ? `hold_ovf : `loop1;
            `hold_ovf: ns = `idle;
            default: ns = `idle;
        endcase
    end


    always @(posedge clk, posedge sclr) begin
        {ovf, dvz, busy, valid, ld_a, ld_b, iz_dp, sel_sub, shen_acc, shen_q, cen, iz_cnt} = 12'b0000_0000_0000;

        case (ps)
            `check_dvz: {busy, ld_a, ld_b} = 3'b111;
            `hold_dvz: {busy, dvz} = 2'b11;
            `init: {busy, iz_dp, iz_cnt} = 3'b111;
            `loop1: {busy, cen, sel_sub} = {2'b11, lt};
            `loop2: {busy, shen_acc, shen_q, sel_sub} = {3'b111, lt};
            `hold_valid: {busy, valid} = 2'b11;
            `check_ovf: {busy} = 1'b1;
            `hold_ovf: {busy, ovf} = 2'b11;
        endcase
    end

    always @(posedge clk, posedge sclr) begin
        if (sclr)
            ps <= `idle;
        else
            ps <= ns;
    end
    
endmodule