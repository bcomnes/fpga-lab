-- Top sequence puts the sequence detector and clock buffer
-- into a box called top_sequence. There is no circuit behavior
-- defined in this file. This file takes the components and wires
-- them together.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- This describes the box that the components go into
entity top_sequence is
    Port ( dig_clk : in  STD_LOGIC;
           btn_clk : in  STD_LOGIC;
           X : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
			  buttonclock: out  STD_LOGIC;
           Z : out  STD_LOGIC);
end top_sequence;


-- Here is where we put things together
architecture Structural of top_sequence is


-- This is the sequence detector
component sequence
port(clk, reset, x: in std_logic;
	z, a, b, c, d, e, f: out std_logic);
end component;

-- This is the clock buffer
component clock_buffer
port	(btn, clk : in	std_logic;
	clk_o : out std_logic);
end component;

-- This is a wire that connects the output of the clock buffer to
-- the clock input of the sequence detector deb_clk stands for
-- debounced clock.
signal deb_clk : std_logic;

begin

-- Here are the instantiation or the wiring together of the components.
debounce : clock_buffer
port map(
	btn => btn_clk,
	clk => dig_clk,
	clk_o => deb_clk);
	
sequence_recorder : sequence
port map(
	clk => deb_clk,
	reset => RESET,
	x => X,
	a => A,
	b => B,
	c => C,
	d => D,
	e => E,
	f => F,
	z => Z);

buttonclock <= deb_clk;

end Structural;

