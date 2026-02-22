module dataMemory(input clk, we, input [15:0] aluOut, WD, output [15:0] readData);

reg [15:0] RAM[63:0];
assign readData = RAM[aluOut[15:1]]; // word aligned

initial 
begin
    RAM[0] = 16'd5;
    RAM[1] = 16'd7;
end

//write new data into address
always @(posedge clk)
begin
if (we)
RAM[aluOut[15:1]] <= WD;
end

endmodule