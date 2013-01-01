----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:08 05/05/2011 
-- Design Name: 
-- Module Name:    DISP_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISP_controller is
	Port ( digit_in : in std_logic_vector(3 downto 0);
           digit_out : out std_logic_vector(6 downto 0));
end DISP_controller;

architecture Behavioral of DISP_controller is

begin

dig_to_sseven_segment: process (digit_in)

begin

	case digit_in is

	   when "0000" => digit_out <= "1000000";
	   when "0001" => digit_out <= "1111001";
	   when "0010"	=> digit_out <= "0100100";
	   when "0011" => digit_out <= "0110000";
	   when "0100" => digit_out <= "0011001";
	   when "0101" => digit_out <= "0010010";
	   when "0110" => digit_out <= "0000010";
	   when "0111" => digit_out <= "1111000";
	   when "1000" => digit_out <= "0000000";
	   when "1001" => digit_out <= "0010000";
	   when "1010" => digit_out <= "0001000";
	   when "1011"	=> digit_out <= "0000011";
	   when "1100" => digit_out <= "1000110";
	   when "1101" => digit_out <= "0100001";
	   when "1110" => digit_out <= "0000110";
	   when "1111" => digit_out <= "0001110";
	   when others => digit_out <= "1111111";
	end case;

end process;

end Behavioral;

