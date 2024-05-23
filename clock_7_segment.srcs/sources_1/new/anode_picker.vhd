library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity anode_picker is
  Port (WhichDisplay: in std_logic_vector (2 downto 0);
  anode_act: out std_logic_vector (3 downto 0) );
end anode_picker;

architecture cialo of anode_picker is

signal temp : std_logic_vector (3 downto 0);		 

begin
process(WhichDisplay , temp)
begin
if WhichDisplay = "000" then
temp <="0111";
elsif WhichDisplay ="001" then
temp<= "1011";
elsif WhichDisplay ="010" then
temp<= "1101";
elsif WhichDisplay ="011" then
temp<= "1110";
end if;
end process;

anode_act<=temp;

end cialo;