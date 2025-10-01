module part3(SW, LEDR);
    input [9:0] SW;        // Input: 10 toggle switches SW9~SW0
    output [9:0] LEDR;     // Output: 10 red LEDs LEDR9~LEDR0

    // Turn off unused LEDs LEDR[9:2] by setting them to 0
    assign LEDR[9:2] = 8'b0;

    // Declare 2-bit wires for select input (s) and three data inputs (u, v, w)
    // Also declare a 2-bit wire for the display (output)
    wire [1:0] s, u, v, w, display;

    // Map the switches to inputs:
    assign u = SW[5:4];   // U input comes from switches SW5~SW4
    assign v = SW[3:2];   // V input comes from switches SW3~SW2
    assign w = SW[1:0];   // W input comes from switches SW1~SW0
    assign s = SW[9:8];   // Select input S = s1s0 comes from switches SW9~SW8

    // Connect the 2-bit output display to LEDs LEDR[1:0]
    assign LEDR[1:0] = display;

    // Function: 2-bit wide 3-to-1 multiplexer
    // Truth table (s1 s0):
    // 00 → select U
    // 01 → select V
    // 10 or 11 → select W
    //
    // Equation for each bit of display:
    // display[i] = (((~s0 & u[i]) | (s0 & v[i])) & ~s1) | (s1 & w[i])

    // Output bit 0
    assign display[0] = (((~s[0] & u[0]) | (s[0] & v[0])) & ~s[1]) | (s[1] & w[0]);

    // Output bit 1
    assign display[1] = (((~s[0] & u[1]) | (s[0] & v[1])) & ~s[1]) | (s[1] & w[1]);
endmodule
