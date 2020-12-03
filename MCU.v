module MCU(Mclk, Pclk, Resetn, Run, Done, bus);

input Mclk;
input Pclk;
input Run;

output [15:0] bus;
output wire Done;

wire [15:0] D;

reg  [7:0] counter;
rom  memory(Mclk, counter, D);
SCU scu(Pclk, Run, Resetn ,D ,Done, bus);
endmodule;