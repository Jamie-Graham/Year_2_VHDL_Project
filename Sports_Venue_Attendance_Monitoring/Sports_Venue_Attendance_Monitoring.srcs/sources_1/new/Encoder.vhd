----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2026 15:39:12
-- Design Name: 
-- Module Name: Encoder - V1
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

entity Encoder is
    Port ( total_count : in STD_LOGIC_VECTOR (8 downto 0);
           Output_MSB : out STD_LOGIC_VECTOR (6 downto 0);
           Output_MID : out STD_LOGIC_VECTOR (6 downto 0);
           Output_LSB : out STD_LOGIC_VECTOR (6 downto 0));
            
end Encoder;

architecture V1 of Encoder is
type vector_of_vectors is array(natural range<>) of std_logic_vector (6 downto 0);-- gives a vector where each element is a 7 bit logic vector
type int_vector is array (2 downto 0) of integer range 0 to 9; -- allows for a array of integers where each element is a number 1 to 9 

begin
encoding:process (total_count)-- triggers each time the input changes, doesnt need clock as the singals being inputted are already tied to clock thorugh the counter
variable in_int: integer;-- declare variable that stores the inputed value in integer form
variable integers_single_digits: int_vector; -- user defined type allows for for loop to be used
variable output_vector: vector_of_vectors(2 downto 0);-- used in for loop to prevent repeating case three times
begin 

in_int:= to_integer (unsigned(total_count));
integers_single_digits(2):=in_int/100; -- this gives us the 100's number of the total count
integers_single_digits(1):=(in_int-integers_single_digits(2)*100)/10;-- this gives us the 10's number of the total count
integers_single_digits(0):=in_int-((integers_single_digits(2)*100)+(integers_single_digits(1)*10)); --this gives us the digits of total count 

for I in 2 downto 0 loop
case integers_single_digits(I) is 
    when 0 =>
    output_vector(I):="1111110";
    when  1 =>
    output_vector(I):="0110000";
    when  2 =>
    output_vector(I):="1101101";
    when  3 =>
    output_vector(I):="1111001";
    when  4 =>
    output_vector(I):="0110011";
    when  5 =>
    output_vector(I):="1011011";
    when  6 =>
    output_vector(I):="1011111";
    when  7 =>
    output_vector(I):="1110000";
    when  8 =>
    output_vector(I):="1111111";
    when  9 =>
    output_vector(I):="1110011";
    when others=>
    output_vector(I):="1001111"; -- used to show if invalid input is displayed makes a 'E' SHOULD never happen
    
    
    end case;

end loop;
Output_MSB<=output_vector(2); 
Output_MID<=output_vector(1);
Output_LSB<=output_vector(0);-- assigns 7 segment code to output vectors after each for statement is completed

end process;

end V1;
