module MCU_test();

parameter M_PERIOD = 5;
parameter P_PERIOD = 20;

reg Mclk;
reg Pclk;
reg Run;
reg Resetn;

wire Done;
wire [15:0] bus;


wire [3:0] counter;

MCU mcu(Mclk, Pclk,Resetn,Run,Done,bus,counter);

initial begin
    Mclk = 1'b0;
    Pclk = 1'b0;
end


initial begin
    Run = 1'b0;
    Resetn = 1'b0;
    #P_PERIOD Resetn = 1'b1;
end

always begin
    #M_PERIOD Mclk = ~Mclk;
end


initial begin
    #60 Run = 1'b1;
    #P_PERIOD Run = 1'b0;
end

always begin
    #P_PERIOD Pclk = ~Pclk;
end


always @(counter) begin
    if(&counter)
            $finish;
end

endmodule