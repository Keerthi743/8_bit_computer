module control_unit(
    input clk,
    input reset,

    input LDA,
    input STA,
    input ADD,
    input SUB,
    input AND,
    input OR,
    input NOT,
    input OUT,

    output reg PC_out,
    output reg PC_load,

    output reg MAR_load,

    output reg RAM_read,
    output reg RAM_write,

    output reg IR_load,

    output reg ACC_load,
    output reg ACC_out,

    output reg B_load,

    output reg [2:0] alu_sel,

    output reg FLAG_load,

    output reg OUT_enable
);

reg [2:0] state;

always @(posedge clk) begin
    if(reset)
        state <= 3'b000;
    else if(state == 3'b101)
        state <= 3'b000;
    else
        state <= state + 1'b1;
end


always @(*) begin

    // ---------------- DEFAULT VALUES ----------------
    PC_out     = 0;
    PC_load    = 0;
    MAR_load   = 0;

    RAM_read   = 0;
    RAM_write  = 0;

    IR_load    = 0;

    ACC_load   = 0;
    ACC_out    = 0;

    B_load     = 0;

    alu_sel    = 3'b000;   // IMPORTANT default

    FLAG_load  = 0;

    OUT_enable = 0;

    // ---------------- FSM ----------------
    case(state)

    // T0: PC - MAR
    3'b000: begin
        PC_out   = 1;
        MAR_load = 1;
    end

    // T1: RAM - IR
    3'b001: begin
        RAM_read = 1;
        IR_load  = 1;
    end

    // T2: PC increment
    3'b010: begin
        PC_load = 1;
    end

    // T3: Decode stage
    3'b011: begin
        if(LDA || STA || ADD || SUB || AND || OR)
            MAR_load = 1;

        else if(NOT) begin
            alu_sel   = 3'b100;
            ACC_load  = 1;
            FLAG_load = 1;
        end

        else if(OUT) begin
            ACC_out    = 1;
            OUT_enable = 1;
        end
    end

    // T4: Memory access
    3'b100: begin

        if(LDA) begin
            RAM_read  = 1;
            ACC_load  = 1;
            FLAG_load = 1;
        end

        else if(STA) begin
            RAM_write = 1;
            ACC_out   = 1;
        end

        else if(ADD || SUB || AND || OR) begin
            RAM_read = 1;
            B_load   = 1;
        end
    end

    // T5: Execute ALU operations
    3'b101: begin

        if(ADD) begin
            alu_sel   = 3'b000;
            ACC_load  = 1;
            FLAG_load = 1;
        end

        else if(SUB) begin
            alu_sel   = 3'b001;
            ACC_load  = 1;
            FLAG_load = 1;
        end

        else if(AND) begin
            alu_sel   = 3'b010;
            ACC_load  = 1;
            FLAG_load = 1;
        end

        else if(OR) begin
            alu_sel   = 3'b011;
            ACC_load  = 1;
            FLAG_load = 1;
        end
    end

    endcase

end

endmodule