----------------------------------------------------------------------------------
-- SECURITY.vhd
-- 
-- Create Date:    7/6/2011
-- Status: 				*** Operation verified with NEXYS2-1200

-- Project Name:   Security State Machine
-- Target Devices: NEXYS2-1200
-- Tool versions:  Win7 / Xilinx ISE 12.1
-- Description: Sample solution for Security State Machine
--						* This is the top level module that pulls together all sub-level modules 
--
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SECURITY is
port (
		CLK : in std_logic;
		ARM : in std_logic;
		FRONT_DOOR: in std_logic;
		REAR_DOOR: in std_logic;
		WINDOW: in std_logic;
		SIREN : out std_logic;
		
		ARM_IND : out std_logic;
		FRONT_DOOR_IND: out std_logic;
		REAR_DOOR_IND: out std_logic;
		WINDOW_IND: out std_logic;		
		
      CATHODE : out  STD_LOGIC_VECTOR (7 downto 0);
		ANODE_CONTROL :out  STD_LOGIC_VECTOR (3 downto 0)		
		);
end entity SECURITY;

architecture RTL of SECURITY is

component FSM
    Port ( CLK : in  STD_LOGIC;
		     CLK_DIV:in  STD_LOGIC;
           ARM : in  STD_LOGIC;
           FRONT_DOOR : in  STD_LOGIC;
           REAR_DOOR : in  STD_LOGIC;
           WINDOW : in  STD_LOGIC;
			  RUN_TIMER:out  STD_LOGIC;		  
           SIREN : out  STD_LOGIC);
end component;

component TIMER_DISPLAY
	Port (CLK: in STD_LOGIC;
			CLK_DIV: out STD_LOGIC;
			RUN_TIMER: in STD_LOGIC;     -- *** RUN_TIMER is output from FSM module
			ADDR: out STD_LOGIC_VECTOR(3 downto 0);    -- to MEM16 for 7-segment LED Driver using table look-up  
			ANODE_CONTROL: out STD_LOGIC_VECTOR(3 downto 0)   -- for 7-segment LEDs
			);			
end component;

component MEM16
	Port (ADDR: in std_logic_vector (3 downto 0);
			DATA: out STD_LOGIC_VECTOR(7 downto 0));	-- DATA to control Cathodes of 7-segment LEDs		
end component;

component INDICATORS
    Port ( ARM : in  STD_LOGIC;
           FRONT_DOOR : in  STD_LOGIC;
           REAR_DOOR : in  STD_LOGIC;
           WINDOW : in  STD_LOGIC;
			  
           ARM_SIG : out  STD_LOGIC;
           FRONT_DOOR_SIG : out  STD_LOGIC;
           REAR_DOOR_SIG : out  STD_LOGIC;
           WINDOW_SIG : out  STD_LOGIC);
end component;

--signal CE_SIG: std_logic;

signal CLK_DIV_SIG: std_logic;
signal ADDR_BUS: std_logic_vector(3 downto 0);        

signal RUN_SIG: std_logic;

begin

	INDICATORS_INST_0: INDICATORS port map(
				ARM => ARM,
				FRONT_DOOR => FRONT_DOOR,
	         REAR_DOOR =>  REAR_DOOR ,
				WINDOW =>  WINDOW, 
			  
				ARM_SIG => ARM_IND,
				FRONT_DOOR_SIG =>  FRONT_DOOR_IND, 
				REAR_DOOR_SIG => REAR_DOOR_IND,
				WINDOW_SIG => WINDOW_IND
			  ); 
	
	TIMER_DISPLAY_INST_0: TIMER_DISPLAY  port map (
			CLK=>CLK,
 			CLK_DIV => CLK_DIV_SIG,
			RUN_TIMER => RUN_SIG,
			ADDR => ADDR_BUS,
			ANODE_CONTROL=>ANODE_CONTROL			
			);
	
	MEM16_INST_0: MEM16	port map (ADDR=> ADDR_BUS, DATA=>CATHODE);
	
   FSM_INST_0: FSM port map (
			CLK => CLK,
			CLK_DIV => CLK_DIV_SIG,
         ARM => ARM,
         FRONT_DOOR => FRONT_DOOR,
         REAR_DOOR => REAR_DOOR,
         WINDOW => WINDOW,
			RUN_TIMER => RUN_SIG,
         SIREN => SIREN);	
			
end architecture RTL;
