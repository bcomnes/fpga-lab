--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:26:20 01/02/2013
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/FULL_ADDER_TB.vhd
-- Project Name:  FULL_ADDER_SCH
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FULL_ADDER
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
 
ENTITY FULL_ADDER_TB IS
END FULL_ADDER_TB;
 
ARCHITECTURE behavior OF FULL_ADDER_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FULL_ADDER
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         Cin : IN  std_logic;
         SUM : OUT  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal Cin : std_logic := '0';

 	--Outputs
   signal SUM : std_logic;
   signal Cout : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FULL_ADDER PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          SUM => SUM,
          Cout => Cout
        );


   -- Stimulus process
	A_proc: process
	begin
		A <= not A;
		wait for 25 ns;
	end process;
	
	B_proc: process
		begin
		b <= not b;
		wait for 50 ns;
	end process;
	
	Cin_proc: process
		begin
		Cin <= not Cin;
		wait for 100 ns;
	end process;

END;
