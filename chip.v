module my_xor(input a, input b, output y);
    assign y = (a != b);
endmodule

module keyboard(input clk, input reset, input [3:0] keys, output reg speaker);
    reg [10:0] count;
    reg [10:0] period; //period = clock speed / 2 x (frequency)
     
    always @(*) begin
        if (keys[0]) period = 1911; // note c
        else if (keys[1]) period = 1703; // note d
        else if (keys[2]) period = 1517; // note e
        else if (keys[3]) period = 1276; //note g
        else period = 0; 
    end

        always @(posedge clk or posedge reset) begin
            if (reset || period == 0) begin
                count <= 0;
                speaker <= 0;
            end 
            elseif (count >= period) begin
                count <= 0;
                speaker <= ~speaker;
            end 
            else begin
                count <= count + 1;
            end
        end
endmodule