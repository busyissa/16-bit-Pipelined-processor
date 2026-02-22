module pipelineTB();
    reg clk, reset;
    top uut(.clk(clk), .reset(reset)); // processor

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   
    end

    initial begin
        reset = 1;
        #20 reset = 0;           // release reset after 20ns
        #500 $stop;              // run for a while
    end
endmodule
