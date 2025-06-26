`timescale 1ns / 1ps

module washing_machine(clk,reset,start,door_close,filled,detergent_added,drained,spin_time_out,cycle_time_out,door_lock,fill_valve_on,motor_on,drain_valve_on,done,soap_wash,water_wash);
input clk,reset,start,door_close,filled,detergent_added,drained,spin_time_out,cycle_time_out;
output reg door_lock,fill_valve_on,motor_on,drain_valve_on,done,soap_wash,water_wash;
reg [2:0] current_state,next_state;
parameter check_door = 3'b000,fill_water=3'b001,add_detergent=3'b010,cycle=3'b011,drain_water=3'b100,spin=3'b101;

always@(posedge clk or negedge reset)
begin
    if(reset)
    begin
     current_state <= check_door;
    end
    else
    begin
      current_state<=next_state;
    end
end
always@(current_state or start or door_close or filled or detergent_added or drained or spin_time_out or cycle_time_out)
begin
    case(current_state)
        check_door: 
                    if(start==1 && door_close==1)
                    begin
                            next_state <= fill_water;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 0;
                            water_wash <= 0;
                            done <= 0;
                    end
                    else
                    begin
                            next_state <= current_state;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 0;
                            soap_wash <= 0;
                            water_wash <= 0;
                            done <= 0;
                    end
            fill_water :
                    if(filled==1)
                    begin
                        if(soap_wash==0)
                        begin
                            next_state <= add_detergent;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 0;
                            water_wash <= 0;
                            done <= 0;
                        end
                        else
                        begin
                            next_state <= cycle;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            done <= 0;
                        end
                        
                    end   
                    else
                    begin
                            next_state <= current_state;
                            motor_on <= 0;
                            fill_valve_on <= 1;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            done <= 0;
                    end  
            add_detergent: 
                    if(detergent_added==1)
                    begin
                            next_state <= cycle;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 0;
                            done <= 0;
                    end
                    else
                    begin
                            next_state <= current_state;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 0;
                            done <= 0;
                    end
           cycle:
                    if(cycle_time_out==1)
                    begin
                            next_state <= drain_water;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            done <= 0;
                    end
                    else
                    begin
                            next_state <= current_state;
                            motor_on <= 1;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            done <= 0;
                    end
            drain_water:
                    if(drained==1)
                    begin
                        if(water_wash==0)
                        begin
                            next_state <= fill_water;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 1;
                            done <= 0;
                            
                        end
                        else
                        begin
                            next_state <= spin;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 1;
                            done <= 0;
                        
                        end
                   
                    end
                     else
                    begin
                            next_state <= current_state;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 1;
                            door_lock <= 1;
                            soap_wash <= 1;
                            done <= 0;
                  
                    end
              spin:
                    if(spin_time_out==1)
                    begin
                            next_state <= check_door;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 0;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 1;
                            done <= 1;
                    end            
                    else
                    begin
                            next_state <= current_state;
                            motor_on <= 0;
                            fill_valve_on <= 0;
                            drain_valve_on <= 1;
                            door_lock <= 1;
                            soap_wash <= 1;
                            water_wash <= 1;
                            done <= 0;
                    end

endcase
end
endmodule
