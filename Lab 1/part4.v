module part4(SW, HEX0);
    input [1:0] SW;        // Input: 2 toggle switches SW1~SW0 (code c1c0)
    output [6:0] HEX0;     // Output: 7-segment display HEX0[6:0]

    wire [1:0] c;          // 2-bit code input
    wire [6:0] h;          // 7-bit output for 7-segment display

    // Map switches to code input
    assign c = SW[1:0];

    // Implement 7-segment decoder using nested conditional operator (?:)
    // Each 7'b pattern corresponds to which segments are ON (0 = ON, 1 = OFF)
    //
    // Character mapping from the lab:
    // c1c0 = 00 → "d" → pattern 7'b0100001
    // c1c0 = 01 → "E" → pattern 7'b0000110
    // c1c0 = 10 → "1" → pattern 7'b1111001
    // c1c0 = 11 → blank → pattern 7'b1111111
    //
    // Note: On DE1-SoC, each segment lights up when its bit = 0
    assign h = (c[1] == 1'b1) ?                // If c1 = 1
                  ((c[0] == 1'b1) ? 7'b1111111 // 11 → blank
                                   : 7'b1111001) // 10 → "1"
               : ((c[0] == 1'b1) ? 7'b0000110  // 01 → "E"
                                   : 7'b0100001); // 00 → "d"

    // Drive the 7-segment display with the decoded pattern
    assign HEX0 = h;
endmodule
