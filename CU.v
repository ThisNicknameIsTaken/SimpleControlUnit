module CU(clk, Run, Resetn, IR, IRin, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, Ain, Gin, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, DINout, AddSub, enableALU, Done);


parameter [2:0]  idle = 0, load_commRand = 1, move = 2, movei = 3, ar_op_load_op1 = 4, ar_op_mov_res_done = 5; 
parameter [2:0]  mv = 0, mvi = 1, add = 2, sub = 3; 

input      clk, Run, Resetn;
input      [8:0] IR;
output     R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
output reg Done;   //add = 0, sub = 1;
output reg Gout, DINout, Ain, Gin, IRin;
output AddSub;
output  reg enableALU;

reg [7:0] mul_control;     //choose from which register read data
reg [7:0] reg_control;     //choose to which register write data

reg  [2:0] state;

reg [2:0] command;
reg [2:0] op1, op2;

wire [7:0] op1_decoder_out;     //decodes input operand1 and operand2 into one hot 
wire [7:0] op2_decoder_out;
decoder op1_decoder(op1,op1_decoder_out);
decoder op2_decoder(op2,op2_decoder_out);


assign R0out  =  mul_control[0];
assign R1out  =  mul_control[1];
assign R2out  =  mul_control[2];
assign R3out  =  mul_control[3];
assign R4out  =  mul_control[4];
assign R5out  =  mul_control[5];
assign R6out  =  mul_control[6];
assign R7out  =  mul_control[7];


assign R0in   =  reg_control[0];
assign R1in   =  reg_control[1];
assign R2in   =  reg_control[2];
assign R3in   =  reg_control[3];
assign R4in   =  reg_control[4];
assign R5in   =  reg_control[5];
assign R6in   =  reg_control[6];
assign R7in   =  reg_control[7];

assign AddSub = command[1] & command[0];    //decodes wheter it`s adding or substraction operation

always @(posedge clk, negedge Resetn) begin
    if(~Resetn) begin
        IRin <= 1'b1;
        state <= idle;
    end
end


always

always @(posedge clk, posedge Run) begin
    if (Run && state == idle) begin
        state <= load_command;     
    end
end


always @(posedge clk) begin
     case (state)
        idle: begin
                Done <= 1'b0;
                mul_control <= 8'b0000_0000;
                reg_control <= 8'b0000_0000;
                DINout <= 1'b0;
                Gout <= 1'b0;
                Gin <= 1'b0;
                Ain <= 1'b0;
                enableALU < 1'b0;
                
        end

        load_command: begin
            IRin <= 1'b0;
            command <= IR[8:6];
            op1     <= IR[5:3];
            op2     <= IR[2:0];
            
            case (command)
                mv:  state <= move;
                mvi: state <= movei;
                add: state <= ar_op_load_op1;
                sub: state <= ar_op_load_op1;
                default: state <= idle;
            endcase
        end

        move: begin
                reg_control <= op1_decoder_out;     // allows to write date to this reg
                mul_control <= op2_decoder_out;     // allows to read data from this reg
                Done <= 1'b1;
                state <= idle;
        end

        movei: begin
                reg_control <= op1_decoder_out;     // allows to write date to this reg
                DINout <= 1'b1;
                Done <= 1'b1;
                state <= idle;
        end

        ar_op_load_op1: begin
                Ain <= 1'b1;
                mul_control <= op1_decoder_out;     // allows to read data from this reg
                state <= ar_op_load_op2;
        end

        
        ar_op_load_op2: begin
                Ain <= 1'b0;
                mul_control <= op2_decoder_out;     // allows to read data from this reg
                Gin <= 1'b1;
                enableALU <= 1'b1;
                state <= ar_op_mov_res_done;
        end

        ar_op_mov_res_done: begin
                Gin <= 1'b0;
                Gout <= 1'b1;
                mul_control <= 8'b0000_0000;
                reg_control <= op1_decoder_out;
                Done <= 1'b1;
                state <= idle;
        end

    endcase
end


endmodule