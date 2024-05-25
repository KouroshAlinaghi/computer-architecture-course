module TB();
    reg clk = 0;
    reg rst = 0;
    
    CPU LUT(.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        #3500 $stop;
    end
    
endmodule
