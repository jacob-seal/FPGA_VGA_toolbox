----------------------------------------------------------------------------------
--Developed By : Jacob Seal
--sealenator@gmail.com
--08-23-2021
--filename: Keypad_Wrapper.vhd
--entity Keypad_Wrapper
--
--********************************************************************************
--general notes:
--wrapper for the keypad decoder. This is strictly for ease of use and to give 
--      a layer of abstraction between the top level and the decoder
--
--INPUTS
--i_Clk - clock input
--
--i_ROW_4 - i_ROW(4 to 1) receives the 4 bit value of the current row 
--i_ROW_3 - these values come directly from the PMOD inputs
--i_ROW_2 -
--i_ROW_1 -
-- OUTPUTS 
--o_COL_4 - o_COL(4 to 1) sends the current column being scanned as a binary
--o_COL_3 - vector. 
--o_COL_2 - 
--o_COL_1 - 
-- o_Decoded - the value of the pressed button in binary 
--
--The I/O from the PMOD interface should be assigned as follows:
--o_COL_4 - io_PMOD_1
--o_COL_3 - io_PMOD_2
--o_COL_2 - io_PMOD_3
--o_COL_1 - io_PMOD_4
--i_ROW_4 - io_PMOD_7
--i_ROW_3 - io_PMOD_8
--i_ROW_2 - io_PMOD_9
--i_ROW_1 - io_PMOD_10
--********************************************************************************
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Keypad_Wrapper is
  port (
    --clock input 25 MHz
	i_Clk   : in  std_logic;
	
	--IO for the rows and columns(PMOD at top level)
    i_ROW_4 : in std_logic;
    i_ROW_3 : in std_logic;
    i_ROW_2 : in std_logic;
    i_ROW_1 : in std_logic;
    
    o_COL_4 : out std_logic;
    o_COL_3 : out std_logic;
    o_COL_2 : out std_logic;
    o_COL_1 : out std_logic;
    --decoded output
    o_Decoded : out std_logic_vector(3 downto 0)	
    );
end Keypad_Wrapper;


architecture RTL of Keypad_Wrapper is
 
	--wire connection for PMOD inputs to the decoder
    signal w_COLS : std_logic_vector(3 downto 0);
    signal w_ROWS : std_logic_vector(3 downto 0);
    signal w_decoded : std_logic_vector(3 downto 0);


    component Keypad_Decoder is
    Port (
			    i_Clk : in  STD_LOGIC;
                i_Row : in  STD_LOGIC_VECTOR (3 downto 0);
			    o_Col : out  STD_LOGIC_VECTOR (3 downto 0);
                o_Decoded : out  STD_LOGIC_VECTOR (3 downto 0)
                );
    end component;    
	
	begin    
    --assign Row inputs to 
    w_Rows(0) <= i_ROW_4;
    w_Rows(1) <= i_ROW_3;
    w_Rows(2) <= i_ROW_2;
    w_Rows(3) <= i_ROW_1;


	
	--*****************************************************************************************************************************************
	--instantiate all required modules
	--*****************************************************************************************************************************************
	
	--decode keypad input

    keypad_input_decoder_1 : entity work.Keypad_Decoder
        port map(
            i_Clk => i_Clk,
            i_Row => w_Rows,
            o_Col => w_Cols,
            o_Decoded => w_decoded
        );
    

		

		
		
		
		

	--***********************************************************************************************************************************
	--end module instantiation
	--***********************************************************************************************************************************
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	--all processes in the next section
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	
	
	
	
	
	
	
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	--end of processes
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	
	
	
	
	--set outputs
    o_COL_4 <= w_COLS(0);
    o_COL_3 <= w_COLS(1);
    o_COL_2 <= w_COLS(2);
    o_COL_1 <= w_COLS(3);

    o_Decoded <= w_decoded;
	
	
end RTL;