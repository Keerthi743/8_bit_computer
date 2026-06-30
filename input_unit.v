module input_unit(
    input clk,
    input rst,
    input enter,
    input [7:0] sw,
    output reg [7:0] data_out,
    output reg valid
);

always @(posedge clk)
begin
    if (rst)
    begin
        data_out <= 8'b0;
        valid <= 1'b0;
    end

    else
    begin
        valid <= 1'b0;   

        if (enter)
        begin
            data_out <= sw;
            valid <= 1'b1;
        end
    end
end

endmodule