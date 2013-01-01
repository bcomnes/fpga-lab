----------------------------------------------------------------------------------
-- MEM16.vhd
-- 
-- Create Date:    7/6/2011
-- Status: 				*** Operation verified with NEXYS2-1200

-- Target Devices: NEXYS2-1200

-- Tool versions:  Win7 / Xilinx ISE 12.1

-- Description: Sample Solution for Memory Module for displaying 7-segment LEDs
--
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM16 is
    Port ( ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
           DATA : out  STD_LOGIC_VECTOR (7 downto 0));
end MEM16;

architecture Behavioral of MEM16 is
	type ROM_ARRAY is array (0 to 15) of std_logic_vector(7 downto 0);	
	constant MY_ROM :ROM_ARRAY :=(
-- Cathode Control for 7-SEGMENT LED Digit (0-F):
		0 => X"03", --0    note: Cathode control is active Low
		1 => X"9F", --1 
		2 => X"25", --2	
		3 => X"0D", --3
		4 => X"99", --4
		5 => X"49", --5		
		6 => X"41", --6
		7 => X"1F", --7
		8 => X"01", --8	
		9 => X"09", --9
		10 => X"11", --A		
		11 => X"C1", --B	
		12 => X"63", --C
		13 => X"85", --D		
		14 => X"61", --E
		15 => X"71" --F
	);
begin
		DATA <= MY_ROM(conv_integer(ADDR));
end Behavioral;


