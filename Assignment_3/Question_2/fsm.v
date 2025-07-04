module fsm(clk,reset,bit,out,ns,ps);

input clk,reset,bit;
output reg [2:0] ns,ps;
output reg out;

parameter a = 3'b000;
parameter b = 3'b001;
parameter c = 3'b011;
parameter d = 3'b010;
parameter e = 3'b110;
parameter f = 3'b100;
parameter g = 3'b101;

always @(posedge clk)begin
    if(reset)ps <= a;
    else ps<= ns;
end

always @(bit,ps)begin
    case (ps) 
    a : begin
        if(bit == 1'b1)ns<=b;
        else ns<=a;
    end
    b : begin
        if(bit == 1'b1)ns<=c;
        else ns<=d;
    end
    c : begin
        if(bit == 1'b1)ns<=c;
        else ns<=e;
    end
    d : begin
        if(bit == 1'b1)ns<=g;
        else ns<=f;
    end
    e : begin
        if(bit == 1'b1)ns<=g;
        else ns<=a;
    end
    f : begin
        if(bit == 1'b1)ns<=a;
        else ns<=a;
    end
    g : begin
        if(bit == 1'b1)ns<=c;
        else ns<=a;
    end
    default : ns<=a;
    endcase
end

always @(ps,bit)begin
    case (ps)
    e : if(bit == 1'b0)out<=1;
    f : if(bit == 1'b1)out<=1;
    g : if(bit == 1'b0)out<=1;
    default : out<=0;
    endcase
end


endmodule 
































//input clk,reset,bit;
// output reg out;
// output reg [2:0] ps,ns;

// parameter a = 3'b000;
// parameter b = 3'b001;
// parameter c = 3'b011;
// parameter d = 3'b010;
// parameter e = 3'b110;
// parameter f = 3'b101;
// parameter g = 3'b100;

// always @(posedge clk) begin
//     if(reset)ps<=a;
//     else ps<=ns;
// end

// always @(ps,bit)begin
//     case(ps)
//     a : begin
//         if(bit == 1'b0)ns=a;
//         else if(bit == 1'b1) ns= b;   
//         else ns<=a;
//     end
//     b : begin
//         if(bit == 1'b0)ns<=d;
//         else if(bit == 1'b1) ns<= c;  
//         else ns<=a; 
//     end
//     c : begin
//         if(bit == 1'b0)ns<=e;
//         else if(bit == 1'b1) ns<= b;   
//         else ns<=a;
//     end
//     d : begin
//         if(bit == 1'b0)ns<=g;
//         else if(bit == 1'b1) ns<= f;   
//         else ns<=a;
//     end
//     e : begin
//         if(bit == 1'b0)ns<=a;
//         else if(bit == 1'b1)ns<= f;   
//         else ns<=a;
//     end
//     f : begin
//         if(bit == 1'b0)ns<=a;
//         else if(bit == 1'b1)ns<= c;   
//         else ns<=a;
//     end
//     g : begin
//         if(bit == 1'b0)ns<=a;
//         else if(bit == 1'b1)ns<= a;   
//         else ns<=a;
//     end
//     default : ns<=a;
//     endcase
// end

// always @(ps,bit)begin
//     case(ps)
//     e : begin
//             if(bit == 1'b0)out<=1;
//     end
//     g : begin
//         if(bit == 1'b1)out<=1;
//     end
//     f : begin
//         if(bit == 1'b0)out<=1;
//     end
//     default : out<=0;
//     endcase 
// end