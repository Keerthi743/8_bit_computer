module output_unit(

    input clk,
    input rst,
    input load,
    input [7:0] bus_in,

    output [6:0] seg_h,
    output [6:0] seg_t,
    output [6:0] seg_o
);

wire [7:0] output_data;

wire [3:0] hundreds;
wire [3:0] tens;
wire [3:0] ones;

output_register U1(
    .clk(clk),
    .rst(rst),
    .load(load),
    .bus_in(bus_in),
    .out_data(output_data)
);

binary_to_decimal BCD(
    .binary(output_data),
    .hundreds(hundreds),
    .tens(tens),
    .ones(ones)
);

seven_segment_decoder HUND(
    .digit(hundreds),
    .seg(seg_h)
);

seven_segment_decoder TEN(
    .digit(tens),
    .seg(seg_t)
);

seven_segment_decoder ONE(
    .digit(ones),
    .seg(seg_o)
);

endmodule