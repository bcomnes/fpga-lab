--This is a VHDL testbench.  It is used to stimulate the inputs to the source.
--file we are testing.  A good design practice is to create a testbench
--for each component you are developing. 

--Build a component, test a component, build a system, test a system. 

--One thing to remember here is that VHDL was not created for FPGAs. It is 
--very large and powerful language and only one small portion of it is used 
--for FPGA design. In that larger scope, there are two types of VHDL: synthesizable 
--and non-synthesizable. 

--Synthesizable VHDL is what can be converted into FPGA logic. 
--The other cannot. Source code is synthesizable and test benches are not. 
--A test bench has only one purpose and that is to stimulate the inputs of the 
--source file to see what will be the outputs. A good habit is to name the test 
--benches the same as your source files appending _TB to the end of the file name. 
--As an example, if your source file is bigwork.vhd then your testbench should be 
--named bigwork_tb.vhd.

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS 																--this is standard and as always the same
END testbench;

ARCHITECTURE testbench_arch OF testbench IS								--Begin Architectue of testbench

COMPONENT regBuf 																	--this is virtually copied and pasted 
																						--from the entity in the source file
PORT (
		clk: in std_logic;														--one bit
		enable: in std_logic;													--one bit
		input: in std_logic_vector (3 downto 0); 							--four bit bus
		bufferOut: out std_logic_vector (3 downto 0);					--four bit bus
		registerOut: out std_logic_vector (3 downto 0)					--four bit bus
		);
END COMPONENT;

--develop signals to stimulate
SIGNAL clk 	: std_logic := '0'; 												--this is standard and sets all 
																						--stimulators to zero := in VHDL means equals
SIGNAL enable : std_logic := '0';				
SIGNAL input : std_logic_vector (3 downto 0) := x"0";	
SIGNAL bufferOut : std_logic_vector (3 downto 0):= x"0";
SIGNAL registerOut : std_logic_vector(3 downto 0) := x"0";

	--Note the difference between ‘0’ and x”0”. The ‘0’ means zero 
	--as one bit. The x”0” means assign a zero as a hex value. 
	--It could have been as “000”. When you put the x in front of it , it means hex.
	
--UUT unit under test
BEGIN
	UUT : regBuf

	--map signals on right to entitys on the left
	PORT MAP (  																	--This is standard and always used.
		clk => clk,																	--clk gets assigned to clk
		enable => enable,															--enable gets enable
		input => input,															--input gets assigned to input
		bufferOut => bufferOut,													--bufferOut gets assigned to bufferOut
		registerOut => registerOut												--registerOut gets assigned to registerOut
		);

--There are three processes: 1) signal_clk, 2) enable_input, 3) signal_input. 
--Both run concurrently (at the same time).
	signal_clk: process															--signal_clk is the clk process
	begin
		clk <= NOT clk; 															--Lines 69 - 70 repeat changing the clk
		wait for 1 ns; 															--from low to high (clk not clk) every 1 ns 
	end process;
	
	enable_input: process														--enable_input process 
	begin
		enable <= NOT enable;													--same as the clk, switching enable from low to high
		wait for 2 ns;
	end process;

	signal_input: process 														--signal_input is the input process
	begin
		input <= x"0"; 															--assigns 0000 to input then waits for 3 ns
		wait for 3 ns;
		
		input <= x"1";  															--next, assigns 0001 (1 in 4-bit binary)to input then 
		wait for 3 ns;  															--to input then waits for another 3 ns
		
		input <= x"2";  															--next, assigns 0010 (2 in 4-bit binary)to input then 
		wait for 3 ns; 															--to input then waits for another 3 ns
		
		input <= x"3";  															--finally assigns 0011(2 in 4-bit binary)to input then 
		wait for 3 ns; 															--to input then waits for another 3 ns
		
	end process;																	--process ends

END testbench_arch;																--ends testbench
