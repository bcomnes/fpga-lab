-------------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------------
ENTITY display_controller_TB IS
END display_controller_TB;
 
ARCHITECTURE behavior OF display_controller_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display_controller
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         HEX3 : IN  std_logic_vector(3 downto 0);
         HEX2 : IN  std_logic_vector(3 downto 0);
         HEX1 : IN  std_logic_vector(3 downto 0);
         HEX0 : IN  std_logic_vector(3 downto 0);
         AN : OUT  std_logic_vector(3 downto 0);
         SSEG : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '1';		
	-- change to 1, we want to start the test with the reset active
   signal HEX3 : std_logic_vector(3 downto 0) := (others => '0');
   signal HEX2 : std_logic_vector(3 downto 0) := (others => '0');
   signal HEX1 : std_logic_vector(3 downto 0) := (others => '0');
   signal HEX0 : std_logic_vector(3 downto 0) := (others => '0');
 	--Outputs
   signal AN : std_logic_vector(3 downto 0);
   signal SSEG : std_logic_vector(6 downto 0);
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: display_controller PORT MAP (
          CLK => CLK,
          RESET => RESET,
          HEX3 => HEX3,
          HEX2 => HEX2,
          HEX1 => HEX1,
          HEX0 => HEX0,
          AN => AN,
          SSEG => SSEG
        );
    -- Clock process definitions
   CLK_proc : process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Reset process
   RESET_proc : process
   begin		
      -- hold reset state for (10 * 5) ns
		wait for clk_period * 5;
      reset <='0';
      wait for clk_period * 50;
   end process;
	
	-- Stimulus process
	stim_proc : process
	begin
		hex3 <= x"0";						-- all anodes display 0
		hex2 <= x"0";						-- the preceding x indicates hexidecimal
		hex1 <= x"0";						-- therefore, x"0" is the same as "0000"
		hex0 <= x"0";						-- if we had x"00" that would indicate "0000 0000"
		wait for clk_period * 2;
		hex3 <= x"1";						-- all anodes display 1
		hex2 <= x"1";						-- x"1" is the same as "0001"
		hex1 <= x"1";						-- if we had x"11" that would indcate "0001 0001"
		hex0 <= x"1";
		wait for clk_period * 2;
		hex3 <= "1111";					-- all anodes display ffff
		hex2 <= "1111";
		hex1 <= "1111";
		hex0 <= "1111";
		wait for clk_period * 2;
		hex3 <= "0000";					-- anode 3 displays 0
		hex2 <= "0101";					-- anode 2 displays 5
		hex1 <= "1100";					-- anode 1 displays C
		hex0 <= "0000";					-- anode 0 displays 0
		wait for clk_period * 2;
	end process;
END;
