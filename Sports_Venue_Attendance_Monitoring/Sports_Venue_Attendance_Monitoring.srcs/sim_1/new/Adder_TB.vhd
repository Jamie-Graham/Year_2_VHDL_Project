----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2026 15:50:13
-- Design Name: 
-- Module Name: Adder_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12.03.2026 13:29:38
-- Design Name:
-- Module Name: Adder_TB - Behavioral
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

entity Adder_TB is
--  Port ( );
end Adder_TB;

architecture Behavioral of Adder_TB is
component Adder is
     Port ( N: in STD_LOGIC_Vector(6 downto 0);
           E : in STD_LOGIC_Vector(6 downto 0);
           S : in STD_LOGIC_Vector(6 downto 0);
           W : in STD_LOGIC_Vector(6 downto 0);
        
           Output: out std_logic_Vector(8 downto 0));
end component;
signal input1,input2,input3,input4: std_logic_vector(6 downto 0);
signal output:std_logic_vector(8 downto 0);
begin
DUT: Adder port map(N=>input1,
                    E=>input2,
                    S=>input3,
                    W=>input4,

                    output=>output);
                   
stimuli:process
begin
input1<="1111111";input2<="1111111";input3<="1111111";input4<="1111111";wait for 100 ns;
input1<="0000000";input2<="1011001";input3<="0110011";input4<="1101101";wait for 100 ns;
input1<="1100110";input2<="1001011";input3<="1010101";input4<="0101010";wait for 100 ns;
input1<="0000000";input2<="0000000";input3<="0000000";input4<="0000000";wait for 100 ns;
input1<="1100000";input2<="1011111";input3<="0100101";input4<="0101110";wait for 100 ns;

end process;
end Behavioral;
