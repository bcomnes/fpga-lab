----------------------------------------------------------------------------------
-- INDICATORS.vhd
-- 
-- Create Date:    5/10/2011
-- Status: 				*** Operation verified with NEXYS2

-- Project Name:   Security State Machine
-- Target Devices: NEXYS2-1200
-- Tool versions:  Win7 / Xilinx ISE 12.1

-- Description: This Module provide visual feedback for NEXYS2 on board switches & buttons
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity INDICATORS is
    Port ( ARM : in  STD_LOGIC;
           FRONT_DOOR : in  STD_LOGIC;
           REAR_DOOR : in  STD_LOGIC;
           WINDOW : in  STD_LOGIC;
			  
           ARM_SIG : out  STD_LOGIC;
           FRONT_DOOR_SIG : out  STD_LOGIC;
           REAR_DOOR_SIG : out  STD_LOGIC;
           WINDOW_SIG : out  STD_LOGIC);
end INDICATORS;

architecture Behavioral of INDICATORS is

begin

	ARM_SIG<=ARM;			
	FRONT_DOOR_SIG <= FRONT_DOOR; 
	REAR_DOOR_SIG <=  REAR_DOOR; 
	WINDOW_SIG <= WINDOW;

end Behavioral;

