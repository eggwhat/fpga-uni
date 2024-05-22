library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity clock_counter is
  Port (C1: in std_logic;
  R: in std_logic;
  houradder: in std_logic_vector (1 downto 0);
  minuteadder: in std_logic_vector (1 downto 0);
  digit1,digit2,digit3,digit4,digit5,digit6: out std_logic_vector   (3 downto 0)
  );
end clock_counter;

architecture cialo of clock_counter is

signal seconds: INTEGER:=0;

type int_to_bin is array (0 to 9) of std_logic_vector   (3 downto 0);
constant int_bin : int_to_bin :=
("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001");

begin

process (C1, R, minuteadder, houradder, seconds)
begin
if (R='1' OR seconds=86400) then
seconds<=0;
elsif rising_edge(C1) then
 seconds<=seconds+1;
IF minuteadder(0) ='1' then
 seconds<=seconds+60;
 elsif minuteadder(1) ='1' then
 seconds<=seconds+600;
 elsif houradder(0) ='1' THEN
 seconds<=seconds+3600;
 elsif houradder(1)='1' then
 seconds<=seconds+36000;
 end if;
 end if;
end process;
 digit1<=int_bin (((seconds mod 3600) mod 60) mod 10);
 digit2<=int_bin (((seconds mod 3600) mod 60 ) /10);
 digit3<=int_bin (((seconds mod 3600) /60) mod 10);
 digit4<=int_bin (((seconds mod 3600) /60) /10);
 digit5<=int_bin ((seconds /3600) mod 10);
 digit6<=int_bin ((seconds /3600) /10); 

end cialo;