module MCU(Mclk, Pclk, Resetn, Run, Done, bus, regout);

input Mclk;
input Pclk;
input Run;
input Resetn;

reg run_r;

output [3:0] regout;

output [15:0] bus;
output wire Done;

wire [15:0] D;

reg  [3:0] counter;


assign regout = counter;

rom  memory(Mclk, counter, D);
SCU scu(Pclk, run_r, Resetn ,D ,Done, bus);

always @(posedge Mclk, negedge Resetn) begin
    if(~Resetn)
        counter <= 4'b0000;
end

always @(negedge run_r, negedge Done) begin
        counter <= counter + 1'b1;
end


always @(posedge Pclk) begin
    if(~run_r)
        run_r <= Run | Done;
    else
        run_r <= 1'b0;
end

endmodule