`timescale 1ns/1ns

module reciever_tb (
);
    reg clk;
    reg rstn;
    reg Rx_D;
    wire [7:0]Data;
    wire Ready;
reciever reciever(
    clk,
    rstn,
    Rx_D,
    Data,
    Ready
);

initial clk = 1;
always#10 clk = ~clk;
initial begin 
rstn = 0;
Rx_D = 1;
#201;
rstn = 1;
out();

end


task out;
    begin
    Rx_D = 1;
    #9000;
    Rx_D = 0;
    #8680;
    Rx_D = 0;
    #8680;
    Rx_D = 0;
    #8680;   
    Rx_D = 0;
    #8680;
    Rx_D = 1;
    #8680;
    Rx_D = 0;
    #8680;
    Rx_D = 0;
    #8680;   
    Rx_D = 0;
    #8680;
    Rx_D = 1;
    #8680;   
    Rx_D = 1;
 
    end  
endtask

endmodule //reciever_tb
