module rom(clk, addr, data);
input   clk;
input   wire [3:0] addr;
output  reg  [15:0] data;

reg [15:0] memory[0:15];

initial begin
    $readmemb("memory_data.txt", memory);
end

always @(posedge clk) begin
    data <= memory[addr];
end

endmodule