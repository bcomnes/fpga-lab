----------------------------------------------------------------------------------
-- Update: 8/11/2011
--         * Revise code in Process STATE MACHINE with more logical state transitions
-- Create Date:    7/6/2011
-- Status: 				*** Operation verified with NEXYS2-1200
-- Module Name:    FSM - Behavioral 
-- Project Name:   Security State Machine
-- Target Devices: NEXYS2-1200
-- Tool versions:  Win7 / Xilinx ISE 12.1

-- Description: Sample solution for Security State Machine 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM is
    Port ( CLK : in  STD_LOGIC;
	 		  CLK_DIV:in  STD_LOGIC;
           ARM : in  STD_LOGIC;
           FRONT_DOOR : in  STD_LOGIC;
           REAR_DOOR : in  STD_LOGIC;
           WINDOW : in  STD_LOGIC;
			  RUN_TIMER:out  STD_LOGIC;
           SIREN : out  STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

type SECURITY_STATE is (ARMED,DISARMED,WAIT_DELAY, ALARM);
signal CURR_STATE,NEXT_STATE: SECURITY_STATE;


signal START_COUNT,COUNT_DONE: std_logic;
signal SENSORS:std_logic_vector (2 downto 0); --combine inputs

signal TIMER_CNTR: std_logic_vector (2 downto 0) := (others => '0');

begin
SENSORS <= FRONT_DOOR & REAR_DOOR & WINDOW;

SYNC: process (CLK,ARM) 
begin
	if ARM = '0' then
			CURR_STATE <= DISARMED;
	elsif rising_edge (CLK) then
			CURR_STATE <= NEXT_STATE;
	end if;
end process SYNC;

STATE_MACHINE: process (CURR_STATE,SENSORS,ARM,COUNT_DONE)
begin
	
	START_COUNT <= '0'; -- establish default

	case (CURR_STATE) is			

		when DISARMED =>
			if ARM = '1' then
			NEXT_STATE <= ARMED;
			else NEXT_STATE <= DISARMED;
			end if;
			-- Output:
			SIREN <= '0';
			RUN_TIMER <= '0';			
		when ARMED =>
			if (ARM = '0') then
			NEXT_STATE <= DISARMED;
			elsif (SENSORS /= "000") then   -- Note: /= means NOT equal
			NEXT_STATE <= WAIT_DELAY;
			else NEXT_STATE <= ARMED;
			end if;
			-- Output:
			SIREN <= '0';
			RUN_TIMER <= '0';			
		when WAIT_DELAY =>
			START_COUNT <= '1';
			
			if (ARM = '0') then
			NEXT_STATE <= DISARMED;
			elsif (COUNT_DONE = '1') then
			NEXT_STATE <= ALARM;
			else NEXT_STATE <= WAIT_DELAY;
			end if;
			-- Output:
			SIREN <= '0';			
			RUN_TIMER <= '1';
		when ALARM =>
			if (ARM = '0') then
			NEXT_STATE <= DISARMED;
			else NEXT_STATE <= ALARM;
			end if;
			-- Output:
			SIREN <= '1';
			RUN_TIMER <= '0';			
 end case;
end process STATE_MACHINE;

DELAY_TIMER: process(CLK_DIV,CURR_STATE,START_COUNT,TIMER_CNTR)  
begin		
	COUNT_DONE <= '0';  -- default value
	if (rising_edge (CLK_DIV) and (START_COUNT = '1')) then 
					TIMER_CNTR <= TIMER_CNTR + 1;				
	end if; 	
	
	if (CURR_STATE/=WAIT_DELAY) then 
		TIMER_CNTR <= "000";	
	end if; 

	if (TIMER_CNTR = "111") then	
		COUNT_DONE <= '1';
	end if;	

end process DELAY_TIMER;

end Behavioral;

