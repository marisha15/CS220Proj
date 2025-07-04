`include "d_ff.v"

module d_ff32(q,d,clk,reset,we);

input reset,clk,we;
input [31:0] d;
output [31:0] q;

genvar i;
generate
    for(i =0;i<32;i = i + 1)begin
        d_ff ss(q[i],d[i],clk,reset,we);
    end
endgenerate

endmodule 































// input reset,clk,we;
// input [31:0] d;
// output [31:0]q;

// genvar i;
// generate
//     for(i = 0;i<32;i = i + 1)begin
//         d_ff ss(q[i],d[i],clk,reset,we);
//     end
// endgenerate