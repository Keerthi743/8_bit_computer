module binary_to_decimal(
    input [7:0] binary,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

always @(*)
begin
    hundreds = binary / 100;
    tens     = (binary % 100) / 10;
    ones     = binary % 10;
end

endmodule