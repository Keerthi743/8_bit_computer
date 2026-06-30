module bus(
    input  [7:0] pc_out,
    input  [7:0] acc_out,
    input  [7:0] regb_out,
    input  [7:0] alu_out,
    input  [7:0] ram_out,
    input  [7:0] ir_out,

    input  [2:0] bus_sel,

    output reg [7:0] bus_out
);

always @(*) begin
    case(bus_sel)
        3'b000: bus_out = pc_out;
        3'b001: bus_out = acc_out;
        3'b010: bus_out = regb_out;
        3'b011: bus_out = alu_out;
        3'b100: bus_out = ram_out;
        3'b101: bus_out = ir_out;
        default: bus_out = 8'b0;
    endcase
end

endmodule