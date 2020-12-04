module Register(clk, we, in, out);

input clk, we;
input [15:0] in;
output [15:0] out;

reg [15:0] data;

assign out = data;

always @(posedge clk) begin
    if(we)
        data <= in;
end

endmodule