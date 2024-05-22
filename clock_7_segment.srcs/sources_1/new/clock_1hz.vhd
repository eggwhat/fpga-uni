library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_1hz is
  Port (
  C : in std_logic ;
  C1 : out std_logic 
   );
end clock_1hz;

architecture cialo of clock_1hz is

signal temp1: std_logic:='0';
signal counter1: INTEGER:=0;

begin
process(C)
begin
if rising_edge(C) then
counter1<=counter1+1;
if (counter1 = 49999999) then
temp1<= NOT temp1;
counter1<=0;
end if;
end if;
C1<=temp1;
end process;

end cialo;