----------------------------------------------------------------------------------
-- Company: Maricopa
-- Engineer: B.M.
-- 
-- Create Date:    17:17:28 07/23/2008 
-- Design Name: Brainless uProcessor 
-- Module Name:    BRAINLESS_uP - Behavioral 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity declaration.   This is where you declare your inputs and outputs
entity BRAINLESS_uP is
    Port ( SYS_CLK : in STD_LOGIC; --50MHz input oscillator to be used by the debouncer
			  CLOCK_BTN : in  STD_LOGIC; --the finger activated clock also used by the debouncer
			  DATA_IN : in  STD_LOGIC_VECTOR (3 downto 0); --four switches for input
           BUFFER_SELECT : in  STD_LOGIC; --toggle switch for the decoder
           RD_WR : in  STD_LOGIC; --read/write flag
           ALU_CONTROL_SIGNALS : in  STD_LOGIC_VECTOR (2 downto 0); --3 bits of control for the ALU
           LOAD_ACC : in  STD_LOGIC; --enable signal for the register
           ACC_2_DATA : in  STD_LOGIC; --enable signals for the buffer
           DATA_OUT : out  STD_LOGIC_VECTOR (3 downto 0); --4 bits of output data
			 --outputs for the Seven Segment
			 seg : out  STD_LOGIC_VECTOR (6 downto 0); --7 bits of output data
			 an : out  STD_LOGIC;
			 an1 : out  STD_LOGIC;
			 an2 : out  STD_LOGIC;
			 an3 : out  STD_LOGIC);
end BRAINLESS_uP;

architecture Behavioral of BRAINLESS_uP is

--declare an ALU component.  Based on the input control signals, the ALU performs different functions
component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
           A_ONLY : in  STD_LOGIC;
			  INVERT : in  STD_LOGIC;
			  ARITH_LOGIC : in  STD_LOGIC;
			  Y : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC);
end component;

