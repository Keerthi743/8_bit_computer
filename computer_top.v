module computer_top(
    input clk,
    input rst,

    output [6:0] seg_h,
    output [6:0] seg_t,
    output [6:0] seg_o
);


//CONTROL WIRES 

wire PC_out;
wire PC_load;

wire MAR_load;

wire RAM_read;
wire RAM_write;

wire IR_load;

wire ACC_load;
wire ACC_out;

wire B_load;

wire [2:0] alu_sel;

wire FLAG_load;

wire OUT_enable;



//  REGISTERS  

wire [3:0] opcode;
wire [3:0] operand;

wire [3:0] pc_value;
wire [3:0] mar_value;



//  DECODER  

wire LDA;
wire STA;
wire ADD;
wire SUB;
wire AND_OP;
wire OR_OP;
wire NOT_OP;
wire OUT_OP;


decoder DECODER(
    .opcode(opcode),

    .LDA(LDA),
    .STA(STA),
    .ADD(ADD),
    .SUB(SUB),
    .AND_OP(AND_OP),
    .OR_OP(OR_OP),
    .NOT_OP(NOT_OP),
    .OUT(OUT_OP)
);



//  CONTROL UNIT 

control_unit CU(

    .clk(clk),
    .reset(rst),

    .LDA(LDA),
    .STA(STA),
    .ADD(ADD),
    .SUB(SUB),
    .AND(AND_OP),
    .OR(OR_OP),
    .NOT(NOT_OP),
    .OUT(OUT_OP),


    .PC_out(PC_out),
    .PC_load(PC_load),

    .MAR_load(MAR_load),

    .RAM_read(RAM_read),
    .RAM_write(RAM_write),

    .IR_load(IR_load),

    .ACC_load(ACC_load),
    .ACC_out(ACC_out),

    .B_load(B_load),

    .alu_sel(alu_sel),

    .FLAG_load(FLAG_load),

    .OUT_enable(OUT_enable)

);



//  PROGRAM COUNTER 


program_counter PC(

    .clk(clk),
    .rst(rst),

    .enable(PC_out),
    .load(PC_load),

    .pc_out(pc_value)

);



//  MAR  


mar MAR(

    .clk(clk),
    .rst(rst),

    .addr(pc_value),

    .load(MAR_load),

    .out(mar_value)

);



//  RAM 


wire [7:0] ram_data;


ram RAM(

    .clk(clk),

    .we(RAM_write),

    .addr(mar_value),

    .data_in(acc_value),

    .data_out(ram_data)

);



//  INSTRUCTION REGISTER 


wire [7:0] ir_value;


ins_reg IR(

    .clk(clk),

    .rst(rst),

    .data(ram_data),

    .load(IR_load),

    .out(ir_value),

    .opcode(opcode),

    .operand(operand)

);



//  ACCUMULATOR


wire [7:0] acc_value;


acc ACC(

    .clk(clk),

    .rst(rst),

    .A(alu_result),

    .LOAD(ACC_load),

    .OUT(acc_value)

);



//  B REGISTER 

wire [7:0] b_value;


reg_b BREG(

    .clk(clk),

    .rst(rst),

    .load(B_load),

    .b(ram_data),

    .out(b_value)

);




//  ALU 


wire [7:0] alu_result;

wire carry;
wire zero;


alu ALU(

    .A(acc_value),

    .B(b_value),

    .SEL(alu_sel),

    .RES(alu_result),

    .carry(carry),

    .zf(zero)

);



//  OUTPUT 


output_unit OUTPUT(

    .clk(clk),

    .rst(rst),

    .load(OUT_enable),

    .bus_in(acc_value),

    .seg_h(seg_h),

    .seg_t(seg_t),

    .seg_o(seg_o)

);


endmodule