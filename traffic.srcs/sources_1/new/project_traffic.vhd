library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity project_traffic is
    Port (clk:in std_logic;
    clr:in std_logic;
    traffic_1: out std_logic_vector (2 downto 0);
    traffic_2: out std_logic_vector (2 downto 0); 
         echoo : in STD_LOGIC;
          echo : in STD_LOGIC;
          techo : in STD_LOGIC;
          fecho : in STD_LOGIC;
          trigg : out STD_LOGIC;
          trig : out STD_LOGIC;
            ttrig : out STD_LOGIC;
            ftrig : out std_logic ;
          obstacles : out STD_LOGIC;
          obstacle : out STD_LOGIC;
           tobstacle : out STD_LOGIC;
           fobstacle : out std_logic;
            lcdrs : out std_logic;
             lcde : out std_logic;
             dataa: out std_logic_vector(7 downto 0));
end project_traffic;

architecture traffic of project_traffic is
component  sensor is
port(
clk: in std_logic;
    echo:in std_logic;
    trig: out std_logic;
    obstacle: out std_logic);

end component;

component lcd is
port(
   clk : in std_logic;
    lcd_rs : out std_logic;
    lcd_e : out std_logic;
    data : out std_logic_vector(7 downto 0));
end component;
    type state_type is (s0,s1,s2,s3,s4,s5);
    signal state: state_type;
    signal count_v: std_logic_vector(31 downto 0);
     signal count :std_logic_vector (31 downto 0);
    constant sec220: std_logic_vector(29 downto 0):="111011100110101100101000000000";
    constant sec1: std_logic_vector(27 downto 0):="1011111010111100001000000000";
    constant sec5: std_logic_vector(28 downto 0):="11101110011010110010100000000";
--    signal ultrasonic: std_logic_vector (3 downto 0);
    signal ultrasonic: std_logic_vector(3 downto 0);
    signal traffic_1_temp: std_logic_vector (2 downto 0);
    signal traffic_2_temp: std_logic_vector (2 downto 0);
      signal    o1,o2,o3,o4 :  std_logic;
      
begin
lcdd: lcd port map(clk,lcdrs,lcde,dataa);
process (clk,clr)
begin
    if(clr='1') then 
        state<=s0;
        count<="00000000000000000000000000000000";
    elsif (clk'event and clk='1') then
        case state is 
        when s0=>
            if count < sec1 then
            state <=s0;
            count<=count+'1';
            else
            state <= s1;
            count<="00000000000000000000000000000000";
            end if; 
        when s1=>
            if count < sec220 then
            state <=s1;
            count<=count+'1';
            else
            state <= s2;
            count<="00000000000000000000000000000000";
            end if; 
        when s2=>
            if count < sec5 then
            state <=s2;
            count<=count+'1';
            else
            state <= s3;
            count<="00000000000000000000000000000000";
            end if;
        when s3=>
            if count < sec1 then
            state <=s3;
            count<=count+'1';
            else
            state <= s4;
            count<="00000000000000000000000000000000";
            end if;  
        when s4=>
            if count < sec220 then
            state <=s4;
            count<=count+'1';
            else
            state <= s5;
            count<="00000000000000000000000000000000";
            end if; 
         when s5=>
            if count < sec5 then
            state <=s5;
            count<=count+'1';
            else
            state <= s0;
            count<="00000000000000000000000000000000";
            end if; 
        when others => 
        state <=s0;
        end case;
        end if;
        end process;
  process(state)
  begin
  case state is 
  when s0=>
  traffic_1<="110" ;
  traffic_1_temp<="110" ;
  traffic_2<="110";
  traffic_2_temp<="110" ;
  when s1=>
  traffic_1<="011" ;
 traffic_1_temp<="011" ;
  traffic_2<="110";
  traffic_2_temp<="110";
  when s2=> 
  traffic_1<="101" ;
  traffic_1_temp<="101" ;
  traffic_2<="101";
  traffic_2_temp<="101" ;
  
  when s3=> 
  traffic_1<="110" ;
  traffic_1_temp<="110" ;
  traffic_2<="110";
  traffic_2_temp<="110";
  
  when s4=> 
  traffic_1<="110" ;
  traffic_1_temp<="110" ;
  traffic_2<="011";
  traffic_2_temp<="011";
  
  when s5=> 
  traffic_1<="101" ;
  traffic_1_temp<="101" ;
  traffic_2<="101";
  traffic_2_temp<="101" ;
  
  end case;
  end process; 
--  detector_sensor:four_ultrasonic_sensors port map(sensore,clk,echo,trig,ultrasonic);
 
senorone: sensor port map (clk,echoo,trigg,o1);
    sensottwo:sensor port map(clk,echo,trig,o2);
     sensothree:sensor port map(clk,techo,ttrig,o3);
      sensothfour:sensor port map(clk,fecho,ftrig,o4);
  process (traffic_1_temp,traffic_2_temp)
  begin
  if (traffic_1_temp(0)='0') then
obstacles<=o1;
obstacle<=o2;
else
 obstacles<='0';
obstacle<='0';

   end if;
  if (traffic_2_temp(0)='0') then
  tobstacle<=o3;
  fobstacle<=o4;
  else
   tobstacle<='0';
  fobstacle<='0';
  end if;


 
  end process;

 end traffic;