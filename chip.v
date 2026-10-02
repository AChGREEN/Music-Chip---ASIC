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

        always @(posedge clk or posedge reset) begin //on every tick do one of these things
            if (reset || period == 0) begin //if reset is on or no key is pressed:
                count <= 0; //set count to 0
                speaker <= 0; //set speaker to 0; silent
            end 
            elseif (count >= period) begin //if count is greater than or equal to period:
                count <= 0; //set count to 0
                speaker <= ~speaker; //flip the speaker (1 to 0 or 0 to 1)
            end 
            else begin //otherwise:
                count <= count + 1; //add 1 to the counter
            end
        end
endmodule
