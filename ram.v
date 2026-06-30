module ram (
    input clk,
    input we,
    input [3:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] mem [15:0];

initial begin
    mem[0] = 8'b00000001; // LDA 1
    mem[1] = 8'b00100010; // ADD 2
    mem[2] = 8'b01110000; // OUT
    mem[3] = 8'b00000000; // data
    mem[4] = 8'd5;        // value
    mem[5] = 8'd3;        // value
end

always @(posedge clk)
begin
    if (we)
        mem[addr] <= data_in;

    data_out <= mem[addr];
end

endmodule