`timescale 1ns/1ps

module tb_multiplier_logic;

reg clk;
reg rst_n;
reg [15:0] a;
reg [15:0] b;
wire [31:0] y;

// DUT
multiplier_logic dut (
    .clk(clk),
    .rst_n(rst_n),
    .a(a),
    .b(b),
    .y(y)
);

// Clock 100 MHz
always #5 clk = ~clk;

// pipeline latency = 4
localparam LAT = 4;

// expected output shift register
reg [31:0] expected [0:LAT];
integer i;

// Task : apply one input every clock
task apply_input(input [15:0] ta, input [15:0] tb);
begin
    @(posedge clk);
    a <= ta;
    b <= tb;
    expected[0] <= ta * tb;

    for(i=LAT; i>0; i=i-1)
        expected[i] <= expected[i-1];
end
endtask

// Check result
always @(posedge clk) begin
    if(rst_n) begin
        if(y !== expected[LAT])
            $display("FAIL | a=%0d b=%0d y=%0d expected=%0d time=%0t",
                     a, b, y, expected[LAT], $time);
        else
            $display("PASS | y=%0d time=%0t", y, $time);
    end
end

initial begin
    clk=0; rst_n=0; a=0; b=0;

    repeat(5) @(posedge clk);
    rst_n=1;

    // continuous streaming inputs
    apply_input(3,7);
    apply_input(12,9);
    apply_input(25,16);
    apply_input(123,45);
    apply_input(255,255);
    apply_input(1024,32);
    apply_input(65535,2);
    apply_input(1111,3333);
    apply_input(500,400);

    repeat(10) @(posedge clk);

    $display("Simulation Finished");
    $stop;
end

endmodule