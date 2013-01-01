library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity sequence is
port(
	clk : in std_logic;
	reset : in std_logic;
	x: in std_logic;
	z : out std_logic;
	a : out std_logic;
	b : out std_logic;
	c : out std_logic;
	d : out std_logic;
	e : out std_logic;
	f : out std_logic);
end sequence;

architecture behavioral of sequence is

-- This is similar to a variable declaration. The variable names are in
-- the parenthesis and they are of type 'state_type'.
type state_type is (a1, b1, c1, d1, e1, f1);

-- Create signals "state" and "next_state". These signals carry 'state_type'
-- signals which were declared above.
signal state, next_state : state_type;

begin

-- This is the first of three processes we will define in our sequence
-- detector. Here we define reset and state changes occuring on the
-- rising edge of a clock signal (clocked synchronous state machine)
state_register: process (clk, reset)
  begin
    if (reset = '1') then	--if reset is high, goto state a1
       state <= a1;
    elsif (clk'event and clk = '1') then 	--if not, and rising 
       state <= next_state;					--edge, go to next state
    end if;
end process;  

-- This second process steps through each state based on state diagram.
-- The sequence is "10010"
next_state_func: process (x, state)
begin 
  case state is 
      when a1 =>
          if x = '1' then
             next_state <= b1;
          else 
             next_state <= a1;
          end if;
      when b1 =>
           if x = '1' then
             next_state <= b1;
           else
             next_state <= c1;
           end if;
      when c1 =>
           if x = '1' then
              next_state <= b1;
           else 
              next_state <= d1;
           end if;
      when d1 =>
           if x ='1' then
              next_state <= e1;
           else
              next_state <= a1;
           end if;
      when e1 =>
           if x = '1' then
              next_state <= b1;
           else
              next_state <= f1;
           end if;
      when f1 =>
           if x = '1' then
              next_state <= b1;
           else
              next_state <= a1;                       
           end if;
      end case;
end process;

-- This process controls the output of the sequence detector.
-- Each state has it's own output along with 'z' which indicates
-- the entire sequence 10010 has been detected.
output_func:  process (x, state)
  begin
  case state is 
      when a1 => z <= '0';
           a <= '1';
           b <= '0';
           c <= '0';
           d <= '0';
           e <= '0';
           f <= '0';
      when b1 => z <= '0';
           a <= '0';
           b <= '1';
           c <= '0';
           d <= '0';
           e <= '0';
           f <= '0';
      when c1 => z <= '0';
           a <= '0';
           b <= '0';
           c <= '1';
           d <= '0';
           e <= '0';
           f <= '0';
      when d1 => z <= '0';
           a <= '0';
           b <= '0';
           c <= '0';
           d <= '1';
           e <= '0';
           f <= '0';
      when e1 => z <= '0';
           a <= '0';
           b <= '0';
           c <= '0';
           d <= '0';
           e <= '1';
           f <= '0';
      when f1 => z <= '1';
           a <= '0';
           b <= '0';
           c <= '0';
           d <= '0';
           e <= '0';
           f <= '1';
    end case;
  end process;

end behavioral;