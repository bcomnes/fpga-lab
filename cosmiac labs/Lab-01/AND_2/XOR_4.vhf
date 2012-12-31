--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.3
--  \   \         Application : sch2hdl
--  /   /         Filename : XOR_4.vhf
-- /___/   /\     Timestamp : 12/31/2012 14:06:50
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-01/AND_2/XOR_4.vhf" -w "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-01/AND_2/XOR_4.sch"
--Design Name: XOR_4
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

entity XOR_4 is
   port ( AX   : in    std_logic; 
          BX   : in    std_logic; 
          CX   : in    std_logic; 
          DX   : in    std_logic; 
          XOR4 : out   std_logic);
end XOR_4;

architecture BEHAVIORAL of XOR_4 is
   attribute BOX_TYPE   : string ;
   signal XLXN_1 : std_logic;
   signal XLXN_2 : std_logic;
   component XOR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of XOR2 : component is "BLACK_BOX";
   
begin
   XLXI_1 : XOR2
      port map (I0=>BX,
                I1=>AX,
                O=>XLXN_1);
   
   XLXI_2 : XOR2
      port map (I0=>CX,
                I1=>XLXN_1,
                O=>XLXN_2);
   
   XLXI_3 : XOR2
      port map (I0=>DX,
                I1=>XLXN_2,
                O=>XOR4);
   
end BEHAVIORAL;


