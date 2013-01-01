-- This buffer is designed to debounce the Spartan 3E buttons.
-- Without a buffer the buttons will "bounce" when pressed. This will send
-- 2 maybe 3 high signals each time the button is pressed. Using a counter
-- that is triggered off the Spartan 3E's 50MHz oscillator, each time the
-- button is pressed a delay of 0.23 seconds is introduced to allow the
-- signal to stop "bouncing".

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_buffer is
port	(
		clk	:	in	std_logic;
		btn	:	in	std_logic;
		clk_o	:	out	std_logic
		);
end clock_buffer;

architecture behavioral of clock_buffer is

type states is (low, high);
signal state   : states;
signal stop_counter  : std_logic := '0';
signal run_counter   :std_logic;
signal counter :std_logic_vector(23 downto 0);


begin

-- Here is the state machine for the buffer. By
-- default the state is 'low' which means the buffer
-- is standing by and waiting for the button to be pressed.
-- When the button is pressed the state machine switches to the 'high'
-- state and begins the counter. When the counter finishes a '1' is
-- output and the state goes back to 'low'. All this is synchronized
-- to the rising edge of the clk signal.

state_machine: process (clk)
begin

	if clk'event and clk='1' then
		case state is 
			when low =>
				if (btn = '1' and stop_counter = '0') then
					state <= high;
					clk_o <= '0';
					run_counter <= '1';
				else
					state <= low;
					clk_o <= '0';
					run_counter <= '0';
				end if;
							
			when high =>
				if stop_counter = '1' then
					state <= low;
					clk_o <= '1';
					run_counter <= '0';
				else
					state <= high;
					clk_o <= '0';
					run_counter <= '1';
				end if;	    

			when others =>
				clk_o <= '0';
				run_counter <= '0';
				state <= low;
			end case;	
	end if;						
	
end process state_machine;

-- When the state machine goes 'high', it starts the counter (run_counter = 1).
-- The counter will count off from 0 to 11,500,000. When it is
-- done it will give stop_counter a '1', which will output 1 and change
-- state to 'low'.
count_machine: process(clk, run_counter)
begin
		if run_counter = '1'	then
			if clk'event and clk = '1' then
				if counter = x"AF79E0" then	-- this hex value is 11,500,000
					stop_counter <= '1';			--	each cycle is 20 ns
				else 									-- total time of counter is
					stop_counter <= '0';			-- 11,500,000 * 20 ns = 0.23 sec
				end if;
				counter <= counter + 1;
			end if;
		else 
			counter <= x"000000";
		end if;
	end process count_machine;



end behavioral;