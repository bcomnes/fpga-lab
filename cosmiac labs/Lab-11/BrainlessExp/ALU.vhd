----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor
-- Module Name:    ALU - Behavioral 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
			  A_ONLY : in  STD_LOGIC;
			  INVERT : in  STD_LOGIC;
			  ARITH_LOGIC : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC);

end ALU;

architecture Behavioral of ALU is

signal Control_Signal: STD_LOGIC_VECTOR( 2 downto 0 );

begin

process( A, B, Control_Signal )
begin
	
	case Control_Signal is
		
		when "000" => Y <= A; --pass through
		
		when "001" => Y <= A + B; --add
		
		when "010" => Y <= not( A ) + 1; --twos complement
		
		when "011" => Y <= ( not( A ) + 1) + B; --B - A
		
		when "100" => Y <= A; --pass through
		
		when "101" => Y <= A or B; --A OR B
		
		when "110" => Y <= not( A ); -- ones complement
		
		when "111" => Y <= ( not( A ) ) or B;	--B OR (-A)
		
		when others=> Y <= "0000"; --clear
		
	end case;
end process;

Control_Signal <= ARITH_LOGIC & INVERT & A_ONLY;

end Behavioral;

