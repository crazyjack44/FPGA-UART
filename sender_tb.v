`timescale 1ns/1ns
module sender_tb ();

    reg [7:0]     datain;
    reg           start;
    reg           clk;
    reg           rstn;
    wire          tx;
    wire          busy;


sender sender(
    datain,
    start,
    clk,
    rstn,
    tx,
    busy
);
initial clk = 1;
always #10 clk = ~clk;
initial begin
    rstn = 0;
    start = 0;
    #201;
    rstn = 1;
    #200;
    start = 1;
    datain = 8'h4A;
    #40;
    start = 0;
    
end
endmodule //sender_tb
