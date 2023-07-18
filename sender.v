module sender (
    datain,
    start,
    clk,
    rstn,
    tx,
    busy
);

    input     [7:0]      datain;
    input           start;
    input           clk;
    input           rstn;
    output     reg     tx;
    output     reg     busy;
reg [3:0] bit_cnt;
parameter Baut = 434;
reg Go;
reg [8:0]count;
always @(posedge clk) begin
    if(start)
        Go <= 1;
    else if((bit_cnt == 9)&&(count == Baut-1))   Go <= 0;
    else    Go <= Go;
end


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        count <= 0;
    else if(Go)begin
        if(count == Baut-1)
        count <= 0;
        else    count <= count +1;
    end
end


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_cnt <= 0;
    else if(Go)begin
        if((bit_cnt == 9)&&(count == Baut-1))
        bit_cnt <= 0;
        else if(count == Baut-1)
        bit_cnt <= bit_cnt +1;
        else    bit_cnt <= bit_cnt;
    end
    else  bit_cnt <= bit_cnt;
end
reg r_data;
parameter start_bit = 0;
parameter end_bit = 1;
always @(*) begin
    case (bit_cnt)
        0:r_data <= start_bit;
        1:r_data <= datain[7];
        2:r_data <= datain[6];
        3:r_data <= datain[5];
        4:r_data <= datain[4];
        5:r_data <= datain[3];
        6:r_data <= datain[2];
        7:r_data <= datain[1];
        8:r_data <= datain[0];
        9:r_data <= end_bit;
        default: r_data <= end_bit;
    endcase
end
always @(posedge clk) begin
    if(Go)
        tx<= r_data;
    else    tx <= 1;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        busy <= 1;
    else if(start)
        busy <= 0;
    else if(!Go)
        busy <= 1;
end

endmodule //sender
