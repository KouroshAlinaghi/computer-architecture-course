module Counter4Bit(clk, sclr, cen, iz, co, cnt_val);
    input clk, sclr, cen, iz;
    output co;
    output [3:0] cnt_val;
    reg [3:0] cnt_val;

    always @(posedge clk, posedge sclr) begin
        if (sclr)
            cnt_val <= 4'b0000;
        else begin
            if (iz)
                cnt_val <= 4'b0010; // initializing to 16 - 14 = 2
            else if (cen)
                cnt_val <= cnt_val + 1;
        end
    end

    assign co = (cnt_val == 4'b1111);
endmodule