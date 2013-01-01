----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor
-- Module Name:    BUFFER - Behavioral 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity BUFFER4 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           EN : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end BUFFER4;

architecture Behavioral of BUFFER4 is

begin

process( A, EN )
begin
    if EN = "11" then
		Y <= A;
    end if;
end process;

end Behavioral;

