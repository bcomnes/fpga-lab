----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor
-- Module Name:    REGISTER - Behavioral 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REGISTER4 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CLEAR : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end REGISTER4;

architecture Behavioral of REGISTER4 is

begin

process (CLK)
begin
	if (CLK'event and CLK = '1') then --if there is a rising edge of the clock						
		if (CLEAR = '1') then --and clear is a 1
			Y <= "0000"; --clear the output
		elsif (EN = '1') then --or if enable is a 1
			Y <= A; --send the input to the output
		end if;
	end if;
end process;

end Behavioral;

