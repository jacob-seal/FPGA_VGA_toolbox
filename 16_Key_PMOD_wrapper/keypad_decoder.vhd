----------------------------------------------------------------------------------
--Developed By : Jacob Seal
--sealenator@gmail.com
--08-23-2021
--filename: keypad_decoder.vhd
--entity Keypad_Decoder
--
--********************************************************************************
--general notes:
--This is a keypad decoder module for the DIGILENT 16 key PMOD keypad
--It can be used standalone but it is designed for use with the 
--      "Keypad_Wrapper" that can also be found in this directory.
--The decoder scans column by column using the row input value to determine
--      which button has been pressed
--
--INPUTS
--i_Clk - clock input
--
--i_Row - Current row input from the row that contains the pressed button.
--        The button currently being pressed is held LOW and has a '0' value
--
-- OUTPUTS 
-- o_Col - column that we are currently scanning. this goes as feedback to the 
--         device itself 
-- o_Decoded - the value of the pressed button in binary 
--********************************************************************************
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Keypad_Decoder is
    Port (
			    i_Clk : in  STD_LOGIC;
                i_Row : in  STD_LOGIC_VECTOR (3 downto 0);
			    o_Col : out  STD_LOGIC_VECTOR (3 downto 0);
                o_Decoded : out  STD_LOGIC_VECTOR (3 downto 0));
end Keypad_Decoder;

architecture Behavioral of Keypad_Decoder is

--counter for the columns to switch
signal r_col_switch_counter :STD_LOGIC_VECTOR(19 downto 0);

--wires to connect inputs and outputs
signal w_Row : std_logic_vector(3 downto 0);
signal w_Col : std_logic_vector(3 downto 0);
signal w_Decoded : std_logic_vector(3 downto 0);

begin

--assign inputs
    w_Row <= i_Row;
	--process to increment the column switch counter
    counter_proc : process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            if r_col_switch_counter = "01100001101010001001" then
                r_col_switch_counter <= "00000000000000000000";
            else
                r_col_switch_counter <= std_logic_vector(unsigned(r_col_switch_counter)+1);
            end if;
        end if;
        
    end process;

    --process to change columns at a regular interval so the row values can be tested
    column_changer : process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            case r_col_switch_counter is
                when "00011000011010100000" =>
                    w_Col<= "0111";
                when "00110000110101000000" =>
                    w_Col<= "1011";
                when "01001001001111100000" =>
                    w_Col<= "1101";
                when "01100001101010000000" =>
                    w_Col<= "1110";  
            end case;
            
        end if;
        
    end process;

    --cycle through the row values for each column to find the pressed button
    row_tester : process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            case w_Col is
                when "0111" =>
                    --R1
                    if w_Row = "0111" then
                        w_Decoded <= "0001";	--1
                    --R2
                    elsif w_Row = "1011" then
                        w_Decoded <= "0100"; --4
                    --R3
                    elsif w_Row = "1101" then
                        w_Decoded <= "0111"; --7
                    --R4
                    elsif w_Row = "1110" then
                        w_Decoded <= "0000"; --0
                    end if;
                when "1011" =>
                    --R1
                    if w_Row = "0111" then		
                        w_Decoded <= "0010"; --2
                    --R2
                    elsif w_Row = "1011" then
                        w_Decoded <= "0101"; --5
                    --R3
                    elsif w_Row = "1101" then
                        w_Decoded <= "1000"; --8
                    --R4
                    elsif w_Row = "1110" then
                        w_Decoded <= "1111"; --F
                    end if;
                when "1101" =>
                    --R1
                    if w_Row = "0111" then
                        w_Decoded <= "0011"; --3	
                    --R2
                    elsif w_Row = "1011" then
                        w_Decoded <= "0110"; --6
                    --R3
                    elsif w_Row = "1101" then
                        w_Decoded <= "1001"; --9
                    --R4
                    elsif w_Row = "1110" then
                        w_Decoded <= "1110"; --E
                    end if;
                when "1110" =>    
                    --R1
                    if w_Row = "0111" then
                        w_Decoded <= "1010"; --A
                    --R2
                    elsif w_Row = "1011" then
                        w_Decoded <= "1011"; --B
                    --R3
                    elsif w_Row = "1101" then
                        w_Decoded <= "1100"; --C
                    --R4
                    elsif w_Row = "1110" then
                        w_Decoded <= "1101"; --D
                    end if;
            
                when others =>
                    null;
            end case;            
        end if;
    end process;
    
    --assign outputs
    o_Col <= w_Col;
    o_Decoded <= w_Decoded;
end Behavioral;

