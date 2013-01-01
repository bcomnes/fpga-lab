--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2.04i
--  \   \         Application : ISE
--  /   /         Filename : tb_BRAINLESS_uP_selfcheck.vhw
-- /___/   /\     Timestamp : Thu Jul 24 11:41:40 2008
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: tb_BRAINLESS_uP_selfcheck_beh
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY tb_BRAINLESS_uP_selfcheck_beh IS
END tb_BRAINLESS_uP_selfcheck_beh;

ARCHITECTURE testbench_arch OF tb_BRAINLESS_uP_selfcheck_beh IS
    COMPONENT BRAINLESS_uP
        PORT (
            SYS_CLK : In std_logic;
            CLOCK : In std_logic;
            DATA_IN : In std_logic_vector (3 DownTo 0);
            BUFFER_SELECT : In std_logic;
            RD_WR : In std_logic;
            ALU_CONTROL_SIGNALS : In std_logic_vector (2 DownTo 0);
            LOAD_ACC : In std_logic;
            ACC_2_DATA_BUS : In std_logic;
            DATA_OUT : Out std_logic_vector (3 DownTo 0)
        );
    END COMPONENT;

    SIGNAL SYS_CLK : std_logic := '0';
    SIGNAL CLOCK : std_logic := '0';
    SIGNAL DATA_IN : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL BUFFER_SELECT : std_logic := '0';
    SIGNAL RD_WR : std_logic := '0';
    SIGNAL ALU_CONTROL_SIGNALS : std_logic_vector (2 DownTo 0) := "000";
    SIGNAL LOAD_ACC : std_logic := '0';
    SIGNAL ACC_2_DATA_BUS : std_logic := '0';
    SIGNAL DATA_OUT : std_logic_vector (3 DownTo 0) := "UUUU";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 40 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : BRAINLESS_uP
        PORT MAP (
            SYS_CLK => SYS_CLK,
            CLOCK => CLOCK,
            DATA_IN => DATA_IN,
            BUFFER_SELECT => BUFFER_SELECT,
            RD_WR => RD_WR,
            ALU_CONTROL_SIGNALS => ALU_CONTROL_SIGNALS,
            LOAD_ACC => LOAD_ACC,
            ACC_2_DATA_BUS => ACC_2_DATA_BUS,
            DATA_OUT => DATA_OUT
        );

        PROCESS    -- clock process for SYS_CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                SYS_CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                SYS_CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            PROCEDURE CHECK_DATA_OUT(
                next_DATA_OUT : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (DATA_OUT /= next_DATA_OUT) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns DATA_OUT="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, DATA_OUT);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_DATA_OUT);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                DATA_IN <= "1100";
                -- -------------------------------------
                -- -------------  Current Time:  105ns
                WAIT FOR 5 ns;
                ALU_CONTROL_SIGNALS <= "001";
                -- -------------------------------------
                -- -------------  Current Time:  185ns
                WAIT FOR 80 ns;
                RD_WR <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  265ns
                WAIT FOR 80 ns;
                LOAD_ACC <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  305ns
                WAIT FOR 40 ns;
                CLOCK <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  545ns
                WAIT FOR 240 ns;
                CLOCK <= '0';
                RD_WR <= '0';
                LOAD_ACC <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 40 ns;
                DATA_IN <= "0101";
                -- -------------------------------------
                -- -------------  Current Time:  625ns
                WAIT FOR 40 ns;
                BUFFER_SELECT <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  665ns
                WAIT FOR 40 ns;
                RD_WR <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  705ns
                WAIT FOR 40 ns;
                ALU_CONTROL_SIGNALS <= "100";
                -- -------------------------------------
                -- -------------  Current Time:  745ns
                WAIT FOR 40 ns;
                LOAD_ACC <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  785ns
                WAIT FOR 40 ns;
                CLOCK <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  985ns
                WAIT FOR 200 ns;
                CLOCK <= '0';
                RD_WR <= '0';
                LOAD_ACC <= '0';
                ACC_2_DATA_BUS <= '1';
                -- -------------------------------------
                WAIT FOR 55 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

