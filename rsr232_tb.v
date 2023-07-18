`timescale 1ns/1ns
module rs232_tb (
);
reg clk;
reg rstn;
wire tx;
wire busy;
rx232top rx232top(
    clk,
    rstn,
    tx,
    busy
);

initial clk =1;
always#10 clk = ~clk;
initial begin 
rstn = 0;
#201;
rstn = 1;
end
endmodule //rs232_tb
