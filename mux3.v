module mux3 #(parameter busWidth)
            (input [busWidth-1:0] a, b, c,
             input [1:0] selectLine,
             output reg [busWidth-1:0] y);

always @(*)
begin
    case(selectLine)
    2'b00: y = a;
    2'b01: y = b;
    2'b10: y = c;
    default: y = 'bX;
    endcase
end

endmodule