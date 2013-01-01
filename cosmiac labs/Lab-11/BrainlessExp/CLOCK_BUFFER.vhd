----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor 
-- Module Name:    Clock_Buffer - Behavioral 
-- Description: 
-- This buffer is designed to debounce the Spartan 3E buttons.
-- Without a buffer the buttons will "bounce" when pressed. This will send
-- 2 maybe 3 high signals each time the button is pressed. Using a counter
-- that is triggered off the Spartan 3E's 50MHz oscillator, each time the
-- button is pressed a delay of 0.23 seconds is introduced to allow the
-- signal to stop "bouncing".
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CLK_PRESS_DEBOUNCER is
port	(
		BTN	:	in	std_logic;
		SYS_CLK	:	in	std_logic;
		DEB_BTN	:	out std_logic
		);
end CLK_PRESS_DEBOUNCER;

architecture behavioral of CLK_PRESS_DEBOUNCER is

type states is (idle, low, high);
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

state_machine: process (SYS_CLK)
begin

	if SYS_CLK'event and SYS_CLK='1' then
		case state is 
			when idle => 	
								if BTN = '0' then
									state <= low;
								else
									state <= idle;
								end if;
			when low =>
								if (BTN = '1' and stop_counter = '0') then
									state <= high;
									DEB_BTN <= '0';
									run_counter <= '1';
								else
									state <= low;
									DEB_BTN <= '0';
									run_counter <= '0';
								end if;
											
			when high =>
								if stop_counter = '1' then
									state <= idle;
									DEB_BTN <= '1';
									run_counter <= '0';
								else
									state <= high;
									DEB_BTN <= '0';
									run_counter <= '1';
								end if;	    
				
			when others =>
								DEB_BTN <= '0';
								run_counter <= '0';
								state <= idle;
			end case;	
	end if;						
	
end process state_machine;

-- When the state machine goes 'high', it starts the counter (run_counter = 1).
-- The counter will count off from 0 to 11,500,000. When it is
-- done it will give stop_counter a '1', which will output 1 and change
-- state to 'low'.
count_machine: process(SYS_CLK, run_counter)
begin
		if run_counter = '1'	then
			if SYS_CLK'event and SYS_CLK = '1' then
				if counter = x"000002" then--x"AF79E0" then	-- this hex value is 11,500,000
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