module mux2 #(parameter busWidth)
            (input [busWidth-1:0] a, b, 
             input selectLine,
             output [busWidth-1:0] y);

assign y = selectLine ? a : b;

endmodule