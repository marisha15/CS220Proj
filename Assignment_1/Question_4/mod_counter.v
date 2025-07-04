module counter(count,clk,reset);

input clk,reset;
output reg [3:0]count;

always @(posedge clk)begin

    if(reset)count<=0;
    else if(count == 4'd9)count <= 0;
    else count <= count + 1;
end


endmodule





























// always @(posedge clk) begin
//     if(reset)count<=0;
//     else if (count == 9)count<=0;
//     else count<=count+1;
// end