`include "full_subtractor.v"

module ripple_subtractor(a,b,ans,borrow);

parameter W = 32;

input [W-1:0] a,b;
output [W-1:0] ans;
output borrow;

wire [W : 0] temp;
assign temp[0] = 1'b0;

genvar i;

generate
    for(i =0;i<W;i = i + 1)begin
        full_subtractor ss(a[i],b[i],temp[i],ans[i],temp[i+1]);
    end
endgenerate

assign borrow = temp[W];

endmodule





// wire [W:0] temp;
// assign temp[0] = 1'b0;

// genvar i;

// generate
//     for(i = 0;i<W;i = i + 1)begin
//         full_subtractor ss(a[i],b[i],temp[i],ans[i],temp[i+1]);
//     end
// endgenerate

// assign borrow = temp[W];