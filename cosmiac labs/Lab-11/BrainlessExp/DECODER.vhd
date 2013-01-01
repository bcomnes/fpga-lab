----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor
-- Module Name:    DECODER - Behavioral 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECODER is
    Port ( A : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (1 downto 0));
end DECODER;

architecture Behavioral of DECODER is

begin

process( A, EN )
begin
	if EN = '1' then
		if A = '0' then
			Y <= "01";
		
		else
			Y <= "10";
		end if;
	end if;
end process;

end Behavioral;

