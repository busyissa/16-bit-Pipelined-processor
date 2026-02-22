module instrMemory(input [15:0] pc, output [15:0] instr);

reg [15:0] RAM [63:0]; // limited memory 

//initial $readmemh ("\\wsl.localhost\Ubuntu\home\issa\CS302\CPE 300L\16-bitRISCProject\machinecode.mem",RAM);

// hardcode program
initial 
begin//        HEX          ASSEMBLY                       ASSEMBLY TRANSLATION                                                 MACHINE CODE            HEX
    RAM[0] = 16'h0011; // LW r1, 0(r0)       .........  r1 = Mem[r0 + 0] = Mem[0] = 5                                        0000_00 00_0001_0001        0011        1                               
    RAM[1] = 16'h1021; // LW r2, 4(r0)       .........  r2 = Mem[r0 + 4] = Mem[1] = 7                                        0001_00 00_0010_0001        1021        2
    RAM[2] = 16'h0270; // ADD r3, r1, r2     .........  r3 = r1 + r2 = 5 + 7 = 12                                            0000_00 10_0111_0000        0270        3
    RAM[3] = 16'h2302; // SW r3, 8(r0)       .........  Mem[r0 + 8] = r3 = 12  -> DataMem[4] = 12 (because aluOut[15:1])     0010_00 11_0000_0010        2302        4
    RAM[4] = 16'h0E47; // BEQ r1, r2, LABEL  .........  if (r1 == r2) branch -> r1=5, r2=7 -> not equal, dont branch         0000_11 10_0100_0111        0E47        5
    RAM[5] = 16'h0A4B; // BNE r1, r2, LABEL  .........  if (r1 != r2) branch -> true -> PC jumps to LABEL                    0000_10 10_0100_1011        0A4B        6
    RAM[6] = 16'h03FC; // OR  r3, r3, r3     .........  r3 = r3 | r3 = r3 (no change, still 12) (NOP)                        0000_00 11_1111_1100        03FC        7
    RAM[7] = 16'h01F4; // SUB r3, r3, r1     .........  r3 = 12 - 5 = 7 (LABEL)                                              0000_00 01_1111_0100        01F4        8
end

assign instr = RAM[pc]; // word aligned

endmodule
