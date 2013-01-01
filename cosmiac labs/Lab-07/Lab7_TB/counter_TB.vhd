-- ensure your test bench declairs the same libraries and packages used with your source files
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------------
ENTITY counter_TB IS
END counter_TB;
-------------------------------------------------------------------------------------------------------
ARCHITECTURE behavior OF counter_TB IS 
    -- Component Declaration for the Unit Under Test (UUT); 
	 -- component is counter since we are testing the counter.vhd file
	 -- ports are declared here, they are copies of the i/o ports from counter
    COMPONENT counter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pause : IN  std_logic;
         count_out : OUT  std_logic_vector(15 downto 0);
         count_blink : OUT  std_logic;
         an : OUT  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;

   --Inputs; set to the desired starting value
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';		-- change to 1, we want to start the test with the reset active
   signal pause : std_logic := '0';

 	--Outputs
   signal count_out : std_logic_vector(15 downto 0);
   signal count_blink : std_logic;
   signal an : std_logic_vector(3 downto 0);
   signal sseg : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clk => clk,
          reset => reset,
          pause => pause,
          count_out => count_out,
          count_blink => count_blink,
          an => an,
          sseg => sseg
        );

   -- Clock process definitions
   clk_proc : process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Reset process
   reset_proc : process
   begin		
      -- hold reset state for 22 ns.
      wait for 22 ns;
        reset <='0';
        wait for 1000 ns;
        reset <='1';
        wait for 18 ns;
        reset <='0';
        wait;
   end process;

	-- Pause process
	pause_proc : process
	begin
		wait for 500 ns;
		pause <= '1';
		wait for 50 ns;
		pause <= '0';
		wait for 1000 ns;
	end process;
	
END;
