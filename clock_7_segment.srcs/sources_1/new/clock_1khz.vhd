library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_1khz is
  Port (C: in std_logic;
  C2: out std_logic   );
end clock_1khz;

architecture cialo of clock_1khz is

signal temp2: std_logic :='0';
signal counter2: INTEGER :=0;

begin
process(C)
begin
if rising_edge (C) then
counter2<=counter2+1;
if (counter2=49999) then
temp2<= NOT temp2;
counter2<=0;
end if;
end if;
C2<=temp2;
end process;

end cialo;