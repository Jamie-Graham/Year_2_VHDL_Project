----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2026 19:12:36
-- Design Name: 
-- Module Name: MUX_TB - Behavioral
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

entity MUX_TB is
--  Port ( );
end MUX_TB;

architecture Behavioral of MUX_TB is
component MUX is
    Port ( A : in std_logic_vector(6 downto 0);
           B : in STD_LOGIC_vector(6 downto 0);
           C : in STD_LOGIC_vector(6 downto 0);
           D : in STD_LOGIC_vector(6 downto 0);
           SEL : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_vector(6 downto 0));
end component;
signal A,B,C,D,OUTPUT: std_logic_vector(6 downto 0);
signal selector: std_logic_vector(1 downto 0);
begin
DUT: MUX port map(A=>A,B=>B,C=>C,D=>D,SEL=>selector,output=>OUTPUT);

sel:process 
begin
while true loop
selector<="00";wait for 100 ns;
selector<="01";wait for 100 ns;
selector<="10";wait for 100 ns;
selector<="11";wait for 100 ns;
end loop;
end process;
stimuli:process
begin 
A<="1111111";B<="0000000";C<="1010101";D<="0101010";
wait;
end process;
end Behavioral;
