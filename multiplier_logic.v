module multiplier_logic (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] a,
    input  wire [15:0] b,
    output reg  [31:0] y
);

     reg[15:0] a_r1,a_r2,a_r3;
     reg[15:0] b_r1,b_r2,b_r3;


    wire [31:0] pp [0:15];

    assign pp[0] = b[0] ? (a << 0) : 32'd0;
    assign pp[1] = b[1] ? (a << 1) : 32'd0;
    assign pp[2] = b[2] ? (a << 2) : 32'd0;
    assign pp[3] = b[3] ? (a << 3) : 32'd0;
    assign pp[4] = b[4] ? (a << 4) : 32'd0;
    assign pp[5] = b[5] ? (a << 5) : 32'd0;
    assign pp[6] = b[6] ? (a << 6) : 32'd0;
    assign pp[7] = b[7] ? (a << 7) : 32'd0;
	 assign pp[8] = b[8] ? (a << 8) : 32'd0;
    assign pp[9] = b[9] ? (a << 9) : 32'd0;
    assign pp[10] = b[10] ? (a << 10) : 32'd0;
    assign pp[11] = b[11] ? (a << 11) : 32'd0;
    assign pp[12] = b[12] ? (a << 12) : 32'd0;
	 assign pp[13] = b[13] ? (a << 13) : 32'd0;
    assign pp[14] = b[14] ? (a << 14) : 32'd0;
    assign pp[15] = b[15] ? (a << 15) : 32'd0;
    
	 reg [31:0] s1_0, s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7;
    reg [31:0] s2_0, s2_1, s2_2, s2_3;
    reg [31:0] s3_0, s3_1;
    reg [31:0] s4;

	 
    always @(posedge clk) begin
        if (!rst_n) begin
		  a_r1 <= 32'd0;a_r2 <= 32'd0;a_r3<= 32'd0;
		  b_r1 <= 32'd0;b_r2 <= 32'd0;b_r3<= 32'd0;
		      s1_0 <= 32'd0;
				s1_1 <= 32'd0;
				s1_2 <= 32'd0;
				s1_3 <= 32'd0;
				s1_4 <= 32'd0;
				s1_5 <= 32'd0;
				s1_6 <= 32'd0;
				s1_7 <= 32'd0;
				s2_0 <= 32'd0;
				s2_1 <= 32'd0;
				s2_2 <= 32'd0;
				s2_3 <= 32'd0;
				s3_0 <= 32'd0;
				s3_1 <= 32'd0;
            y  <= 32'd0;
            s4 <= 32'd0;
        end else begin
		     a_r1<=a;
           a_r2<=a_r1; 
           a_r3<=a_r2; 
			  b_r1<=b;
			  b_r2<=b_r1;
			  b_r3<=b_r2;

            s1_0 <= pp[0] + pp[1];
            s1_1 <= pp[2] + pp[3];
            s1_2 <= pp[4] + pp[5];
            s1_3 <= pp[6] + pp[7];
            s1_4 <= pp[8] + pp[9];
            s1_5 <= pp[10] + pp[11];
            s1_6 <= pp[12] + pp[13];
            s1_7 <= pp[14] + pp[15];
			
            s2_0 <= s1_0 + s1_1;
            s2_1 <= s1_2 + s1_3;
            s2_2 <= s1_4 + s1_5;
            s2_3 <= s1_6 + s1_7;
            
				s3_0  <= s2_0 + s2_1;
				s3_1  <= s2_2 + s2_3;
				
				s4    <= s3_0 + s3_1; 
         
            y  <= s4;
        end
    end

endmodule

module top_multiplier(
    input CLOCK_50,
    input [17:0] SW,
    input [3:0] KEY,
    output [6:0] HEX0, HEX1, HEX2, HEX3,
    output [6:0] HEX4, HEX5, HEX6, HEX7
);

wire clk = CLOCK_50;
wire rst_n = KEY[0];       
wire load_a = ~KEY[1];   
wire load_b = ~KEY[2];     

reg [15:0] A;
reg [15:0] B;
wire [31:0] Y;
reg [31:0] Y_reg;
reg [3:0] wait_count;
reg valid;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        A <= 0;
        B <= 0;
        Y_reg <= 0;
        wait_count <= 0;
        valid <= 0;
    end
    else begin
        if(load_a) A <= SW[15:0];

        if(load_b) begin
            B <= SW[15:0];
            wait_count <= 0;
            valid <= 0;
        end

        // wait 10 clock cycles (pipeline delay safety)
        if(wait_count < 10) begin
            wait_count <= wait_count + 1;
        end
        else begin
            valid <= 1;
        end

        if(valid)
            Y_reg <= Y;
    end
end
multiplier_logic uut(
    .clk(clk),
    .rst_n(rst_n),
    .a(A),
    .b(B),
    .y(Y)
);
hex_7seg hex0(.hex(Y_reg[3:0]),    .seg(HEX0));
hex_7seg hex1(.hex(Y_reg[7:4]),    .seg(HEX1));
hex_7seg hex2(.hex(Y_reg[11:8]),   .seg(HEX2));
hex_7seg hex3(.hex(Y_reg[15:12]),  .seg(HEX3));
hex_7seg hex4(.hex(Y_reg[19:16]),  .seg(HEX4));
hex_7seg hex5(.hex(Y_reg[23:20]),  .seg(HEX5));
hex_7seg hex6(.hex(Y_reg[27:24]),  .seg(HEX6));
hex_7seg hex7(.hex(Y_reg[31:28]),  .seg(HEX7));

endmodule
module hex_7seg(
    input [3:0] hex,
    output reg [6:0] seg
);
always @(*) begin
    case(hex)
        4'h0: seg = 7'b1000000;
        4'h1: seg = 7'b1111001;
        4'h2: seg = 7'b0100100;
        4'h3: seg = 7'b0110000;
        4'h4: seg = 7'b0011001;
        4'h5: seg = 7'b0010010;
        4'h6: seg = 7'b0000010;
        4'h7: seg = 7'b1111000;
        4'h8: seg = 7'b0000000;
        4'h9: seg = 7'b0010000;
        4'hA: seg = 7'b0001000;
        4'hB: seg = 7'b0000011;
        4'hC: seg = 7'b1000110;
        4'hD: seg = 7'b0100001;
        4'hE: seg = 7'b0000110;
        4'hF: seg = 7'b0001110;
        default: seg = 7'b1111111;
    endcase
end
endmodule
