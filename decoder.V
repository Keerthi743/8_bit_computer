module decoder (
    input [3:0] opcode,
    output reg LDA,
    output reg STA,
    output reg ADD,
    output reg SUB,
    output reg AND_OP,
    output reg OR_OP,
    output reg NOT_OP,
    output reg OUT
);

always @(*)
   begin 
      LDA    = 0;
      STA    = 0;
      ADD    = 0;
      SUB    = 0;
      AND_OP = 0;
      OR_OP  = 0;
      NOT_OP = 0;
      OUT    = 0;

      case(opcode)

        4'b0000: LDA    = 1;
        4'b0001: STA    = 1;
        4'b0010: ADD    = 1;
        4'b0011: SUB    = 1;
        4'b0100: AND_OP = 1;
        4'b0101: OR_OP  = 1;
        4'b0110: NOT_OP = 1;
        4'b0111: OUT    = 1;
        default:           ;

      endcase
end

endmodule


