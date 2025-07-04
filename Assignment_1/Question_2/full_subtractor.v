module full_subtractor(a,b,bin,d,bout);

input a,b,bin;
output d,bout;

// wire temp,not_a,temp2,temp3,temp4;

// xor(temp,a,b);
// xor(d,temp,bin);

// not(not_a,a);

// and(temp2,not_a,bin);
// and(temp3,not_a,b);
// and(temp4,b,bin);

// or(bout,temp2,temp3,temp4);
assign d = a^b^bin;

assign bout = bin&(~(a^b)) | (~a)&b;

endmodule