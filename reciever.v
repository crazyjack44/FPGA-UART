module reciever (
    clk,
    rstn,
    Rx_D,
    Data,
    Ready
);

    input clk;
    input rstn;
    input Rx_D;
    output reg [7:0] Data;
    output reg Ready;



//���ؼ��
reg [1:0] register;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        register <= 0;
    else begin
        register[0] <= Rx_D;
        register[1] <= register[0];
    end
end
wire edgepose;
wire edgenege;
assign edgepose = register[0]&~register[1];
assign edgenege = register[1]&~register[0];
reg [8:0]Baut_cnt;
parameter Baut = 434;
reg start_recieve;
reg[3:0]Bit_cnt;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        start_recieve <= 0;
    else if(edgenege)
        start_recieve <= 1;
    else if((Baut_cnt == Baut-1)&&(Bit_cnt == 9))
        start_recieve <= 0;
    else    start_recieve  <= start_recieve;
end


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        Baut_cnt <= 0;
    else if(!start_recieve)
        Baut_cnt <= 0;
    else if(Baut_cnt == Baut-1)
        Baut_cnt <= 0;
    else    Baut_cnt<= Baut_cnt +1;
end


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        Bit_cnt <= 0;
    else if(!start_recieve)
        Bit_cnt <= 0;
    else if((Baut_cnt == Baut-1)&&(Bit_cnt == 9))
        Bit_cnt <= 0;
    else if(Baut_cnt == Baut-1)
        Bit_cnt <=Bit_cnt +1;
    else    Bit_cnt <= Bit_cnt;
end



reg data_stream;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        data_stream <= 0;
    else if(start_recieve)begin
        if(Baut_cnt == Baut/2)
            data_stream <= Rx_D;
        else    data_stream <= data_stream ;
    end
    else    data_stream <= data_stream;
end
reg[7:0]r_Data;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        r_Data <= 0;
        else if(start_recieve)begin
        if(Baut_cnt == Baut/2+1)begin
        case (Bit_cnt)
    1:r_Data[7] <= data_stream;
    2:r_Data[6] <= data_stream;
    3:r_Data[5] <= data_stream;
    4:r_Data[4] <= data_stream;
    5:r_Data[3] <= data_stream;
    6:r_Data[2] <= data_stream;
    7:r_Data[1] <= data_stream;
    8:r_Data[0] <= data_stream;
    default : r_Data <= r_Data;
    endcase
        end
    else    r_Data <= r_Data;
        end
end
reg r_ready;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        r_ready <= 0;
    else if((Baut_cnt == Baut-1)&&(Bit_cnt==9))
        r_ready <= 1;
    else   r_ready <= 0;
end

always @(posedge clk) begin
    if(r_ready)
        Data <= r_Data;
    Ready <= r_ready;
end

endmodule //reciever
