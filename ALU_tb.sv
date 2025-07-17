`timescale 1ns/1ps

module ALU_tb;

    // DUT Inputs
    logic clk, rst;
    logic [3:0] ALUop;
    logic [31:0] A, B;

    // DUT Outputs
    logic [31:0] Result;
    logic Zero, Carry, Overflow, Negative;

    // Instantiate DUT
    ALU dut (
        .clk(clk),
        .rst(rst),
        .ALUop(ALUop),
        .A(A),
        .B(B),
        .Result(Result),
        .Zero(Zero),
        .Carry(Carry),
        .Overflow(Overflow),
        .Negative(Negative)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, ALU_tb);
        $monitor("Time=%0t | A=%0d B=%0d ALUop=%b => Result=%0d | Z=%b C=%b V=%b N=%b", 
                 $time, A, B, ALUop, Result, Zero, Carry, Overflow, Negative);

        clk = 0;
        rst = 1;
        ALUop = 4'b0000;
        A = 0;
        B = 0;
        #10 rst = 0;

        // ADD: no overflow
        A = 32'd10; B = 32'd5; ALUop = 4'b0000; #10;

        // ADD: signed overflow
        A = 32'd2_000_000_000; B = 32'd1_500_000_000; ALUop = 4'b0000; #10;

        // SUB: signed overflow
        A = -32'd2_000_000_000; B = 32'd1_000_000_000; ALUop = 4'b0001; #10;

        // SUB: no overflow
        A = 32'd20; B = 32'd5; ALUop = 4'b0001; #10;

        // AND
        A = 32'hFF00FF00; B = 32'h00FF00FF; ALUop = 4'b0010; #10;

        // OR
        ALUop = 4'b0011; #10;

        // XOR
        ALUop = 4'b0100; #10;

        // NOR
        ALUop = 4'b0101; #10;

        // SLT: A < B
        A = -32'd5; B = 32'd1; ALUop = 4'b0110; #10;

        // SLT: A > B
        A = 32'd5; B = -32'd1; ALUop = 4'b0110; #10;

        // SLL: shift left
        A = 32'h00000001; B = 32'd4; ALUop = 4'b0111; #10;

        // SRL: shift right
        A = 32'h00000080; B = 32'd3; ALUop = 4'b1000; #10;

        $finish;
    end

endmodule
