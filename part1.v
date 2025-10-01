// Simple module that connects the SW switches to the LEDR lights
module part1 (SW, LEDR);
    input [9:0] SW;     // 10 inputs
    output [9:0] LEDR;  // 10 red leds

    assign LEDR = SW;   // send every signal to the led
endmodule