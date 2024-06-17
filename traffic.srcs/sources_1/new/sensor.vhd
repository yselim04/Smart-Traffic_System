library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sensor is
port(clk: in std_logic;
    echo:in std_logic;
    trig: out std_logic;
    obstacle: out std_logic);
end sensor;

architecture Behavioral of sensor is
signal echo_time: integer;
begin

  process(clk)
    variable c1,c2: integer:=0;
    variable y :std_logic:='1';
  begin
    if rising_edge(clk) then

        if(c1=0) then
            trig<='1';
        elsif(c1=10000) then--100us
            trig<='0';
            y:='1';
        elsif(c1=10000000) then-- 100 ms
            c1:=0;
            trig<='1';
        end if;
        c1:=c1+1;

        if(echo = '1') then
            c2:=c2+1;
        elsif(echo = '0' and y='1' ) then-- I change the y to not get echo_time =0;
            echo_time<= c2;
            c2:=0;
            y:='0';
        end if;

        if(echo_time < 10) then--20 cm
            obstacle<='1';
        elsif(echo_time > 150)then--30 cm
            obstacle<='0';
        else-- between  
            obstacle<='1';
        end if;
      end if; 
    end process ;
end Behavioral;