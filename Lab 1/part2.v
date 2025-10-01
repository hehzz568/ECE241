module part2(SW, LEDR);
    input [9:0] SW;        // Input: 10 toggle switches SW9~SW0
    output [9:0] LEDR;     // Output: 10 red LEDs LEDR9~LEDR0

    // Display the select signal SW[9] on LEDR[9]
    // This allows you to see whether X (0) or Y (1) is being selected
    assign LEDR[9] = SW[9];

    // Unused LEDs (LEDR[8:4]) are turned off by setting them to 0
    assign LEDR[8:4] = 5'b00000;

    // Implement a 4-bit wide 2-to-1 multiplexer (MUX)
    // General formula: M[i] = (~s & X[i]) | (s & Y[i])
    // When SW[9] = 0 → output LEDR[3:0] = SW[3:0] (X input)
    // When SW[9] = 1 → output LEDR[3:0] = SW[7:4] (Y input)
    assign LEDR[0] = (~SW[9] & SW[0]) | (SW[9] & SW[4]); // Output bit 0
    assign LEDR[1] = (~SW[9] & SW[1]) | (SW[9] & SW[5]); // Output bit 1
    assign LEDR[2] = (~SW[9] & SW[2]) | (SW[9] & SW[6]); // Output bit 2
    assign LEDR[3] = (~SW[9] & SW[3]) | (SW[9] & SW[7]); // Output bit 3
endmodule
