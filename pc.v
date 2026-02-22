module pc(input clk, reset, en, input [15:0] PCNext, output reg [15:0] PC);

//reg logic
 always @ (posedge clk or posedge reset) 
 begin
    if (reset)
        PC <= 16'b0;
    else if(en)
        PC <= PCNext; 
end

endmodule