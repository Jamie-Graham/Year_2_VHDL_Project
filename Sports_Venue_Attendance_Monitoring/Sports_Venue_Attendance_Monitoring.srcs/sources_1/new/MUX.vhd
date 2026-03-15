----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2026 19:11:58
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity MUX is
    Port ( A : in std_logic_vector(6 downto 0);
           B : in STD_LOGIC_vector(6 downto 0);
           C : in STD_LOGIC_vector(6 downto 0);
           D : in STD_LOGIC_vector(6 downto 0);
           SEL : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_vector(6 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

process(A,B,C,D,SEL)
variable x:unsigned(6 downto 0):=(others=>'0');
begin
case sel is
when "00" =>
output<=A;
when "01" =>
output<=B;
when "10" =>
output<=C;
when "11" =>
output<=D;
when others =>
output<= std_logic_vector(x); -- should never happen
end case;
end process;
end Behavioral;
