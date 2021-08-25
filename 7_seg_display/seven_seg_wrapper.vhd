----------------------------------------------------------------------------------
-- Engineer: Jacob Seal
-- 
-- Create Date: 08/24/2021 10:18:10 AM
-- Design Name: Seven Segment Display Wrapper
-- Module Name: seven_seg_wrapper - Behavioral
-- Target Devices: Digilent Nexys 4
-- Tool Versions: Vivado 2019.2
-- Description:     Wrapper to provide a "black box model" for the 7 segment 
--                  display banks on the Nexys4(or other boards as well). Simply
--                  connect the inputs and outputs at the top level and send 16 bit
--                  data into the wrapper and the HEX values of each 4 bit segment
--                  will appear on the display. The anode select controls which
--                  digit is currently active. Every 10.5ms the entire bank of anodes
--                  is swept through and the outputs updated. 
-- 
-- Dependencies: 
--  bin_to_7seg
--
-- Revision:
-- Revision 0.01 - File Created
--
-- Additional Comments: 
-- GENERICS:
--  display_select - set the value as follows to control which display is active
--                  0 - Leftmost display bank
--                  1 - Rightmost display bank
--
-- INPUTS:
--  i_input_number - 16 bit standard logic vector. 
--  There are 4 digits for each 7 segment display bank, driven by the input value:
--  Digit 1 - i_input_number(15 downto 12)
--  Digit 2 - i_input_number(11 downto 8)
--  Digit 3 - i_input_number(7 downto 4)
--  Digit 4 - i_input_number(3 downto 0)
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity seven_seg_wrapper is
    generic (
            display_select : integer := 0
            );
    Port    ( 
            --inputs
            i_Clk : in STD_LOGIC;
            i_input_number : in std_logic_vector(15 downto 0);
            --segment outputs
            o_Segment_A : out STD_LOGIC;
            o_Segment_B : out STD_LOGIC;
            o_Segment_C : out STD_LOGIC;
            o_Segment_D : out STD_LOGIC;
            o_Segment_E : out STD_LOGIC;
            o_Segment_F : out STD_LOGIC;
            o_Segment_G : out STD_LOGIC;
            --anode outputs
            o_anode_select_0 : out STD_LOGIC;
            o_anode_select_1 : out STD_LOGIC;
            o_anode_select_2 : out STD_LOGIC;
            o_anode_select_3 : out STD_LOGIC;
            o_anode_select_4 : out STD_LOGIC;
            o_anode_select_5 : out STD_LOGIC;
            o_anode_select_6 : out STD_LOGIC;
            o_anode_select_7 : out STD_LOGIC
            );
end seven_seg_wrapper;

architecture Behavioral of seven_seg_wrapper is


	
	--internal wires for connecting 7Seg outputs to bin converter outputs
	signal w_Segment_A : std_logic;
	signal w_Segment_B : std_logic;
	signal w_Segment_C : std_logic;
	signal w_Segment_D : std_logic;
	signal w_Segment_E : std_logic;
	signal w_Segment_F : std_logic;
	signal w_Segment_G : std_logic;

    --2 bit signal to control the active anode
    signal r_anode_select : std_logic_vector(1 downto 0) := (others=> '0');
    --carries the active status of all 8 possible anodes(active low)
    signal w_anode_active : std_logic_vector(7 downto 0) := (others => '0');
    --counter to provide timing for anode switching 
    signal running_counter : unsigned(19 downto 0) := (others => '0'); -- counts up to 1.048576M: 1.048576M/100MHz clock = 10.48ms period
    --16 bit input data
    signal w_input_number : std_logic_vector(15 downto 0) := (others => '0');
    --4 bit output data for each digit
    signal w_displayed_number : std_logic_vector(3 downto 0) := (others => '0');
    

    --component declarations
    component bin_to_7seg is
        port    (
                i_Clk : in std_logic;
                i_Bin_Num : in std_logic_vector(3 downto 0);
                o_Seg_A : out std_logic;
                o_Seg_B : out std_logic;
                o_Seg_C : out std_logic;
                o_Seg_D : out std_logic;
                o_Seg_E : out std_logic;
                o_Seg_F : out std_logic;
                o_Seg_G : out std_logic
                );
    end component;

