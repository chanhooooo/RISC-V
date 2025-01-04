module pipeline_top_tb ();
    
    Pipeline_Top dut(.clk(clk), .rst(rst));
    
    reg clk = 0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end
    
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        #1000;
        $finish;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
    
endmodule
