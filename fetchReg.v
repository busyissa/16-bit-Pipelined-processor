module fetchReg(input clk, en, clr, 
                input [15:0] instrF, pcF,
                output reg [15:0] instrD, pcD);

always @(posedge clk)
begin
    if(clr) // if clear
    begin
        instrD <= 16'b0;
        pcD <= 16'b0;
    end
    else if(en) // if enabled and not clear
    begin
        instrD <= instrF;
        pcD <= pcF;
    end
    //else case does nothing (if not enabled)
end

endmodule