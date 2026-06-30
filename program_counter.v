module program_counter (
    input clk,
    input rst,
    input enable,        
    input load,          
    output reg [3:0] pc_out
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        pc_out <= 4'b0;

    else if (load)
        pc_out <= pc_out + 1'b1;
    else if (enable)
	pc_out <= pc_out;
end

endmodule