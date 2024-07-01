`timescale 1ns/1ns
module tb();
    reg clk = 0;
    reg rst = 0;

    Computer DUT(clk, rst);

    initial begin
        rst = 1;
        #100
        rst = 0;

        repeat (900) #100 begin
            clk = ~clk;
        end

        $stop;
    end

endmodule
