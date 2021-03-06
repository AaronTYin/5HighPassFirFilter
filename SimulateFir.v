/*FirSim*/
`timescale 1ns/1ns  
`define clock 50 

module FirSim; 

reg clk,reset_n; 
reg [15:0]x_in;  
reg [15:0]data_mem[0:15]; 
integer i; 
wire [23:0]y_out; 

always #`clock clk=~clk;
initial 
begin 
	clk=0; 
	reset_n=1; 
	#20 reset_n=0; 
	#10 reset_n=1;  
end

initial  
begin   
	$readmemh("tir.txt",data_mem); 
end
 
always @(posedge clk or negedge reset_n) 
begin  
if(!reset_n) 
	begin 
	x_in<=15'b0;
	i<=0; 
	end  
else if(i<=13) 
	begin 
	x_in<=data_mem[i];  
	i<=i+1; 
	end  
else 
	begin  
	x_in<=data_mem[i]; 
	i<=0; 
	end  
end  

Fir fir(.reset_n(reset_n),.clk(clk),.x_in(x_in),.y_out(y_out));

endmodule