----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12.03.2026 13:05:16
-- Design Name:
-- Module Name: Adder - Behavioral
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

entity Adder is
    Port ( N: in STD_LOGIC_Vector(6 downto 0);
           E : in STD_LOGIC_Vector(6 downto 0);
           S : in STD_LOGIC_Vector(6 downto 0);
           W : in STD_LOGIC_Vector(6 downto 0);
           
           Output: out std_logic_Vector(8 downto 0));
end Adder;

architecture Behavioral of Adder is
signal int1,int2,int3,int4:unsigned (6 downto 0);
signal out1:unsigned(8 downto 0);
begin
 


int1<=unsigned (N);
int2<=unsigned (E);
int3<=unsigned (S);
int4<=unsigned (W);
out1<=resize(int1,9)+resize(int2,9)+resize(int3,9)+resize(int4,9);
output<=std_logic_vector (out1);



end Behavioral;