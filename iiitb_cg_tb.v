module iiitb_cg_tb();
	reg d,en,clk;
	wire q,gclk;
	iiitb_cg test(d,en,clk,q,gclk);
	initial
	begin
	d=0;
	en=0;
	clk=0;
	$dumpfile("test.vcd");
	$dumpvars(1);
	#200 $finish;
	end
	always #5 d<=~d;
	always #12 en<=~en;
	always #3 clk=~clk;
	endmodule
