--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.3
--  \   \         Application : sch2hdl
--  /   /         Filename : AND_2.vhf
-- /___/   /\     Timestamp : 12/31/2012 13:35:39
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-01/AND_2/AND_2.vhf" -w "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-01/AND_2/AND_2.sch"
--Design Name: AND_2
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

entity AND_2 is
   port ( A    : in    std_logic; 
          B    : in    std_logic; 
          OUT1 : out   std_logic);
end AND_2;

architecture BEHAVIORAL of AND_2 is
   attribute BOX_TYPE   : string ;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>B,
                I1=>A,
                O=>OUT1);
   
end BEHAVIORAL;


