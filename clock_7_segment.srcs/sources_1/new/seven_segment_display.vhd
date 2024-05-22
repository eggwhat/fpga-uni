----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Design Name: 
-- Module Name: seven_seg_display - cialo
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
use IEEE.std_logic_unsigned.all;
entity seven_segment_display is
    Port ( C : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           R : in STD_LOGIC; -- Reset
           anode_act : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           seg : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end seven_segment_display;

architecture cialo of seven_segment_display is
signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
-- counter for generating 1-second clock enable
signal one_second_enable: std_logic;
-- one second enable for counting numbers
signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
-- counting decimal number to be displayed on 4-digit 7-segment display
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat
begin
-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display 
process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => seg <= "0000001"; -- "0"     
    when "0001" => seg <= "1001111"; -- "1" 
    when "0010" => seg <= "0010010"; -- "2" 
    when "0011" => seg <= "0000110"; -- "3" 
    when "0100" => seg <= "1001100"; -- "4" 
    when "0101" => seg <= "0100100"; -- "5" 
    when "0110" => seg <= "0100000"; -- "6" 
    when "0111" => seg <= "0001111"; -- "7" 
    when "1000" => seg <= "0000000"; -- "8"     
    when "1001" => seg <= "0000100"; -- "9" 
    when "1010" => seg <= "0000010"; -- a
    when "1011" => seg <= "1100000"; -- b
    when "1100" => seg <= "0110001"; -- C
    when "1101" => seg <= "1000010"; -- d
    when "1110" => seg <= "0110000"; -- E
    when "1111" => seg <= "0111000"; -- F
    when others => 
    end case;
end process;
-- 7-segment display controller
-- generate refresh period of 10.5ms
process(C,R)
begin 
    if(R='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(C)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        anode_act <= "0111";                       -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= displayed_number(15 downto 12); -- the first hex digit of the 16-bit number
    when "01" =>
        anode_act <= "1011";                       -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= displayed_number(11 downto 8);  -- the second hex digit of the 16-bit number
    when "10" =>
        anode_act <= "1101";                       -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= displayed_number(7 downto 4);   -- the third hex digit of the 16-bit number
    when "11" =>
        anode_act <= "1110";                       -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= displayed_number(3 downto 0);   -- the fourth hex digit of the 16-bit number
     when others => 
    end case;
end process;
-- Counting the number to be displayed on 4-digit 7-segment Display 
-- on Basys 3 FPGA board
process(C, R)
begin
        if(R='1') then
            one_second_counter <= (others => '0');
        elsif(rising_edge(C)) then
            if(one_second_counter>=x"5F5E0FF") then
                one_second_counter <= (others => '0');
            else
                one_second_counter <= one_second_counter + "0000001";
            end if;
        end if;
end process;
one_second_enable <= '1' when one_second_counter=x"5F5E0FF" else '0';
process(C, R)
begin
        if(R='1') then
            displayed_number <= (others => '0');
        elsif(rising_edge(C)) then
             if(one_second_enable='1') then
                displayed_number <= displayed_number + x"0001";
             end if;
        end if;
end process;
end cialo;

