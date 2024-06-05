----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2024 11:38:05 PM
-- Design Name: 
-- Module Name: clk_5hz - cialo
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_5hz is
  Port (
  C : in std_logic ;
  clk_5hz : out std_logic 
   );
end clock_5hz;

architecture cialo of clock_5hz is

signal temp_clk5hz: std_logic:='0';
signal counter_clk5hz: INTEGER:=0;

begin
process(C)
begin
    if rising_edge(C) then
    counter_clk5hz<=counter_clk5hz+1;
    if (counter_clk5hz = 9999999) then
    temp_clk5hz<= NOT temp_clk5hz;
    counter_clk5hz<=0;
    end if;
    end if;
    clk_5hz<=temp_clk5hz;
end process;

end cialo;
