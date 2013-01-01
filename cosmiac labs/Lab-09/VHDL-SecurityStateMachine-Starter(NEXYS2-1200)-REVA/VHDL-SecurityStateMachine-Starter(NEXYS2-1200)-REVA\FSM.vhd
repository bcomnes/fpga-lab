----------------------------------------------------------------------------------
-- REVA : 7/25/2011
--         Add comments to coordinate with lab instructions
-- Create Date:    7/6/2011
-- Status: 				*** Template Created
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
    Port ( 
-- *** 2-2 Enter your I/O port assignment here (Reference: Figure 3: System Block Diagram)






			);	 
end FSM;

architecture Behavioral of FSM is

-- *** 2-3: Enter your type & signal names declarations here:






begin

-- *** 2-4: 
SENSORS <= FRONT_DOOR & REAR_DOOR & WINDOW;

SYNC: process (CLK,ARM) 
begin
	if ARM = '0' then
			CURR_STATE <= DISARMED;
	elsif rising_edge (CLK) then
			CURR_STATE <= NEXT_STATE;
	end if;
end process SYNC;

-----------------------------------------------------------
STATE_MACHINE: process (CURR_STATE,SENSORS,ARM,COUNT_DONE)
begin

-- *** 2-5
-- *** Your State Machine process code starts here:
-- ***















end process STATE_MACHINE;
-----------------------------------------------------------
-- *** 2-6:
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

