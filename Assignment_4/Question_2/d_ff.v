module d_ff(q,d,clk,reset,we);

input clk,reset,d,we;
output reg q;

always @(posedge clk) begin
    if(reset)q<=0;
    else if(we)q<=d;
    else q<=q;
end

endmodule 