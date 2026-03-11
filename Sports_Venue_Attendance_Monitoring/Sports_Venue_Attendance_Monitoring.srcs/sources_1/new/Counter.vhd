----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2026 15:33:09
-- Design Name: 
-- Module Name: Counter - V1
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

entity Counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           COUNT_OUTPUT : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC);
end Counter;

architecture V1 of Counter is
constant maximum_count: integer := 100;
constant caution_count : integer:= 90;
begin


counter: process(CLK,RESET)is
variable count :unsigned(6 downto 0):="0000000";
begin 

if rising_edge (CLK) then
if RESET= '1' then
count:="0000000";
elsif (ENABLE='1') then
if count<maximum_count then
count:= count+1;
end if;
end if;
end if;
if count>=caution_count then
LED<='1';
else
LED<='0';
end if;



COUNT_OUTPUT<=std_logic_vector(count);
end process;
end V1;
