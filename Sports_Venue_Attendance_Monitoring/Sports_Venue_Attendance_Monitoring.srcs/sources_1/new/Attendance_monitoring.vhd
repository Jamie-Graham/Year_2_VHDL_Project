--
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
     ENABLE_V: in STD_LOGIC_VECTOR(0 to 3):="0000";-- in vector form to better make use of generate statements
     LED_V:out STD_LOGIC_VECTOR (0 to 3):="0000";
     OUTPUT_DISPLAY:out STD_lOGIC_VECTOR(6 downto 0);
     an: out STD_logic_vector(0 to 3)

     );
 
     
end Attendance_monitor;

architecture Behavioral of Attendance_monitor is
constant max_count_one:integer:=250000; -- since we want a refresh of 400 Hz and the board uses 100 Mhz, need to split using count
constant max_count_two:integer:=25000000;-- we want one count to be added per second, which means we need to count 25,000,000 per second
--constant max_count_one:integer:=5; -- FOR SIM ONLY, used for testing, ENSURE THIS IS COMMENTED OUT WHEN SYNTHESISING
--constant max_count_two:integer:=5; -- FOR SIM ONLY, used for testing, ENSURE THIS IS COMMENTED OUT WHEN SYNTHESISING 

type vector_of_vectors is array(natural range<>) of std_logic_vector (6 downto 0);
signal section_count: vector_of_vectors (0 to 3);
signal internal_count:std_logic_vector(8 downto 0); -- used to connect the adder to encoder
signal display_select:std_logic_vector(1 downto 0); -- used to allow for each of the seven segment display to refresh 100 times per second so signal is 400 Hz as well as select the anode for the seven segment display
signal internal_clock:std_logic; -- used so that when pressing a button, enable doesnt trigger thousands of times, frequency of 4 Hz
signal LEADING_ZERO,TOTAL_COUNT_MSB,TOTAL_COUNT_MID, TOTAL_COUNT_LSB:std_logic_vector (6 downto 0);
                        
component Counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           COUNT_OUTPUT : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC);
end component;


component Adder is 
    port (N: in STD_LOGIC_Vector(6 downto 0);
          E : in STD_LOGIC_Vector(6 downto 0);
          S : in STD_LOGIC_Vector(6 downto 0);
          W : in STD_LOGIC_Vector(6 downto 0);
          Output: out std_logic_Vector(8 downto 0));
    
end component;

component Encoder is
    Port ( total_count : in STD_LOGIC_VECTOR (8 downto 0);
           Leading_zero:out std_logic_vector (6 downto 0);
           Output_MSB : out STD_LOGIC_VECTOR (6 downto 0);
           Output_MID : out STD_LOGIC_VECTOR (6 downto 0);
           Output_LSB : out STD_LOGIC_VECTOR (6 downto 0));
            
end component;

component MUX is
    Port ( A : in std_logic_vector(6 downto 0);
           B : in STD_LOGIC_vector(6 downto 0);
           C : in STD_LOGIC_vector(6 downto 0);
           D : in STD_LOGIC_vector(6 downto 0);
           SEL : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_vector(6 downto 0));
end component;

begin
counter_generation: for I in 0 to 3 generate

Section_Counter: counter port map(CLK=>INTERNAL_CLOCK,
                                  RESET=>RESET_EXT,
                                  ENABLE=>ENABLE_V(I),
                                  LED=>LED_V(I),
                                  COUNT_OUTPUT=>section_count(I));

end generate ;
Total_count:adder port map(N=>section_count(0),
                            E=>section_count(1),
                            S=>section_count(2),
                            W=>section_count(3),
                            output=>internal_count);

unsigned_to_display:encoder port map(
                            total_count=>internal_count,
                            Leading_zero=>LEADING_ZERO,
                            Output_MSB=>TOTAL_COUNT_MSB,
                            Output_MID=>TOTAL_COUNT_MID,
                            Output_LSB=>TOTAL_COUNT_LSB);
                            
MUX_for_display:MUX port map(
                            A=>LEADING_Zero,
                            B=>TOTAL_COUNT_MSB,
                            C=>TOTAL_COUNT_MID,
                            D=>TOTAL_COUNT_LSB,
                            SEL=>display_select,
                            output=>OUTPUT_DISPLAY);                           
                        

select_displays:process(clk_ext) is 

variable count:unsigned(17 downto 0):= (others => '0');-- need 18 bits as 2^18 = 262,144 > 250,000

variable sel : unsigned(1 downto 0):="00";
begin
if rising_edge(clk_ext) then 
if count<max_count_one-1 then
count:= count+1;
else
count:=(others=>'0');
sel:=sel+1;
end if ;
display_select<=std_logic_vector(sel);

end if;
end process;

anode:process (display_select) is 
begin
case display_select is
        when "00" =>
            an<="0111";
        when "01" =>
            an<="1011";
        when "10" => 
            an<="1101";
        when "11" =>
            an<="1110";
        when others=>
        an<="0000"; --turns off all displays
end case;
end process;
clk_divide:process (clk_ext) is 
variable count :unsigned(24 downto 0):= (others => '0'); -- need 25 bits as 2^25 =33,554,432 > 25,000,000
variable clk:std_logic :='0';

begin 
if rising_edge (clk_ext) then
if count<max_count_two-1 then
count:= count+1;
else
count:=(others=> '0');
clk:=not clk; 
end if;
internal_clock<=clk;
end if;
end process;
end Behavioral;
