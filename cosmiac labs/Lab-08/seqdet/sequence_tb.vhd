LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT sequence
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		x : IN std_logic;          
		z : OUT std_logic;
		a : OUT std_logic;
		b : OUT std_logic;
		c : OUT std_logic;
		d : OUT std_logic;
		e : OUT std_logic;
		f : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic;
	SIGNAL RESET :  std_logic;
	SIGNAL X :  std_logic;
	SIGNAL Z :  std_logic;
	SIGNAL A :  std_logic;
	SIGNAL B :  std_logic;
	SIGNAL C :  std_logic;
	SIGNAL D :  std_logic;
	SIGNAL E :  std_logic;
	SIGNAL F :  std_logic;

	constant CLK_PERIOD : time:= 20 ns;
BEGIN

	uut: sequence PORT MAP(
		clk => CLK,
		reset => RESET,
		x => X,
		z => Z,
		a => A,
		b => B,
		c => C,
		d => D,
		e => E,
		f => F
	);


-- *** Test Bench - User Defined Section ***
--
--  This is where I begin inserting my processes

--Clock for CLK
--  /All I want is to toggle the clock off and on

CLOCK: process
   begin
     CLK <= '0';
       wait for CLK_PERIOD;
     CLK <= '1';
       wait for CLK_PERIOD;
end process;

--Clock for RESET
--  For reset I wanted to tie it high for a 
--  short period of time and then tie it low
--  for a really long time.

CLOCK2: process
   begin
     reset <= '1';
       wait for CLK_PERIOD*4;
     reset <= '0';
       wait for CLK_PERIOD*500;
end process;


--Clock for x
--  the term clock is used here to mean something that
--  repeats.  What I have done is to set up x to 
--  repeat 100100 over and over again.

CLOCK3: process
   begin
     x <= '1';
       wait for CLK_PERIOD;
     x <= '0';
       wait for CLK_PERIOD;
     x <= '0';
       wait for CLK_PERIOD;
     x <= '1';
       wait for CLK_PERIOD;
     x <= '0';
       wait for CLK_PERIOD;
     x <= '0';
       wait for CLK_PERIOD;
	  

end process;
-- *** End Test Bench - User Defined Section ***

END behavior;