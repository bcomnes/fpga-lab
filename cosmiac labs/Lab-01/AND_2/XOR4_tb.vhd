-- Vhdl test bench created from schematic C:\Documents and Settings\Administrator\Desktop\fpga-lab\cosmiac labs\Lab-01\AND_2\XOR_4.sch - Mon Dec 31 13:57:33 2012
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
ENTITY XOR_4_XOR_4_sch_tb IS
END XOR_4_XOR_4_sch_tb;
ARCHITECTURE behavioral OF XOR_4_XOR_4_sch_tb IS 

   COMPONENT XOR_4
   PORT( CX	:	IN	STD_LOGIC; 
          DX	:	IN	STD_LOGIC; 
          AX	:	IN	STD_LOGIC; 
          BX	:	IN	STD_LOGIC; 
          XOR4	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL CX	:	STD_LOGIC:='0';
   SIGNAL DX	:	STD_LOGIC:='0';
   SIGNAL AX	:	STD_LOGIC:='0';
   SIGNAL BX	:	STD_LOGIC:='0';
   SIGNAL XOR4	:	STD_LOGIC;

BEGIN

   UUT: XOR_4 PORT MAP(
		CX => CX, 
		DX => DX, 
		AX => AX, 
		BX => BX, 
		XOR4 => XOR4
   );

-- *** Test Bench - User Defined Section ***
   AX_process:PROCESS
	BEGIN
		AX <= NOT AX;
		WAIT FOR 25 ns;
	END PROCESS;
	
	BX_process:PROCESS
	BEGIN
		BX <= NOT BX;
		WAIT FOR 50 ns;
	END PROCESS;
	
	CX_process:PROCESS
	BEGIN
		CX <= NOT CX;
		WAIT FOR 75 ns;
	END PROCESS;
	
	DX_process: PROCESS
	BEGIN
		DX <= NOT DX;
		WAIT FOR 100 ns;
	END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
