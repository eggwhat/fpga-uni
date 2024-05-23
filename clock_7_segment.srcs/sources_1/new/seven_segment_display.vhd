library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity seven_segment_display is
    Port ( 
    C : in  STD_LOGIC;
    R : in  STD_LOGIC;
    houradder	: in std_logic_vector (1 downto 0);
    minuteadder: in std_logic_vector (1 downto 0) ;
    anode_act : out std_logic_vector(3 downto 0);
	seg : out std_logic_vector (6 downto 0)
           );
end seven_segment_display;

architecture seven_segment_display of seven_segment_display is

component clock_1hz 
port(C: in std_logic ;
C1: out std_logic 
);
end component;

component clock_1khz
port (C: in std_logic ;
C2: out std_logic 
);
end component;

component mod4counter
port (C2: in std_logic;
WhichDisplay: out std_logic_vector (2 downto 0));
end component;

component clock_counter
port(C1: in std_logic ;
R: in std_logic ;
houradder: in std_logic_vector (1 downto 0);
minuteadder: in std_logic_vector (1 downto 0);
 digit1,digit2,digit3,digit4: out std_logic_vector   (3 downto 0));
end component;

component anode_picker
port (WhichDisplay: in std_logic_vector (2 downto 0);
anode_act: out std_logic_vector (3 downto 0));
end component;

component segment_decoder
port ( WhichDisplay: in std_logic_vector (2 downto 0);
digit1,digit2,digit3,digit4: in std_logic_vector   (3 downto 0);
seg: out std_logic_vector (6 downto 0));
end component;

signal 	C1 : std_logic :='0';
signal C2: std_logic :='0';
signal WhichDisplay: std_logic_vector (2 downto 0);
signal digit1,digit2,digit3,digit4:  std_logic_vector   (3 downto 0);

begin

comp1:clock_1hz PORT MAP(
C, C1
);

comp2: clock_1khz PORT MAP(
C, C2);

comp3: mod4counter  PORT MAP(
C2, WhichDisplay );

comp4: clock_counter PORT MAP(
C1, R, houradder, minuteadder, digit1,digit2,digit3,digit4);

comp5: anode_picker PORT MAP(
WhichDisplay , anode_act);

comp6: segment_decoder PORT MAP(
WhichDisplay ,digit1,digit2,digit3,digit4,seg);

end seven_segment_display;