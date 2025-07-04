module t_ff(q,t,clk,reset);

input t,clk,reset;
output reg q;

always @(posedge clk)begin
if(reset)q <= 0;
else if(t)q<=(~q);
else q <= q;
end

endmodule























// input t,clk,reset;
// output reg q;

// always @(posedge clk) begin
//     if(reset)q<=0;
//     else if(t)q<=~q;
//     else q<=q;