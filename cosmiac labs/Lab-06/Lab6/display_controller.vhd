--------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------
entity display_controller is
	port(
		CLK, RESET: in std_logic;												-- 100MHz clock and RESET button (single bit)
		HEX3, HEX2, HEX1, HEX0: in std_logic_vector(3 downto 0);		-- 4-bit inputs for the LED lights
		AN: out std_logic_vector(3 downto 0);								-- 4-bit anode controller
		SSEG: out std_logic_vector(6 downto 0)								-- 7-bit cathode controller
		);
end display_controller;
--------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------
-- Architecture of display_controller multiplexer 
-- The architecture below describes the behavior of the multiplexer 
-- using its individual processes as well as its seven-segment decoder 
-- to display numbers on the anodes using cathodes. 

architecture arch of display_controller is 
	
	-- ************************************************************** --
		-- CHANGE N value to 2 for test bench, back to 20 for compile
	-- ************************************************************** --
	constant N: integer := 20;							-- constant 'N' set to an integer, used to slow the
																-- display speed so that regular humans can see it
																-- changing this number to anything < 25 and the display
																-- is too slow, > 18 and the display is too fast

	
	signal Q_REG, Q_NEXT: unsigned(N-1 downto 0);	-- Q_REG used to set the value of SEL, see process
	signal SEL: std_logic_vector(1 downto 0);			-- SEL value determines which anode to display
	signal HEX: std_logic_vector(3 downto 0);			-- HEX value determines the cathode display, see end of code

begin

	-- This process controls the RESET button of the clock
	process(CLK, RESET)									-- sensitivity list includes CLK and RESET
	begin														-- begin the process
		if RESET='1' then									-- when RESET is pressed
			Q_REG <= (others=>'0');						-- Q_REG gets 0
		elsif (CLK'event and CLK='1') then			-- else if (otherwise if) there is a rising edge clock event then
			Q_REG <= Q_NEXT;								--	Q_REG gets Q_NEXT
		end if;												--	end if
	end process;											-- end process

	
	-- State logic for the counter
	Q_NEXT <= Q_REG + 1;									-- add 1 to Q_REG and send to Q_NEXT
	

	-- 2 MSBs of counter to control 4-to-1 multiplexing 
	SEL <= std_logic_vector(Q_REG(N-1 downto N-2));		-- SEL gets the first two bits of Q_REG
																		-- MSB (most significant bit), bits from the left
																		-- LSB (least significant bit), bits from the right
	
	-- This process is the 2:4 decoder, which converts a two-bit input 
	-- into a four-bit input for the seven-segment decoder.
	-- Since there are 4 anodes on the FPGA we need to tell the board which anode we whant to light.
	-- It uses a case statement which sets the value of AN and HEX 
	-- based on the value of SEL
	
	process(SEL, HEX0, HEX1, HEX2, HEX3)				-- sensitivity list includes SEL, HEX0, HEX1, HEX2, HEX3
	begin															-- begin the process
		case SEL is												-- begining of case statement, when SEL is...

			when "00" =>												-- when SEL is 00
				AN <= "1110";												-- This sets ANO on   
				HEX <= HEX0;												-- send HEX0 to the first digit (HEX) 
																				-- for cathode display
																				-- HEX0 is the 4 least significant bits
				
			when "01" =>												-- when SEL is 01
				AN <= "1101";												-- This sets AN1 on
				HEX <= HEX1;												-- 
				
			when "10" =>												-- when SEL is 10
				AN <= "1011";												-- This sets AN2 on
				HEX <= HEX2;												-- 
				
			when others =>												-- when SEL is anything else (11)
				AN <= "0111";												-- This sets AN3 on
				HEX <= HEX3;												-- send HEX3 to the first digit (HEX) 
																				-- for cathode display
																				-- HEX3 is the 4 most significant bits
				 
				
		end case;												-- end case
	end process;												-- end process
	
	-- This is the actual seven-segment decoder, which converts the four-bit input 
	-- to the cathodes to display signals. The Basic I/O section of the Reference Manual 
	-- will provide the pin labels for the display segements. The Seven-Segment Display  
	-- section provides information on how the LEDs operate.
	-- There are 7 cathodes, A - G, and in the UCF we will link them as follows:
	-- cathode	-->	G	F	E	D	C	B	A
	-- SSEG bit -->	6	5	4	3	2	1	0
	-- In the following code HEX is a four bit number from 0 - 15, which drives the value of SSEG
	-- Depending on the value of HEX, we will light the appropriate cathode to count in hexadecimal,
	-- using the SSEG signal. When a cathode is low (or 0) it will light. 
	-- Basically, this code says: ' use HEX to select what SSEG gets  
	
	
	with HEX select
		SSEG(6 downto 0) <=
			"1000000" when "0000", -- 0, cathode G is OFF 
			"1111001" when "0001", -- 1, cathodes B and C are ON
			"0100100" when "0010", -- 2, cathodes C and F are OFF
			"0110000" when "0011", -- 3, cathodes E and F are OFF
			"0011001" when "0100", -- 4, cathodes A, D, and E are OFF
			"0010010" when "0101", -- 5, cathodes B and E are OFF
			"0000010" when "0110", -- 6, cathode B is OFF
			"1111000" when "0111", -- 7, cathodes A, B, and C are ON
			"0000000" when "1000", -- 8, ALL cathodes are ON
			"0010000" when "1001", -- 9, cathode E is OFF
			"0001000" when "1010", -- 10, displays A (10 in Hex), cathode D is OFF
			"0000011" when "1011", -- 11, displays b (11 in Hex), cathodes A and B are OFF
										  -- use a lower case b because capitol B looks like 8
			"1000110" when "1100", -- 12, displays C (12 in Hex), cathodes B, C, and, g are OFF
			"0100001" when "1101", -- 13, displays d (13 in Hex), cathodes A and F are OFF
										  -- use a lower case d because capitol D looks like 0
			"0000110" when "1110", -- 14, displays E (14 in Hex), cathodes B and C are OFF
			"0001110" when others; -- 15, displays F (15 in Hex), cathodes B, C, and D are OFF
			

end arch;
				