begin

    --grab input data to display
    w_input_number <= i_input_number;

    --instantiate components
    
    --convert 4 bit binary input to output segments for 7Seg	
	bin_converter_seg1 : entity work.bin_to_7seg
		port map(
                i_Clk 	 => i_Clk,
                i_Bin_Num => w_displayed_number,
                o_Seg_A => w_Segment_A,
                o_Seg_B => w_Segment_B,
                o_Seg_C => w_Segment_C,
                o_Seg_D => w_Segment_D,
                o_Seg_E => w_Segment_E,
                o_Seg_F => w_Segment_F,
                o_Seg_G => w_Segment_G
                );		

    
--****************************************************************************************
--7-segment display controller                                                           *
--****************************************************************************************
    -- process to generate refresh period of 10.5ms(95 Hz) with a constantly running counter
    -- 1ms to 16 ms is OK for 7 7egment display
    process(i_Clk)
    begin 
        if rising_edge(i_Clk) then
            running_counter <= running_counter + 1;
        end if;
    end process;

    --set counter bits to trigger rollover to new anode(use the 2 MSB)
    r_anode_select <= std_logic_vector(running_counter(19 downto 18));

    --in 10.5ms, sweep through all the anodes(move the 0 through)-active low
    --display select = 0 is the left display bank. 1(else) is the right
    anode_select_proc : process (r_anode_select)
    begin
        case r_anode_select is
            when "00" =>
                if display_select = 0 then          --left display
                    w_anode_active <= "01111111";   --Digit 1
                else                                --right display
                    w_anode_active <= "11110111";   --Digit 1    
                end if;
            
            w_displayed_number <= w_input_number(15 downto 12);
            when "01" =>
            if display_select = 0 then              --left display
                w_anode_active <= "10111111";       --Digit 2
            else                                    --right display
                w_anode_active <= "11111011";       --Digit 2
            end if;
            
            w_displayed_number <= w_input_number(11 downto 8);
            when "10" =>
            if display_select = 0 then              --left display
                w_anode_active <= "11011111";       --Digit 3
            else                                    --right display
                w_anode_active <= "11111101";       --Digit 3            
            end if;
            
            w_displayed_number <= w_input_number(7 downto 4);
            when "11" =>
            if display_select = 0 then              --left display
                w_anode_active <= "11101111";       --Digit 4
            else                                    --right display
                w_anode_active <= "11111110";       --Digit 4
            end if;
            
            w_displayed_number <= w_input_number(3 downto 0);
        end case;
        
    end process;

--****************************************************************************************
--end 7-segment display controller                                                       *
--****************************************************************************************    

    --SET OUTPUTS

    --set anode select output
    o_anode_select_0 <= w_anode_active(0);
    o_anode_select_1 <= w_anode_active(1);
    o_anode_select_2 <= w_anode_active(2);
    o_anode_select_3 <= w_anode_active(3);
    o_anode_select_4 <= w_anode_active(4);
    o_anode_select_5 <= w_anode_active(5);
    o_anode_select_6 <= w_anode_active(6);
    o_anode_select_7 <= w_anode_active(7);

    --set outputs for segments
    --must invert due to electrical properties of 7 seg display
	o_Segment_A <= not w_Segment_A;
	o_Segment_B <= not w_Segment_B;
	o_Segment_C <= not w_Segment_C;
	o_Segment_D <= not w_Segment_D;
	o_Segment_E <= not w_Segment_E;
	o_Segment_F <= not w_Segment_F;
	o_Segment_G <= not w_Segment_G;

end Behavioral;
