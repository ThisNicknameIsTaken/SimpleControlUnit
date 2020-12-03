module rom(clk, addr, data);
input   clk;
input   wire [7:0] addr;
output  reg  [15:0] data;

reg [15:0] memory[0:255];

initial begin
    $readmemb("memory_data.txt", memory);
end

always @(posedge clk) begin
    data <= memory[addr];
end

endmodule;