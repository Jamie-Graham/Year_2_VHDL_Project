----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2026 16:08:40
-- Design Name: 
-- Module Name: Counter_TB - Behavioral
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

entity Counter_TB is
--  Port ( );
end Counter_TB;

architecture Behavioral of Counter_TB is
component Counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           COUNT_OUTPUT : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC);
end component ;
signal CLK_TB,RESET_TB,ENABLE_TB,LED_TB: std_logic;
signal COUNT_TB:std_logic_vector(6 downto 0);
begin

DUT: Counter port map(CLK=>CLK_TB,RESET=>RESET_TB,ENABLE=>ENABLE_TB,COUNT_OUTPUT=>COUNT_TB,LED=>LED_TB);

clock:process 
begin 

while now <= 3000 ns loop
CLK_TB <='1'; wait for 5ns ;
CLK_TB <='0';wait for 5ns;
end loop;
wait; 
end process;

sitmuli:process 
begin 

RESET_TB<='0';ENABLE_TB<='1';wait for 400 ns; 
RESET_TB<='1';ENABLE_TB<='1';wait for 100 ns; 
RESET_TB<='0';ENABLE_TB<='1';wait for 1400 ns;
RESET_TB<='1';ENABLE_TB<='1';wait for 100 ns;
RESET_TB<='0';ENABLE_TB<='1';
wait; 
end process;
end Behavioral;
