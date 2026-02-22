module dp(input clk, reset,
          input  resultMuxD, regWriteD, memWriteD, aluMUXD,
          input [1:0] aluOpD,
          input stallF, stallD, flushD, flushE,
          input [1:0] forwardAE, forwardBE, 
          output [1:0] rdE, rs1E, rs2E, rdM, rdW,
          output [3:0] opFunct2,
          output [1:0] rs1Dout, rs2Dout, rdMout, rdWout,
          output branchE, resultMuxEout, regWriteWout,
          output regWriteMout);

// Fetch stage
wire [15:0] pcNext, pcF, instrF, pcPlus1F; 

// Decode stage
wire [15:0] instrD, pcD, immOutD, rd1D, rd2D;
wire [3:0] opcodeFunct2D; 

// Execute stage 
wire [3:0] opcodeFunct2E;
wire [15:0] pcPlusImmE, rd1E, rd2E, immOutE, pcE, aluA, aluB, aluOutE, muxBEOut; 
wire [1:0] aluOpE, opcodeE;  //rs1E, rs2E, rdE
wire regWriteE, memWriteE, aluMuxE, zeroFlag, resultMuxE; 

// Mem Stage
wire [15:0] aluOutM, rd2M, readDataM; 
wire resultMuxM, regWriteM, memWriteM; 

// Writeback stage
wire [15:0] aluOutW, readDataW, result;
wire resultMuxW, regWriteW; 

assign opFunct2 = opcodeFunct2E;
assign resultMuxEout = resultMuxE;
assign regWriteWout = regWriteW;
assign rdMout = rdM;
assign rdWout = rdW;
assign rs1Dout = instrD[7:6];
assign rs2Dout = instrD[9:8];
assign regWriteMout = regWriteM;
assign opcodeE = opcodeFunct2E[1:0];
assign opcodeFunct2D = instrD[3:0];

adder s0(pcF, 16'd1, pcPlus1F);
mux2 #(16) s1(pcPlusImmE, pcPlus1F, branchE, pcNext);
pc s2(clk, reset, ~stallF, pcNext, pcF);
instrMemory s3(pcF, instrF);

// FETCH IN REG
fetchReg snew1(clk, ~stallD, flushD, instrF, pcF, instrD, pcD);

immExt s4(instrD[15:10], immOutD);
regfile s5(clk, regWriteW, instrD[7:6], instrD[9:8], instrD[5:4], result, rd1D, rd2D);

// DECODE IN REG
decodeReg snew2(clk, flushE, opcodeFunct2D, resultMuxD, aluOpD, regWriteD, memWriteD, aluMuxD,    // controller inputs
                rd1D, rd2D, immOutD, pcD, instrD[7:6], instrD[9:8], instrD[5:4],                // dp inputs
                opcodeFunct2E,
                resultMuxE, aluOpE, regWriteE, memWriteE, aluMuxE,                              // controller outputs
                rd1E, rd2E, immOutE, pcE, rs1E, rs2E, rdE);                                     // dp outputs

mux3 #(16) snew5(rd1E, result, aluOutM, forwardAE, aluA);
mux3 #(16) snew6(rd2E, result, aluOutM, forwardBE, muxBEOut);
mux2 #(16) s6(immOutE, muxBEOut, aluMuxE, aluB);
alu s7(aluA, aluB, aluOpE, opcodeFunct2E, aluOutE, zeroFlag);
andGate newAND(opcodeE,zeroFlag, branchE);
adder s8(immOutE, pcE, pcPlusImmE);

// EXECUTE IN REG
executeReg snew3(clk, resultMuxE, regWriteE, memWriteE,     // controller inputs
                aluOutE, muxBEOut, rdE,                     // dp inputs
                resultMuxM, regWriteM, memWriteM,           // controller outputs
                aluOutM, rd2M, rdM);                        // dp outputs

dataMemory s9(clk, memWriteM, aluOutM, rd2M, readDataM);

// MEM IN REG
memReg snew4(clk, resultMuxM, regWriteM,            // controller inputs
             aluOutM, readDataM, rdM,               // dp inputs
             resultMuxW, regWriteW,                 // controller outputs
             aluOutW, readDataW, rdW);              // dp outputs

mux2 #(16) s10(aluOutW, readDataW, resultMuxW, result);

endmodule