module flag_reg(clk,reset,load,alu_result,carry_in,zero_flag,carry_flag);

input clk;
input reset;
input load;
input [7:0] alu_result;
input carry_in;
output reg zero_flag;
output reg carry_flag;

always @(posedge clk)
begin
    if(reset)
    begin
        zero_flag  <= 1'b0;
        carry_flag <= 1'b0;
    end
    
    else if(load)
    begin

        if(alu_result == 8'b0)
            zero_flag <= 1'b1;
        else
            zero_flag <= 1'b0;

        carry_flag <= carry_in;
    end
end

endmodule