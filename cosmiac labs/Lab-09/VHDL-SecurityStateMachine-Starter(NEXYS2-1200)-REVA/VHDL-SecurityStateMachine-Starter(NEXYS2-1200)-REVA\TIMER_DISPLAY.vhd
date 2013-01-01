----------------------------------------------------------------------------------
-- TIMER_DISPLAY.vhd
-- 
-- Create Date:    7/6/2011
-- Status: 				*** Operation verified with NEXYS2-1200

-- Target Devices: NEXYS2-1200
-- Tool versions:  Win7 / Xilinx ISE 12.1

-- Description: This module provide timer & control for 7-segment LED display

-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TIMER_DISPLAY is
    Port ( CLK : in  STD_LOGIC;
           CLK_DIV : out  STD_LOGIC;
			  RUN_TIMER: in STD_LOGIC;     -- *** RUN_TIMER is output from FSM module
				ADDR: out STD_LOGIC_VECTOR(3 downto 0);      
				ANODE_CONTROL: out STD_LOGIC_VECTOR(3 downto 0)
			);
end TIMER_DISPLAY;

architecture Behavioral of TIMER_DISPLAY is

signal REG : std_logic_vector(27 downto 0) := (others => '0');
signal CLK_DIV_INT :STD_LOGIC;
signal Q_INT: std_logic_vector(3 downto 0);

begin

	process (CLK,REG) begin
		if rising_edge(CLK) then
			REG <= REG + 1;    CLK_DIV_INT<='0';
			end if;
			
		if REG = X"2FAF080" then   -- For 1 Hz use X"2FAF080" = 50,000,000 (Decimal)
											-- 50 MHz / 50,000,000 = 1 Hz
			CLK_DIV_INT<='1';
			REG<=X"0000000";

		end if;
		
	end process;
	
	process (CLK,CLK_DIV_INT,RUN_TIMER)
	begin
	if RUN_TIMER = '0' then
		Q_INT <= (others => '0');
	elsif rising_edge(CLK) then
		if (CLK_DIV_INT='1') then
			Q_INT <= Q_INT + '1';
		end if;
	end if;
	
	end process;

-- Outputs:
ADDR(3 downto 0) <= Q_INT (3 downto 0);
ANODE_CONTROL <= "1110"; -- Enable 1st digit only, active Low
CLK_DIV <=CLK_DIV_INT;

end Behavioral;

