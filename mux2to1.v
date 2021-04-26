 /*
  * Date: 4-25-2021
  * Author: Ramsey Alahmad
  * Name: Mux2to1
  *
  */
  
module mux2to1
#(parameter SIZE = 16)
(
      input [SIZE-1:0] input1, input2, // size of the inputs is 16 bits
      input switch,
      output reg [SIZE-1:0] out // size of the output is 16 bits
);
always@(*)
begin
     switch == 1'b1 ? out = input2 : out = input1;
end
endmodule
