----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2026 16:19:02
-- Design Name: 
-- Module Name: Encoder_TB - Behavioral
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

entity Encoder_TB is
--  Port ( );
end Encoder_TB;

architecture Behavioral of Encoder_TB is
component Encoder is
    Port ( total_count : in STD_LOGIC_VECTOR (8 downto 0);
           Output_MSB : out STD_LOGIC_VECTOR (6 downto 0);
           Output_MID : out STD_LOGIC_VECTOR (6 downto 0);
           Output_LSB : out STD_LOGIC_VECTOR (6 downto 0));
         
end component;
signal input_TB:std_logic_vector (8 downto 0);
signal MSB_TB,MID_TB,LSB_TB: std_logic_vector (6 downto 0);
 
begin
DUT: Encoder port map (total_count=>input_TB,output_MSB=>MSB_TB,output_MID=>MID_TB,output_LSB=>LSB_TB);


stimuli:process
begin

input_TB<="111111111";wait for 100ns;-- 511 
input_TB<="110010000";wait for 100ns;-- 400
input_TB<="000000001";wait for 100ns;-- 001
input_TB<="010101010";wait for 100ns;-- 170
input_TB<="101010101";wait for 100ns;-- 341
input_TB<="001000000";wait for 100ns;-- 064
input_TB<="100100001";wait for 100ns;-- 289



wait;

end process;
end Behavioral;