--------------------------------------------------------------------------
--This is where we declare all the remaining components.  Components are the black
--boxes we want to use over and over again in our project.  When you add 
--them in here, it adds them as sources in our tree structure shown to the
--left in ISE
--declare a Decoder component.  Based on the enable signals, it outputs a 1 or 2.
component DECODER is
		Port ( A : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

-- declare display controller

component DISP_controller is
		Port ( digit_in : in std_logic_vector(3 downto 0);
           digit_out : out std_logic_vector(6 downto 0));

end component;

--declare a buffer component. If enable equals a 3, output the input
component BUFFER4 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           EN : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

--declare a clock buffer component.  This module takes care of the dirty switches on the board (debounces)
component CLK_PRESS_DEBOUNCER is
	port	(	
			BTN	: in std_logic;
			SYS_CLK	: in	std_logic;
			DEB_BTN	: out std_logic);
end component;

--declare a 4 bit register.  If clear is high, output zeros, otherwise output the input
component REGISTER4 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CLEAR : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end component;



-----------------------------------------------------------------------------------
--declare signals.  This are items we use to trasfer data within the microprocessor
--Signals do no go outside the FPGA.  They are often used to tie components output to 
--inputs and vice versa

signal DUMMY_CLEAR : STD_LOGIC:= '0'; --clear signal for registers
signal DUMMY_EN : STD_LOGIC:= '1'; --enable signal for decoders
signal DUMMY_Cin : STD_LOGIC:= '0'; --dummy signal for ALU.  Not used
signal LOW : STD_LOGIC:= '0'; --used for reseting the LCD
--signal DEB_CLOCK : STD_LOGIC; --debounced clock out of clock buffer
signal REGISTER_OUTPUT : STD_LOGIC_VECTOR( 3 downto 0 ); --output from register4
signal ALU_OUTPUT : STD_LOGIC_VECTOR( 3 downto 0 ); --output from the ALU
signal DECODER_OUTPUT : STD_LOGIC_VECTOR( 1 downto 0 ); --output from decoder
signal ALU_IN : STD_LOGIC_VECTOR( 3 downto 0 ); --input to the ALU
signal BUFFER0_OUTPUT : STD_LOGIC_VECTOR( 3 downto 0 ); --U0 Buffers output
signal BUFFER1_OUTPUT : STD_LOGIC_VECTOR( 3 downto 0 ); --U1 Buffers output
signal TEMP_DATA_OUT : STD_LOGIC_VECTOR ( 3 downto 0 ); --the output of U2Buffer which goes to the LEDs and LCDs
signal DEB_CLOCK: STD_LOGIC; -- output from clock buffer
-----------------------------------------------------------------------------------

begin

--This section is where we create instantiations of the componets.  In the 
--first example, we are creating a unique copy of the ALU called "U0_ALU"
--create an instantiation of the ALU called U0_ALU (for ALU - unit zero )

an <= '0'; -- make anode a contant 1 value
an1 <= '1';
an2 <= '1';
an3 <= '1'; -- disable other 7seg

U0_ALU: ALU
    Port map(
				A				=> ALU_IN, --ALU input
				B				=> REGISTER_OUTPUT, --the output of OU_register4
				Cin			=> DUMMY_Cin, --place holder signal, not currently used
				A_ONLY		=> ALU_CONTROL_SIGNALS(0), --split out the control signals
				INVERT		=> ALU_CONTROL_SIGNALS(1), --as inputs to the ALU
				ARITH_LOGIC	=> ALU_CONTROL_SIGNALS(2),
				Y				=> ALU_OUTPUT, --output from ALU and input to OU_register4
				Cout			=> open --not connected
				);
				
--create an instantiation of the decoder called U0_Decoder (for decoder - unit zero )
U0_DECODER: DECODER
    Port map(
				A	=> BUFFER_SELECT, --control signal for decoder
				EN	=> DUMMY_EN, --control signal for the decoder
				Y	=> DECODER_OUTPUT --output 01 or 10
				);

--This is just a buffer.  A is the input data.  If enable is a "11" then the output is the input
--create the first instantiation of the four bit buffer called U0_Buffer4 (for buffer - unit zero)
U0_BUFFER4: BUFFER4
    Port map(
				A		=> DATA_IN,
				EN(0)	=> DECODER_OUTPUT(0),
				EN(1)	=> RD_WR,
				Y		=> BUFFER0_OUTPUT --output
				);

U1_BUFFER4: BUFFER4
    Port map(
				A		=> DATA_IN,
				EN(0)	=> DECODER_OUTPUT(1),
				EN(1)	=> RD_WR,
				Y		=> BUFFER1_OUTPUT
				);

U2_BUFFER4: BUFFER4
    Port map(
				A		=> REGISTER_OUTPUT,
				EN(0)	=> ACC_2_DATA,
				EN(1)	=> ACC_2_DATA,
				Y		=> TEMP_DATA_OUT
				);

DEBOUNCER : CLK_PRESS_DEBOUNCER
	port map(
				BTN => CLOCK_BTN, --tie a push button to the debuffer.  
				SYS_CLK => SYS_CLK, --tie the 50MHz oscillator on board to the debouncer input
				DEB_BTN => DEB_CLOCK --a stable, non bouncing clock
				);

U0_REGISTER4: REGISTER4
    Port map(
				A		=> ALU_OUTPUT,
				EN		=> LOAD_ACC,
				CLK	=> DEB_CLOCK,
				CLEAR	=> DUMMY_CLEAR,
				Y		=> REGISTER_OUTPUT
				);
				
U0_DISP_CONTROLLER: DISP_controller
				
		Port map(
				digit_in  => ALU_OUTPUT,
            digit_out => seg
				);
				

	
--Main part of the progrem.  When read/write is a one and the first bit of the 
--decoder output is a 1 then the ALU_IN comes from Buffer0_output.  Otherwise, if
--read/write is a 1 and the second bit of the decoder_output is a 1 then ALU_IN
--gets it input from Buffer1_output.  The system is designed so that the decoder_output
--will always be either 01 or 10.
ALU_IN <= BUFFER0_OUTPUT when RD_WR = '1' and DECODER_OUTPUT(0) = '1' else
			 BUFFER1_OUTPUT when RD_WR = '1' and DECODER_OUTPUT(1) = '1';

DATA_OUT <= ALU_OUTPUT; --send data out to the LEDs

end Behavioral;

