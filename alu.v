module alu(
    input [7:0] A, B,
    input [2:0] SEL,
    output reg [7:0] RES,
    output reg carry,
    output reg zf
);

always @(*)
begin

    RES   = 8'b0;
    carry = 0;

    case(SEL)
        3'b000: {carry, RES} = A + B;
        3'b001: RES = A - B;
        3'b010: RES = A & B;
        3'b011: RES = A | B;
        3'b100: RES = ~A;
        default: RES = 8'b0;
    endcase

    if (RES == 8'b0)
        zf = 1'b1;
    else
        zf = 1'b0;
end

endmodule