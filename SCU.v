module SCU(clk, Run, Resetn, Din, Done, bus) begin
    
input clk, Run, Resetn;
input [15:0] Din;
output Done;    

wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, Ain, Gin;
wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, DINout;
wire AddSub;

wire [15:0] mux_in[9];
reg  [9:0]  mux_control;
reg  [15:0] bus;

reg [15:0] alu;

reg enableALU;

Register R0(clk, R0in, bus, mux_in[0]);
Register R1(clk, R1in, bus, mux_in[1]);
Register R2(clk, R2in, bus, mux_in[2]);
Register R3(clk, R3in, bus, mux_in[3]);
Register R4(clk, R4in, bus, mux_in[4]);
Register R5(clk, R5in, bus, mux_in[5]);
Register R6(clk, R6in, bus, mux_in[6]);
Register R7(clk, R7in, bus, mux_in[7]);
Register A (clk, Ain,  bus, alu);
Register G (clk, Gin,  alu, mux_in[8]);



wire [8:0]  IR;
wire IRin;
assign IR = Din[8:0];



CU control_unit(.clk(clk),
                .Run(Run),
                .Resetn(Resetn),
                .IR(IR), 
                .IRin(IRin)
                .R0in(R0in),
                .R1in(R1in),
                .R2in(R2in),
                .R3in(R3in),
                .R4in(R4in),
                .R5in(R5in),
                .R6in(R6in),
                .R7in(R7in),
                .Ain(Ain),
                .Gin(Gin),
                .R0out(R0out),
                .R1out(R1out),
                .R2out(R2out),
                .R3out(R3out),
                .R4out(R4out),
                .R5out(R5out),
                .R6out(R6out),
                .R7out(R7out),
                .Gout(Gout),
                .DINout(DINout),
                .AddSub(AddSub),
                .enableALU(enableALU),
                .Done(Done)
                );
    


always @(posedge clk)
    mux_control <= {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Din};

always (enableALU) begin
    if(enableALU) begin
        if(AddSub == 1'b0)
            alu <= alu + bus;
        else 
            alu <= alu - bus;
    end
end

always (mux_control) begin
    case (mux_control)
        10'b00_0000_0001: bus <= mux_in[0];
        10'b00_0000_0010: bus <= mux_in[1];
        10'b00_0000_0100: bus <= mux_in[2];
        10'b00_0000_1000: bus <= mux_in[3];
        10'b00_0001_0000: bus <= mux_in[4];
        10'b00_0010_0000: bus <= mux_in[5];
        10'b00_0100_0000: bus <= mux_in[6];
        10'b00_1000_0000: bus <= mux_in[7];
        10'b01_0000_0000: bus <= mux_in[8];
        10'b10_0000_0000: bus <= Din;
    endcase
end

endmodule