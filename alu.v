module alu(input [15:0] a,b, input [1:0] aluSrc, input [3:0] opcodeFunct2E, output reg [15:0] aluOut, output reg zeroFlag);

always @(*)
begin
    case(aluSrc)
    2'b00: aluOut = a + b; //ADD
    2'b01:  //SUB
    begin
        aluOut = a - b;
        if((aluOut==0) && (opcodeFunct2E == 4'b0111))           // beq, branch 
        zeroFlag = 1;
        else if(~(aluOut==0) && (opcodeFunct2E == 4'b1011))     //bne, branch 
        zeroFlag = 1;
        else
        zeroFlag = 0;
    end
    2'b10: aluOut = a & b; //AND
    2'b11: aluOut = a | b; //OR
    endcase
end

endmodule