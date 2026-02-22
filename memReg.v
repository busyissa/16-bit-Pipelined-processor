module memReg(input clk,
              input resultMuxM, regWriteM, 
              input [15:0] aluOutM, readDataM,
              input [1:0] rdM, 
              output reg resultMuxW, regWriteW,
              output reg [15:0] aluOutW, readDataW,
              output reg [1:0] rdW
              );

always @(posedge clk)
begin
    //controller wires
    resultMuxW <= resultMuxM;
    regWriteW <= regWriteM;

    //noncontroller wires
    aluOutW <= aluOutM;
    readDataW <= readDataM;
    rdW <= rdM;
end
endmodule