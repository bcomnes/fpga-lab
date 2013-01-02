--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.3
--  \   \         Application : sch2hdl
--  /   /         Filename : full_adder_sch.vhf
-- /___/   /\     Timestamp : 01/02/2013 11:26:17
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/full_adder_sch.vhf" -w "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/full_adder_sch.sch"
--Design Name: full_adder_sch
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity full_adder_sch is
   port ( A    : in    std_logic; 
          B    : in    std_logic; 
          Cin  : in    std_logic; 
          Cout : out   std_logic; 
          SUM  : out   std_logic);
end full_adder_sch;

architecture BEHAVIORAL of full_adder_sch is
   attribute BOX_TYPE   : string ;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   component XOR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of XOR2 : component is "BLACK_BOX";
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
begin
   XLXI_1 : XOR2
      port map (I0=>B,
                I1=>A,
                O=>XLXN_10);
   
   XLXI_2 : XOR2
      port map (I0=>Cin,
                I1=>XLXN_10,
                O=>SUM);
   
   XLXI_3 : AND2
      port map (I0=>Cin,
                I1=>XLXN_10,
                O=>XLXN_11);
   
   XLXI_4 : AND2
      port map (I0=>A,
                I1=>A,
                O=>XLXN_12);
   
   XLXI_6 : OR2
      port map (I0=>XLXN_12,
                I1=>XLXN_11,
                O=>Cout);
   
end BEHAVIORAL;


