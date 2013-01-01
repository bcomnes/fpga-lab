--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:37:07 05/05/2011
-- Design Name:   
-- Module Name:   E:/BRAINLESS_NEW/BrainlessExp/Brainless_uP_tb.vhd
-- Project Name:  BrainlessExp
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BRAINLESS_uP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Brainless_uP_tb IS
END Brainless_uP_tb;
 
ARCHITECTURE behavior OF Brainless_uP_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BRAINLESS_uP
    PORT(
         SYS_CLK 			: IN  std_logic;
         CLOCK_BTN 		: IN  std_logic;
         DATA_IN 			: IN  std_logic_vector(3 downto 0);
         BUFFER_SELECT 	: IN  std_logic;
         RD_WR 			: IN  std_logic;
         ALU_CONTROL_SIGNALS : IN  std_logic_vector(2 downto 0);
         LOAD_ACC 		: IN  std_logic;
         ACC_2_DATA 		: IN  std_logic;
         DATA_OUT 		: OUT  std_logic_vector(3 downto 0);
			SEG 				: OUT  std_logic_vector (6 downto 0); 
			AN 				: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SYS_CLK : std_logic := '0';
   signal CLOCK_BTN : std_logic := '0';
   signal DATA_IN : std_logic_vector(3 downto 0) := (others => '0');
   signal BUFFER_SELECT : std_logic := '0';
   signal RD_WR : std_logic := '0';
   signal ALU_CONTROL_SIGNALS : std_logic_vector(2 downto 0) := (others => '0');
   signal LOAD_ACC : std_logic := '0';
   signal ACC_2_DATA : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic_vector(3 downto 0);
	signal SEG :   	std_logic_vector (6 downto 0); 
	signal AN :  		std_logic;

   -- Clock period definitions
   constant SYS_CLK_period : time := 2 ns;
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BRAINLESS_uP PORT MAP (
          SYS_CLK => SYS_CLK,
          CLOCK_BTN => CLOCK_BTN,
          DATA_IN => DATA_IN,
          BUFFER_SELECT => BUFFER_SELECT,
          RD_WR => RD_WR,
          ALU_CONTROL_SIGNALS => ALU_CONTROL_SIGNALS,
          LOAD_ACC => LOAD_ACC,
          ACC_2_DATA => ACC_2_DATA,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   SYS_CLK_process :process
   begin
		SYS_CLK <= '0';
		wait for SYS_CLK_period / 2;
		SYS_CLK <= '1';
		wait for SYS_CLK_period / 2;
   end process;
 
  
 
   -- input stimulus process definitions
	ALU_Process: process
	begin
		DATA_IN <= "0010";
		wait for SYS_CLK_period;
		RD_WR <='1';
		wait for SYS_CLK_period*2;
		RD_WR <='0';
		wait for SYS_CLK_period*2;
		LOAD_ACC <= '1';
		wait for SYS_CLK_period*2;
		CLOCK_BTN <= '1';
		wait for SYS_CLK_period*2;
		CLOCK_BTN <= '0';
		wait for SYS_CLK_period*2;
		LOAD_ACC <= '0';
		wait for SYS_CLK_period*2;
		DATA_IN <= "0001";
		wait for SYS_CLK_period;
		RD_WR <='1';
		wait for SYS_CLK_period*2;
		RD_WR <='0';
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "000";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "001";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "010";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "011";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "100";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "101";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "110";
		wait for SYS_CLK_period*2;
		ALU_CONTROL_SIGNALS <= "111";
		wait for SYS_CLK_period*2;
	end process;
END;
