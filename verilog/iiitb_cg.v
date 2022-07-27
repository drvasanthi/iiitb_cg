module iiitb_cg(d,en,clk,gclk,q);
input d,en,clk;
output q, gclk;
reg q=0;
wire a1;
and (a1,en,clk);
assign gclk=a1;
always@(posedge gclk)
begin
q=d;
end
endmodule
