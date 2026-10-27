// Code your design here

module alu (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [2:0] opcode,
    output logic [7:0] result,
    output logic       zero
);

    always_comb begin
        case (opcode)

            3'b000: result = A + B;  // Addition
            3'b001: result = A - B;  // Subtraction
            3'b010: result = A & B;  // AND
            3'b011: result = A | B;  // OR
            3'b100: result = A ^ B;  // XOR
            3'b101: result = ~A;     // NOT A

            default: result = 8'b00000000;

        endcase

        // Zero flag is 1 when result is zero
        zero = (result == 8'b00000000);
    end

endmodule
