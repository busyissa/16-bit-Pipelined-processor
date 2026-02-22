module top(input clk, reset);

wire regWriteD, memWriteD, aluMuxD, stallF, stallD, flushD, flushE; 
wire branchE, resultMuxEout, regWriteWout, regWriteMout, resultMuxD;
wire [1:0] aluOpD, forwardAE, forwardBE, rs1Dout, rs2Dout, rdMout, rdWout;
wire [1:0] rdE, rs1E, rs2E, rdM, rdW;
wire [3:0] opFunct2;

dp t0(clk, reset, resultMuxD, regWriteD, memWriteD, aluMuxD, aluOpD, 
      stallF, stallD, flushD, flushE, forwardAE, forwardBE, 
      rdE, rs1E, rs2E, rdM, rdW, opFunct2, rs1Dout, rs2Dout, rdMout, rdWout,
      branchE, resultMuxEout, regWriteWout, regWriteMout);

// module dp(input clk, reset,
//           input [1:0] resultMuxD,
//           input regWriteD, memWriteD, aluMUXD,
//           input [1:0] aluOpD,
//           input stallF, stallD, flushD, flushE,
//           input [1:0] forwardAE, forwardBE, 
//           output [15:0] rdE, rs1E, rs2E, rdM, rdW,
//           output [3:0] opFunct2,
//           output [1:0] rs1Dout, rs2Dout, rdMout, rdWout,
//           output zeroFlagOut, resultMuxEbit0, regWriteWout
//           output regWriteMout);


controller t1(opFunct2, regWriteD, aluMuxD, aluOpD, memWriteD, resultMuxD);

// module controller(input [3:0] instr, 
//                   output we3, aluMUX, 
//                   output [1:0] aluOp, 
//                   output memWrite, resultMUX);

hazard t2(branchE, regWriteMout, regWriteWout, resultMuxEout,
          rs1Dout, rs2Dout, rs1E, rs2E, rdE, rdMout, rdWout,
          stallF, stallD, flushD, flushE, forwardAE, forwardBE);

// module hazard(input zeroFlagOut, regWriteM, regWriteW, resultMuxEbit0,
//               input [1:0] rs1D, rs2D, rs1E, rs2E, rdE, rdM, rdW,
//               output reg stallF, stallD, flushD, flushE, 
//               output reg [1:0] forwardAE, forwardBE);
endmodule


// old wires before fpga
// ---------------------
// wire we3, pcMUX, aluMUX, memWrite,resultMUX,zeroFlag;
// wire [1:0] aluOp;
// wire[3:0] opFunct2;