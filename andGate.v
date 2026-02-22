module andGate(input [1:0] opcode,          
                input zeroFlag,          
                output y);
    assign y = ((opcode==2'b11) & zeroFlag);    
endmodule