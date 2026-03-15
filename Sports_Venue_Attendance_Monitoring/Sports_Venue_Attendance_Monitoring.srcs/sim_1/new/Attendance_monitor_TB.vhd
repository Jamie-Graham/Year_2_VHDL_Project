----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2026 21:05:43
-- Design Name: 
-- Module Name: Attendance_monitor_TB - Behavioral
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

entity Attendance_monitor_TB is
--  Port ( );
end Attendance_monitor_TB;

architecture Behavioral of Attendance_monitor_TB is
component Attendance_monitor is
port(CLK_EXT:in STD_logic; -- EXT is used to denote external, meaning this is the signal being passed into Attendance monitoring 
     RESET_EXT: in STD_LOGIC; -- from the clock generation process in the TB (makes it easier to track signals by having different names)
     ENABLE_V: in STD_LOGIC_VECTOR(0 to 3);-- in vector form to better make use of generate statements
     LED_V:out STD_LOGIC_VECTOR (0 to 3);
     LEADING_ZERO:out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_MSB: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_MID: out STD_lOGIC_VECTOR(0 to 6);
     TOTAL_COUNT_LSB: out STD_lOGIC_VECTOR(0 to 6);
  North,east,south,west: out std_logic_vector(6 downto 0));
 
     
end component;

signal clock_tb,reset:std_logic;
signal enable_tb,led_tb:std_logic_vector (0 to 3);
signal ncount,ecount,scount,wcount,zero,MSB,MID,LSB:std_logic_vector(6 downto 0);
begin
DUT : Attendance_monitor port map (CLK_EXT=>Clock_tb,
                                   RESET_EXT=>reset,
                                    ENABLE_V=>enable_tb,
                                    LED_V=>LED_tb,
                                    LEADING_ZERO=>zero,
                                    TOTAL_COUNT_MSB=>MSB,
                                    TOTAL_COUNT_MID=>MID,
                                    TOTAL_COUNT_LSB=>LSB,
                                    north=>ncount,
                                    east=>ecount,
                                    south=>scount,
                                    west=>wcount
                                   );
clock:process 
begin 

while true loop
clock_tb <='1'; wait for 5ns ;
clock_tb <='0';wait for 5ns;
end loop;
wait; 
end process;


stimuli:process
begin

reset<='0';enable_tb<="1001";wait for 100 ns ;
reset<='1';enable_tb<="1001";wait for 100 ns ;
reset<='0';enable_tb<="1111";wait for 1000ns  ;
reset<='1';enable_tb<="1111";wait for 100ns  ;
reset<='0';enable_tb<="0001"; 

wait;
end process;
end Behavioral;
