----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2023 21:59:17
-- Design Name: 
-- Module Name: traffic - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY project_traffic_tb IS
END project_traffic_tb;

ARCHITECTURE behavior OF project_traffic_tb IS 

    -- Component declaration
    COMPONENT project_traffic
        PORT(
            clk        : IN  std_logic;
            clr        : IN  std_logic;
            traffic_1  : OUT std_logic_vector(2 downto 0);
            traffic_2  : OUT std_logic_vector(2 downto 0);
            echoo      : IN  std_logic;
            echo       : IN  std_logic;
            techo      : IN  std_logic;
            fecho      : IN  std_logic;
            trigg      : OUT std_logic;
            trig       : OUT std_logic;
            ttrig      : OUT std_logic;
            ftrig      : OUT std_logic;
            obstacles  : OUT std_logic;
            obstacle   : OUT std_logic;
            tobstacle  : OUT std_logic;
            fobstacle  : OUT std_logic;
            lcdrs      : OUT std_logic;
            lcde       : OUT std_logic;
            dataa      : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;

    -- Test signals
    SIGNAL clk        : std_logic := '0';
    SIGNAL clr        : std_logic := '1'; -- Initial clear signal
    SIGNAL echoo      : std_logic := '0';
    SIGNAL echo       : std_logic := '0';
    SIGNAL techo      : std_logic := '0';
    SIGNAL fecho      : std_logic := '0';
    SIGNAL trigg      : std_logic;
    SIGNAL trig       : std_logic;
    SIGNAL ttrig      : std_logic;
    SIGNAL ftrig      : std_logic;
    SIGNAL obstacles  : std_logic;
    SIGNAL obstacle   : std_logic;
    SIGNAL tobstacle  : std_logic;
    SIGNAL fobstacle  : std_logic;
    SIGNAL lcdrs      : std_logic;
    SIGNAL lcde       : std_logic;
    SIGNAL dataa      : std_logic_vector(7 downto 0);
    SIGNAL traffic_1  : std_logic_vector(2 downto 0);
    SIGNAL traffic_2  : std_logic_vector(2 downto 0);

    CONSTANT clk_period : TIME := 10 ns; -- Adjust as needed

BEGIN

    -- Component instantiation
    uut: project_traffic PORT MAP (
        clk       => clk,
        clr       => clr,
        traffic_1 => traffic_1,
        traffic_2 => traffic_2,
        echoo     => echoo,
        echo      => echo,
        techo     => techo,
        fecho     => fecho,
        trigg     => trigg,
        trig      => trig,
        ttrig     => ttrig,
        ftrig     => ftrig,
        obstacles => obstacles,
        obstacle  => obstacle,
        tobstacle => tobstacle,
        fobstacle => fobstacle,
        lcdrs     => lcdrs,
        lcde      => lcde,
        dataa     => dataa
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Test process
    test_process : PROCESS
    BEGIN
       
        clr <= '1';
        WAIT FOR 20 ns;
        clr <= '0';

 
        echoo <= '1';
        echo<='1';
        techo<='1';
        fecho<='1';
        WAIT FOR 50 ns;
        echoo <= '0';
        echo<='0';
        techo<='0';
        fecho<='0';
        WAIT FOR 30 ns;

        
        WAIT;
    END PROCESS;

END behavior;
