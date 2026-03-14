--
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2026 20:01:42
-- Design Name: 
-- Module Name: Attendance_monitoring - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Attendance_monitor is
port(CLK_EXT:in STD_logic; -- EXT is used to denote external, meaning this is the signal being passed into Attendance monitoring 
     RESET_EXT: in STD_LOGIC; -- from the clock generation process in the TB (makes it easier to track signals by having different names)
     ENABLE_V: in STD_LOGIC_VECTOR(0 to 3):="0000";-- in vector form to better make use of generate statements
     LED_V:out STD_LOGIC_VECTOR (0 to 3):="0000";
     TOTAL_COUNT_MSB: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_MID: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_LSB: out STD_lOGIC_VECTOR(0 to 6);
    
     North,east,south,west: out std_logic_vector(6 downto 0));
 
     
end Attendance_monitor;

architecture Behavioral of Attendance_monitor is

type vector_of_vectors is array(natural range<>) of std_logic_vector (6 downto 0);
signal section_count: vector_of_vectors (0 to 3);
signal internal_count:std_logic_vector(8 downto 0); -- used to connect the adder to encoder
component Counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           COUNT_OUTPUT : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC);
end component;
component Adder is 
    port (N: in STD_LOGIC_Vector(6 downto 0);
          E : in STD_LOGIC_Vector(6 downto 0);
          S : in STD_LOGIC_Vector(6 downto 0);
          W : in STD_LOGIC_Vector(6 downto 0);
          Output: out std_logic_Vector(8 downto 0));
    
end component;

component Encoder is
    Port ( total_count : in STD_LOGIC_VECTOR (8 downto 0);
           Output_MSB : out STD_LOGIC_VECTOR (6 downto 0);
           Output_MID : out STD_LOGIC_VECTOR (6 downto 0);
           Output_LSB : out STD_LOGIC_VECTOR (6 downto 0));
            
end component;
begin
counter_generation: for I in 0 to 3 generate

Section_Counter: counter port map(CLK=>CLK_EXT,
                                  RESET=>RESET_EXT,
                                  ENABLE=>ENABLE_V(I),
                                  LED=>LED_V(I),
                                  COUNT_OUTPUT=>section_count(I));

end generate ;
Total_count:adder port map(N=>section_count(0),
                            E=>section_count(1),
                            S=>section_count(2),
                            W=>section_count(3),
                            output=>internal_count);

unsigned_to_display:encoder port map(
                            total_count=>internal_count,
                            Output_MSB=>TOTAL_COUNT_MSB,
                            Output_MID=>TOTAL_COUNT_MID,
                            Output_LSB=>TOTAL_COUNT_LSB);
north<=section_count(0);
east<=section_count(1);
south<=section_count(2);
west<=section_count(3);

end Behavioral;
