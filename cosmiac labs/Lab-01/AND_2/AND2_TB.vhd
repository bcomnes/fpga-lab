-- Vhdl test bench created from schematic C:\Documents and Settings\Administrator\Desktop\fpga-lab\cosmiac labs\Lab-01\AND_2\AND_2.sch - Mon Dec 31 13:32:47 2012
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY AND_2_AND_2_sch_tb IS
END AND_2_AND_2_sch_tb;
ARCHITECTURE behavioral OF AND_2_AND_2_sch_tb IS 

   COMPONENT AND_2
   PORT( A	:	IN	STD_LOGIC; 
          B	:	IN	STD_LOGIC; 
          OUT1	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL A	:	STD_LOGIC:='0';
   SIGNAL B	:	STD_LOGIC:='0';
   SIGNAL OUT1	:	STD_LOGIC;

BEGIN

   UUT: AND_2 PORT MAP(
		A => A, 
		B => B, 
		OUT1 => OUT1
   );

-- *** Test Bench - User Defined Section ***
   -- offset timeing of inputs similate input options
	-- output=1 only when A = B = 1
	A_process:PROCESS
	BEGIN
		A <= NOT A;
		WAIT FOR 25 ns;
	END PROCESS;
	
	B_process:PROCESS
	BEGIN
		B <= NOT B;
		WAIT FOR 50 ns;
	END PROCESS;
	
-- *** End Test Bench - User Defined Section ***

END;
