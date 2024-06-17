library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity lcd is
port(clk : in std_logic;
lcd_rs : out std_logic;
lcd_e : out std_logic;
data : out std_logic_vector(7 downto 0)
);
end lcd;

architecture Behavioral of lcd is
type arr is array (1 to 16) of std_logic_vector(7 downto 0);
constant data_rom : arr :=(X"38",X"0C",X"06",X"01",X"C0",X"44",X"53",X"44",X"20",X"50",X"52",X"30",X"4A",X"45",X"43",X"54");
signal en_timing : integer range  0 to 100000;
signal data_pos : integer range  1 to 16;
begin
process(clk)
begin
if rising_edge (clk) then
en_timing <= en_timing+ 1;
if en_timing <= 50000 then
    lcd_e<='1';
    data <= data_rom(data_pos) (7 downto 0);
elsif en_timing >50000 and en_timing < 100000 then
    Lcd_e <= '0';
elsif en_timing = 100000 then
    en_timing <= 0;
    data_pos <= data_pos + 1 ;
end if;

if data_pos <= 5 then
 lcd_rs<='0';
elsif data_pos > 5 then
 lcd_rs<='1';
end if;

if data_pos = 16 then
data_pos<=5;
end if;
end if;
end process;
end Behavioral;