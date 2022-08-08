module icg (in,clk,d0,d1,q0,q1);
input in,d0,d1;
input clk;
output q0,q1;

reg q0=0;
reg q1=0;

reg QL;
reg n1;
//reg cgclk;
wire n2,n3,n4,n5,cgclk,clk_n;
wire en;


always@(posedge clk)
begin
n1<=in;
end

assign n2 = ~n1;
assign n3=~n2;
assign n4=~(n1&n3);
assign n5=n2&n3;
assign en = n4|n5;
assign clk_n=~clk;


always@(clk_n,en)
if(clk_n)
QL<=en;
assign cgclk = QL & clk;


always@(posedge cgclk)
begin
q0 <= d0;
q1 <= d1;
end
endmodule
