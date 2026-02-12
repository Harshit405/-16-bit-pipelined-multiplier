# -16-bit-pipelined-multiplier
Instead of using the built-in * operator, I designed the architecture from scratch using 16 partial products and a staged adder tree (s1 → s4). The design is fully synchronous and pipelined for better timing and clean hardware behavior.
