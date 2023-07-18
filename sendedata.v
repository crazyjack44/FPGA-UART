module senddata (
    clk,
    rstn,
    start,
    data
);

    input clk;
    input rstn;
    output reg start;
    output reg [7:0] data;

parameter Baut = 434;
reg [8:0]count;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        count <= 0;
    else if(count == Baut-1)
        count <= 0;
        else    count <= count +1;
end
reg [3:0] bit_cnt;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_cnt <= 0;
    else if((bit_cnt == 9)&&(count == Baut-1))
        bit_cnt <= 0;
    else if(count == Baut-1)
        bit_cnt <= bit_cnt +1;
    else    bit_cnt <= bit_cnt;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        data <= 0;
    else if(start) data <= data +1;
    else    data <= data;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        start <= 0;
    else if((bit_cnt == 9)&&(count == Baut-1))
        start <= 1;
    else    start <= 0;
end
endmodule //senddata
