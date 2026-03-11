----------------------------------------------------------------------------------
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
     ENABLE_V: in STD_LOGIC_VECTOR(0 to 3);-- in vector form to better make use of generate statements
     LED_V:out STD_LOGIC_VECTOR (0 to 3);
     TOTAL_COUNT_MSB: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_MID: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_LSB: out STD_lOGIC_VECTOR(0 to 6);
     total_Count_test: out std_logic_vector(8 downto 0));
 
     
end Attendance_monitor;

architecture Behavioral of Attendance_monitor is
signal total_count: unsigned (8 downto 0):="000000000";
type vector_of_vectors is array(natural range<>) of std_logic_vector (6 downto 0);
signal section_count: vector_of_vectors (0 to 3);
component Counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           COUNT_OUTPUT : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC);
end component;

begin
counter_generation: for I in 0 to 3 generate

Section_Counter: counter port map(CLK=>CLK_EXT,
                                  RESET=>RESET_EXT,
                                  ENABLE=>ENABLE_V(I),
                                  LED=>LED_V(I),
                                  COUNT_OUTPUT=>section_count(I));

end generate ;
 
counters_sum: process(CLK_EXT) 
variable count
begin

if rising_edge (CLK_EXT) then
total_count<=unsigned(section_count(0))+unsigned(section_count(1))+unsigned(section_count(2))+unsigned(section_count(3));





total_count_test<=std_logic_vector (total_count);
end if ;
end process;
end Behavioral;
