module controller(input [3:0] instr, 
                  output we3, aluMUX, 
                  output [1:0] aluOp, 
                  output memWrite, resultMUX);

//for simplicity
reg [5:0] controlLogic;
assign {we3,aluMUX,aluOp,memWrite,resultMUX} = controlLogic;

//Note: instr[1:0] = opcode (enable logic)
//      instr[3:2] = funct2 (controls alu)

always @(*)
begin
    case(instr)
    //R-Type
    4'b0000: controlLogic = 6'b100000;           //add
    4'b0100: controlLogic = 6'b100100;           //sub
    4'b1000: controlLogic = 6'b101000;           //and
    4'b1100: controlLogic = 6'b101100;           //or

    //LW-type
    4'b0001: controlLogic = 6'b110001;

    //SW-Type
    4'b0010: controlLogic = 6'b010011;

    //B-type
    4'b0111: controlLogic = 6'b000100;      // beq
    4'b1011: controlLogic = 6'b000100;      // bne
    default: controlLogic = 6'b0;
    endcase
end

endmodule