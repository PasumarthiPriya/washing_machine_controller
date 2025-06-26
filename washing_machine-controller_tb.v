`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 13:53:18
// Design Name: 
// Module Name: washing_machine_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module washing_machine_tb;
reg clk,reset,start,door_close,filled,detergent_added,drained,spin_time_out,cycle_time_out;
wire door_lock,fill_valve_on,motor_on,drain_valve_on,done,soap_wash,water_wash;

washing_machine dut (clk,reset,start,door_close,filled,detergent_added,drained,spin_time_out,cycle_time_out,door_lock,fill_valve_on,motor_on,drain_valve_on,done,soap_wash,water_wash);
always #5 clk= ~clk;
initial
begin
clk=1;
reset=1;
start=0;
door_close=0;
filled=0;
detergent_added=0;
drained=0;
spin_time_out=0;
cycle_time_out=0;

#12 reset=0;
#3 start=1; 
#4 door_close=1;
#5 filled=1; 
#10 detergent_added=1;filled=0;
#10 cycle_time_out=1;
#10 drained=1;cycle_time_out=0;
#10 filled=1;drained=0;
#10 cycle_time_out=1; filled=0;
#10 drained= 1; cycle_time_out=0;
#6 drained=0;
#4 spin_time_out=1;door_close=0;detergent_added=0;drained=1;
#6 spin_time_out=0;drained=0;
#4 door_close=1;
#30 $finish;
   
end
endmodule
