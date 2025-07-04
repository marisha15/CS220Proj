module adder(a, b, out);

    input [31:0] a, b;
    output reg [31:0] out;

    wire [7:0] expa, expb;
    wire [23:0] fraca, fracb;
    wire signa, signb;

    assign signa = a[31];
    assign signb = b[31];

    assign fraca = {1'b1, a[22: 0]};
    assign fracb = {1'b1, b[22:0]};

    integer i;

    assign expa = a[30: 23];
    assign expb = b[30: 23];

    reg [23:0] shifted_a, shifted_b;

    reg [24:0] sum, new_sum;
    reg [7:0] exponent, new_exponent;

    always @(*) begin
        shifted_a = 0;
        shifted_b = 0;
        if(expb <= expa) begin
           shifted_a <= fraca;
//           shifted_b <= fracb;
           shifted_b <= (fracb >> (expa - expb));
        end
        else begin
            shifted_b <= fracb;
            shifted_a <= (fraca >> (expb - expa));
        end
    end

    always @(*) begin
        if(expa <= expb) begin
            exponent <= expb;
        end else begin
            exponent <= expa;
        end
    end

    wire is_same_sign;

    always @(*) begin
        if(signa ^ signb) begin
        //different sign
            if(shifted_a >= shifted_b) begin
                out[31] <= signa;
                sum <= shifted_a - shifted_b;
            end else begin
                out[31] <= signb;
                sum <= shifted_b - shifted_a;
            end
        end else begin
        //same sign
            out[31] <= signa;
            sum <= shifted_a + shifted_b;
        end
     end

    integer j;

    always @(*) begin
        // out[22:0] = {23{1'b0}};
        new_sum = 0;
        new_exponent = exponent;
        for(i = 0; i <= 24; i = i + 1) begin
            if(sum[i]) begin
                for(j = i; j >= 0; j = j - 1) begin
                    new_sum[24 - i + j] <= sum[j];
                end
                new_exponent <= exponent - (24 - i) + 1;
            end
        end
    end

    always @(*) begin
        out[22:0] <= new_sum[23:1];
        out[30:23] <= new_exponent;
    end

endmodule