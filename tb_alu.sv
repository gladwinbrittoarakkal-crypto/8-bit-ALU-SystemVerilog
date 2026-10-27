// Code your testbench here
// or browse Examples

module tb_alu;

    logic [7:0] A, B;
    logic [2:0] opcode;
    logic [7:0] result;
    logic zero;

    logic [7:0] expected;

    integer passed = 0;
    integer failed = 0;

    // Connect the ALU design
    alu dut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .zero(zero)
    );

    // Task to check result and zero flag
    task automatic check(
        input logic [7:0] a_test,
        input logic [7:0] b_test,
        input logic [2:0] op_test,
        input logic [7:0] exp_test
    );
        begin
            A = a_test;
            B = b_test;
            opcode = op_test;
            expected = exp_test;

            #1;

            if ((result !== expected) ||
                (zero !== (expected == 8'd0))) begin

                $display(
                    "FAIL: A=%0d B=%0d opcode=%b expected=%0d result=%0d zero=%b",
                    A, B, opcode, expected, result, zero
                );

                failed = failed + 1;

            end else begin

                $display(
                    "PASS: A=%0d B=%0d opcode=%b result=%0d zero=%b",
                    A, B, opcode, result, zero
                );

                passed = passed + 1;

            end
        end
    endtask

    initial begin
        $display("================================");
        $display("       ALU VERIFICATION");
        $display("================================");

        // Test 1: Addition
        check(8'd12, 8'd5, 3'b000, 8'd17);

        // Test 2: Subtraction
        check(8'd12, 8'd5, 3'b001, 8'd7);

        // Test 3: AND
        check(8'd12, 8'd5, 3'b010, 8'd4);

        // Test 4: OR
        check(8'd12, 8'd5, 3'b011, 8'd13);

        // Test 5: XOR
        check(8'd12, 8'd5, 3'b100, 8'd9);

        // Test 6: NOT A
        check(8'd12, 8'd0, 3'b101, 8'd243);

        // Test 7: Addition overflow
        check(8'd255, 8'd1, 3'b000, 8'd0);

        // Test 8: Subtraction with wraparound
        check(8'd5, 8'd12, 3'b001, 8'd249);

        // Test 9: Zero result from AND
        check(8'd8, 8'd4, 3'b010, 8'd0);

        // Test 10: Invalid opcode
        check(8'd12, 8'd5, 3'b110, 8'd0);

        // Test 11: Other invalid opcode
        check(8'd12, 8'd5, 3'b111, 8'd0);

        // Test 12: Addition of zero
        check(8'd0, 8'd0, 3'b000, 8'd0);

        // Test 13: Maximum value XOR itself
        check(8'd255, 8'd255, 3'b100, 8'd0);

        $display("================================");
        $display("Tests passed: %0d", passed);
        $display("Tests failed: %0d", failed);
        $display("================================");

        if (failed == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end

endmodule
