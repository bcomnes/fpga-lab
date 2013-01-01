--Synthesizable VHDL files are composed of at least two and usually three units: 
--
--1.  Library (not necessary, but usually included): 
--Libraries are collections of code (functions) that are used frequently. 
--Each library may have several packages. 
--You must declare which package and function you want to use (or .all to use all functions 
--in a package). For example, the IEEE.STD_LOGIC_ARITH package defines arithmetic functions 
--such as sum (+), subtract (-), multiply (*), absolute value (ABS), etc. 
--
--2.  Entity:	
--A list describing all input and output ports. Entities use the following syntax:
--			ENTITY entity_name IS
--				PORT (
--					port_name1, port_name2 : signal_mode_(in_or_out) signal_type;
--					port_name3, port_name4 : signal_mode_(in_or_out) signal_type;
--					...
--					);
--			END entity_name; 
--This Lab's module uses mode in and out, and types std_logic and std_logic_vector. 
--Std_logic is a single bit object, and std_logic_vector is a multiple bit object. 
--In this module (3 downto 0) indicates a four bit bus (0, 1, 2, 3). 
--
--3.  Architecture:	
--Describes how the module operates. Signals are defined before the begin statement. 
--In this module the work is done inside of a process. 
--This process contains a sensitivity list - process (sensitivity list) - clk. This mean 
--that the only time the process runs is when a rising edge clock event happens. Work within 
--a process is acted upon sequentially. Multiple processes in a module are acted upon 
--concurrently (at the same time). Processes are covered in more detail in Lab 5. 

--------------------------------------------------------------------------------------------------------------------
-- Library Declarations
library IEEE;																		--	Standard IEEE library 
use IEEE.STD_LOGIC_1164.ALL;													--	use all of STD_LOGIC_1164 package functions
use IEEE.STD_LOGIC_ARITH.ALL;													--	use all of STD_LOGIC_ARITH package functions
use IEEE.STD_LOGIC_UNSIGNED.ALL;												--	use all of STD_LOGIC_UNSIGNED package functions
--------------------------------------------------------------------------------------------------------------------
-- Entity Declarations
entity regBuf is port (
								clk: in std_logic;										-- clock
								enable: in std_logic;									-- clock enable
								input: in std_logic_vector (3 downto 0);			-- 4-bit input 
								bufferOut: out std_logic_vector (3 downto 0);	-- 4-bit buffer output
								registerOut: out std_logic_vector (3 downto 0)	-- 4-bit register output
								); 
end regBuf;
--------------------------------------------------------------------------------------------------------------------
-- Architecture Declarations
Architecture behavioral of regBuf is 			-- start behavior of regBuf Entity
begin
bufferOut <= input; 									-- send the input to bufferout

process (clk) begin  								--	begin the process, clk is sensitive

	if (clk'event and clk = '1') then  			-- when there is a clock event (clk'event)
															-- and it is a rising edge clk = '1'
		if enable = '1' then 						-- and if the enable button is pressed
			registerOut <= input;					-- then registerOut gets input
		end if;											-- end the second if statement									
	end if;												-- end the first if statement 
end process; 											--	end process
end behavioral;										--	end behavior
--------------------------------------------------------------------------------------------------------------------