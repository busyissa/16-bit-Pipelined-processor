module executeReg(input clk,
                  input resultMuxE,
                  input regWriteE, memWriteE,
                  input [15:0] aluOutE, rd2E,
                  input [1:0] rdE,
                  output reg resultMuxM,
                  output reg regWriteM, memWriteM,
                  output reg [15:0] aluOutM, rd2M,
                  output reg [1:0] rdM);

always @(posedge clk)
begin
        //controller wires
        resultMuxM <= resultMuxE;
        regWriteM <= regWriteE;
        memWriteM <= memWriteE;

        //datapath wires
        aluOutM <= aluOutE;
        rd2M <= rd2E;
        rdM <= rdE;
end
endmodule