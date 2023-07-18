module rx232top (
    clk,
    rstn,
    tx,
    Rx_D,
    busy
);

input clk;
input rstn;
input Rx_D;
output tx;
output busy;

wire [7:0] data;
wire start;

reciever reciever(
    .clk(clk),
    .rstn(rstn),
    .Rx_D(Rx_D),
    .Data(data),
    .Ready(start)
);

sender sender(
    .datain(data),
    .start(start),
    .clk(clk),
    .rstn(rstn),
    .tx(tx),
    .busy(busy)
);

endmodule //rx232top
