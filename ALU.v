module ALU (
    input clk,
    input rst,
    input [3:0] ALUop,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow,
    output reg Negative
);

    reg [32:0] tmp_result;  // 1-bit extra for carry

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Result   <= 0;
            Zero     <= 0;
            Carry    <= 0;
            Overflow <= 0;
            Negative <= 0;
        end else begin
            case (ALUop)
                4'b0000: begin // ADD
                    tmp_result = {1'b0, A} + {1'b0, B};
                    Result     <= tmp_result[31:0];
                    Carry      <= tmp_result[32];
                    Overflow   <= (A[31] == B[31]) && (tmp_result[31] != A[31]);
                end
                4'b0001: begin // SUB
                    tmp_result = {1'b0, A} - {1'b0, B};
                    Result     <= tmp_result[31:0];
                    Carry      <= tmp_result[32];
                    Overflow   <= (A[31] != B[31]) && (tmp_result[31] != A[31]);
                end
                4'b0010: Result <= A & B;       // AND
                4'b0011: Result <= A | B;       // OR
                4'b0100: Result <= A ^ B;       // XOR
                4'b0101: Result <= ~(A | B);    // NOR
                4'b0110: Result <= ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
                4'b0111: Result <= A << B[4:0]; // SLL
                4'b1000: Result <= A >> B[4:0]; // SRL
                default: Result <= 32'd0;
            endcase

            Zero     <= (Result == 0);
            Negative <= Result[31];
        end
    end
endmodule
