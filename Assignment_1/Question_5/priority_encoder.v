module priority_encoder(in,out,valid);

input [7:0] in;
output reg [2:0] out;
output reg valid;

integer i;
always @(*)begin
    out <= 0;
    valid <= 0;
    for(i = 0;i<8;i = i + 1)begin
        if(in[i] == 1'b1)begin
            valid <= 1;
            out <= i; 
        end
    end

end

endmodule


























// input [7:0] in;
// output reg valid;
// output reg [2:0] out;

// integer i;
// always @(*)begin
//     valid<=0;
//     out<=0;
//     for(i = 0;i<9;i = i + 1)begin
//         if(in[i] == 1)begin
//             valid <= 1;
//             out <= i;
//         end
//     end
// end