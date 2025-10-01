module part5(SW, LEDR, HEX0, HEX1, HEX2);
    input [9:0] SW;             // Input: 10 toggle switches
    output [9:0] LEDR;          // Output: 10 red LEDs
    output [6:0] HEX0, HEX1, HEX2; // Outputs: three 7-seg displays

    // Declare internal 2-bit wires:
    // S  = select input from SW9~SW8
    // I2 = first  character code (U) from SW5~SW4
    // I1 = second character code (V) from SW3~SW2
    // I0 = third  character code (W) from SW1~SW0
    // m2, m1, m0 = outputs of the 3 multiplexers
    wire [1:0] S, I2, I1, I0, m2, m1, m0;

    // Assign switch groups to signals
    assign S = SW[9:8];     // Select lines for rotation
    assign LEDR = SW;       // Display all switches on LEDs (for debugging/visibility)
    assign I2 = SW[5:4];    // Input U
    assign I1 = SW[3:2];    // Input V
    assign I0 = SW[1:0];    // Input W

    // Instantiate three 2-bit wide 3-to-1 multiplexers
    // Each multiplexer selects one of the three characters (U, V, W)
    // depending on the select signal S
    // Different wiring produces the rotated display order
    mux_2bit_3to1 M0 (.S(S), .U(I2), .V(I1), .W(I0), .M(m0)); // feeds HEX0
    mux_2bit_3to1 M1 (.S(S), .U(I1), .V(I0), .W(I2), .M(m1)); // feeds HEX1
    mux_2bit_3to1 M2 (.S(S), .U(I0), .V(I2), .W(I1), .M(m2)); // feeds HEX2

    // Instantiate 7-segment decoders for each multiplexer output
    // Each decoder converts the 2-bit code into the correct 7-segment pattern
    char_7seg H0 (.C(m0), .Display(HEX0)); // HEX0 shows first character
    char_7seg H1 (.C(m1), .Display(HEX1)); // HEX1 shows second character
    char_7seg H2 (.C(m2), .Display(HEX2)); // HEX2 shows third character
endmodule


// Implements a 2-bit wide 3-to-1 multiplexer
// Select input: S[1:0]
// Truth table:
//   S=00 → output = U
//   S=01 → output = V
//   S=10 or 11 → output = W
module mux_2bit_3to1 (S, U, V, W, M);
    input [1:0] S, U, V, W;  // 2-bit select and 3x 2-bit inputs
    output [1:0] M;          // 2-bit output

    // Output bit 0
    assign M[0] = (((~S[0] & U[0]) | (S[0] & V[0])) & ~S[1]) | (S[1] & W[0]);

    // Output bit 1
    assign M[1] = (((~S[0] & U[1]) | (S[0] & V[1])) & ~S[1]) | (S[1] & W[1]);
endmodule

	
	
	// implements a 7-segment decoder for d, E, 1 and ‘blank’
module char_7seg (C, Display);
	input [1:0] C; // input code
	output [6:0] Display; // output 7-seg code
	assign Display = (C[1] == 1'b1)?((C[0] == 1'b1)?7'b1111111:7'b1111001):((C[0] == 1'b1)?7'b0000110:7'b0100001);
endmodule
