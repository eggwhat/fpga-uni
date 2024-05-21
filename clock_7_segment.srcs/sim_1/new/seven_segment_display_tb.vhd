----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Design Name: 
-- Module Name: seven_segment_display_TB - Behavioral
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


library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_segment_display_tb is
    generic (
    constant F_ZEGARA      :natural := 100_000_000		-- czestotliwosc zegara systemowego w [Hz]
    );
end seven_segment_display_tb;

architecture Behavioral of seven_segment_display_TB is
  constant O_ZEGARA	:time := 1 sec/F_ZEGARA;		-- okres zegara systemowego

  signal C	:std_logic;			
  signal R	:std_logic;			
  signal anode_act:STD_LOGIC_VECTOR (3 downto 0);
  signal seg:STD_LOGIC_VECTOR (6 downto 0);
begin

   C <= not C after 10 ns;
    R <= '1', '0' after 500 ns;
   
   dut: entity work.seven_segment_display(cialo)
    port map(
        C => C,
        R => R,
        anode_act => anode_act,
        seg => seg
    );
    
    stimulus:
    process begin
        wait until( R = '0');
        
        wait;
     end process stimulus;
   

end Behavioral;
