module decodeReg(input clk, clr,
                 input [3:0] opcodeFunct2D,    
                 input resultMuxD,                                       // controller wires...
                 input [1:0] aluOPD,                                     
                 input regWriteD, memWriteD, aluMuxD,       
                 input [15:0] rd1D, rd2D, immExtD, pcD,                  // noncontroller wires...
                 input [1:0] rs1D, rs2D, rdD,
                 output reg [3:0] opcodeFunct2E,
                 output reg resultMuxE,                                  // controller outputs...
                 output reg [1:0] aluOPE,                    
                 output reg regWriteE, memWriteE, aluMuxE,      
                 output reg [15:0] rd1E, rd2E, immExtE, pcE,             // noncontroller outputs...
                 output reg [1:0] rs1E, rs2E, rdE);

always @(posedge clk)
begin
    if(clr)
    begin
        opcodeFunct2E <= 4'b0;

        //controller wires
        resultMuxE <= 1'b0;
        aluOPE <= 2'b00;
        regWriteE <= 1'b0; 
        memWriteE <= 1'b0; 
        aluMuxE <= 1'b0; 

        //datapath wires
        rd1E <= 16'b0; 
        rd2E <= 16'b0;
        immExtE <= 16'b0;
        pcE <= 16'b0;
        rs1E <= 2'b0;
        rs2E <= 2'b0;
        rdE <= 2'b0;
    end
    else
    begin
        opcodeFunct2E <= opcodeFunct2D;

        //controller wires
        resultMuxE <= resultMuxD;
        aluOPE <= aluOPD;
        regWriteE <= regWriteD;
        memWriteE <= memWriteD;
        aluMuxE <= aluMuxD;

        //datapath wires
        rd1E <= rd1D;
        rd2E <= rd2D;
        immExtE <= immExtD;
        pcE <= pcD;
        rs1E <= rs1D;
        rs2E <= rs2D;
        rdE <= rdD;
    end
end
endmodule