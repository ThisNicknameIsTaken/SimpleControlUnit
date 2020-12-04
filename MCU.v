module MCU(Mclk, Pclk, Resetn, Run, Done, bus);

input Mclk;
input Pclk;
input reg Run;

output [15:0] bus;
output wire Done;

wire [15:0] D;

reg  [3:0] counter;
rom  memory(Mclk, counter, D);
SCU scu(Pclk, Run, Resetn ,D ,Done, bus);

always @(posedge Mclk, negedge Resetn) begin
    if(~Resetn)
        counter <= 4'b0000;

always @(posedge Mclk, posedge Run) begin
    if(Run) begin
        Run <= 1'b0;
        counter <= counter + 1'b0;
    end
end


always @(posedge Done)
    Run <= 1'b1;

endmodule;