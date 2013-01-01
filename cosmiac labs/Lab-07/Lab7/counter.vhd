library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


--------------------------------------------------------------------------------------------------------------
entity counter is
    Port ( CLK : in  STD_LOGIC;												-- 100MHz clock
           RESET : in  STD_LOGIC;											-- reset button
           PAUSE : in  STD_LOGIC;											-- pause button
           COUNT_OUT : out  STD_LOGIC_VECTOR (15 downto 0);			-- 16 bit counter on the LEDs which mirrors 
																						-- the counting on the seven-segment display 
																						-- in binary instead of hex
			  COUNT_BLINK : out STD_LOGIC ;									-- displays the rate at which the counters are counting
			  AN: out STD_LOGIC_VECTOR(3 downto 0);						-- four digit anode display
			  SSEG: out STD_LOGIC_VECTOR(6 downto 0));					-- seven cathodes for each of the four anodes
			  			  
end counter;
--------------------------------------------------------------------------------------------------------------

architecture Behavioral of counter is

-- Include the display_controller.vhd as a component in counter.vhd
-- This will connect the anodes to the counting LED's of the counter proccesses
component display_controller is												-- see display_controller.vhd for 
	port(																				-- descriptions of these ports
		CLK, RESET: in std_logic;
		HEX3, HEX2, HEX1, HEX0: in std_logic_vector(3 downto 0);
		AN: out std_logic_vector(3 downto 0);
		SSEG: out std_logic_vector(6 downto 0));
end component; 

-- create signals used for the counter.vhd processes 
-- TEMP_COUNT is used for the counter
-- SLOW_CLK and CLK_DIVIDER are used to slow the speed of the CLK so that the anode display
	-- flashes at a speed that is discernable to the human eye
	-- ... see CLK_DIVISION and COUNTER process for further explanation  
signal TEMP_COUNT : std_logic_vector(15 downto 0) := x"0000"; 		-- counter
signal SLOW_CLK : std_logic ;													-- new 'slow' clock that is used instead of the acutal CLK
signal CLK_DIVIDER : std_logic_vector(23 downto 0) := x"000000"; 	-- 24-bit divider, x = hex (16 bits) + 6 zeros = 24
		
		
-- map the ports of the display_controller.vhd to the counter.vhd
begin
DISPLAY_OUT : display_controller
		port map(
		CLK	=> CLK, 								-- display_controller CLK gets counter CLK
		RESET	=> RESET,							-- display_controller RESET gets counter RESET
		HEX3	=> TEMP_COUNT (15 downto 12), --	display_controller HEX3 gets counter signal TEMP_COUNT, bits 15-12
		HEX2	=> TEMP_COUNT (11 downto 8),  --	display_controller HEX2 gets counter signal TEMP_COUNT, bits 11-8
		HEX1	=> TEMP_COUNT (7 downto 4),  	--	display_controller HEX1 gets counter signal TEMP_COUNT, bits 7-4
		HEX0	=> TEMP_COUNT (3 downto 0), 	--	display_controller HEX0 gets counter signal TEMP_COUNT, bits 3-0
		AN	=> AN, 									-- display_controller AN gets counter AN
		SSEG => SSEG 								-- display_controller SSEG gets counter SSEG
		); 

-- The next two processes are the 'driving' instructions of counter.vhd
-- The processes run in parallel (concurrently)

-- CLK_DIVISION process	creates a slower clock by incrementing a 24-bit signal (CLK_DIVIDER) by 1 with every rising
-- edge of the board's clock. The SLOW_CLK signal is sent 21st bit CLK_DIVIDER. This bit doesn't change to 1 until
-- after 2,097,152 rising edges of the board's clock (0010 0000 0000 0000 0000 0000). 
-- COUNT_BLINK changes to 1 after 8,388,608 clock cycles. 
-- What this means is that it takes a while for SLOW_CLK and COUNT_BLINK to change states from 0 to 1.

CLK_DIVISION : process (CLK, CLK_DIVIDER)		-- sensitive to CLK and CLK_DIVIDER
															-- everytime an event occurs on one of these signals the process runs 
begin
	if CLK'event and CLK ='1' then				-- if there is a rising edge of the board's CLK
		CLK_DIVIDER <= CLK_DIVIDER + 1;			-- increment CLK_DIVIDER +1
	end if;											
	SLOW_CLK <= CLK_DIVIDER(21);					-- SLOW_CLK gets bit 21 of CLK_DIVIDER
	-- ***************************************************************************** --
	-- for the test bench change SLOW_CLK <= CLK_DIVIDER to 0, back to 21 for compile
	-- ***************************************************************************** --
	COUNT_BLINK <= CLK_DIVIDER(23);				--	COUNT_BLINK gets bit 23 of CLK_DIVIDER
															-- COUNT_BLINK is merely a single LED that flashes as CLK_DIVIDER 
															-- increments
															-- It is for show purposes only
end process;											-- end of the CLK_DIVISION process


-- COUNTING process controls the RESET, PAUSE, and counting functionality of the board.
-- 
COUNTING : process(RESET, PAUSE, SLOW_CLK, TEMP_COUNT)	-- sensitive to RESET, PAUSE, SLOW_CLK, TEMP_COUNT
																			-- everytime an event occurs on one of these signals the process 
																			-- runs 
begin
	-- RESET control 
	if RESET = '1' then												-- when the reset button is pressed
		TEMP_COUNT <= x"0000";										-- set TEMP_COUNT = 0
		
	-- PAUSE control
	elsif PAUSE = '1' then											-- or if the pause switch is on
		TEMP_COUNT <= TEMP_COUNT;									-- hold the display at the current value of TEMP_COUNT
		
	else 																	-- Otherwise (reset and pause are NOT activated)
	-- counter
		if SLOW_CLK'event and SLOW_CLK= '1' then				-- when there is a rising edge of SLOW_CLK (SLOW_CLK equals 1)
			if TEMP_COUNT < 65535 then 							-- and TEMP_COUNT is less than 65535 (FFFF in hexidecimal)
				TEMP_COUNT <= TEMP_COUNT + 1;						-- increment TEMP_COUNT by 1
			else															-- otherwise (TEMP_COUNT is greater than 65535)
				TEMP_COUNT <= x"0000";								-- set TEMP_COUNT back to 0
			end if;
		end if;
	end if;

COUNT_OUT <= TEMP_COUNT;											-- COUNT_OUT gets TEMP_COUNT
																			-- COUNT_OUT only displays the 4 LSB (see UCF)
																			-- recall that TEMP_COUNT is also ported to 
																			-- HEX3, 2, 1, and 0 in the port map for the 
																			-- display controller

end process;
	
end Behavioral;

