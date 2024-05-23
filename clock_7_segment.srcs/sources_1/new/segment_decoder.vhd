library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity segment_decoder is
  Port (  digit1,digit2,digit3,digit4: in std_logic_vector   (3 downto 0);
  WhichDisplay : in std_logic_vector (2 downto 0);
  seg: out std_logic_vector (6 downto 0)
 );
end segment_decoder;

architecture cialo of segment_decoder is

type display is array (0 to 9) of std_logic_vector (6 downto 0);
constant converter : display :=
		("0000001","1001111","0010010","0000110","1001100","0100100","0100000","0001111",
		 "0000000","0000100");

signal temp : std_logic_vector (6 downto 0);
begin
process(WhichDisplay ,temp)
begin
if WhichDisplay = "000" then
temp<= converter(to_integer(unsigned(digit1)));
elsif WhichDisplay = "001" then
temp<= converter(to_integer(unsigned(digit2)));
elsif WhichDisplay = "010" then
temp<= converter(to_integer(unsigned(digit3)));
elsif WhichDisplay = "011" then
temp<= converter(to_integer(unsigned(digit4)));
end if;

end process;

seg<=temp;

end cialo;