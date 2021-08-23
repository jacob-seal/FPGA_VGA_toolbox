----------------------------------------------------------------------------------
--Developed By : Jacob Seal
--sealenator@gmail.com
--08-13-2021
--filename: my_Useful_Utils_pkg.vhd
--package my_Useful_Utils_pkg
--
--********************************************************************************
--general notes:
--Package file containing generally useful functions
--
--FUNCTIONS:
--f_log2 - returns the log base 2 of a number(input needs to be power of 2)
--********************************************************************************
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
    
    package my_Useful_Utils_pkg is

    -----------------------------------------------------------------------------
    -- Constants 
    -----------------------------------------------------------------------------

    -----------------------------------------------------------------------------
    -- Function Declarations
    -----------------------------------------------------------------------------



    function f_log2 (x : positive) return natural;
    
    -----------------------------------------------------------------------------
    -- Component Declarations
    -----------------------------------------------------------------------------
    --UART
        component UART_RX is
            generic (
                    g_CLKS_PER_BIT : integer := 217     -- Needs to be set correctly
                    );
            port    (
                    i_Clk       : in  std_logic;
                    i_RX_Serial : in  std_logic;
                    o_RX_DV     : out std_logic;
                    o_RX_Byte   : out std_logic_vector(7 downto 0)
                    );
        end component UART_RX;

        component UART_TX is
            generic (
                    g_CLKS_PER_BIT : integer := 217     -- Needs to be set correctly
                    );
            port    (
                    i_Clk       : in  std_logic;
                    i_TX_DV     : in  std_logic;
                    i_TX_Byte   : in  std_logic_vector(7 downto 0);
                    o_TX_Active : out std_logic;
                    o_TX_Serial : out std_logic;
                    o_TX_Done   : out std_logic
                    );
        end component UART_TX;

    --7 segment display
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
        end component bin_to_7seg;

        component bin_to_7seg_3bit is
            port    (
                    i_Clk : in std_logic;
                    i_Bin_Num : in std_logic_vector(2 downto 0);
                    o_Seg_A : out std_logic;
                    o_Seg_B : out std_logic;
                    o_Seg_C : out std_logic;
                    o_Seg_D : out std_logic;
                    o_Seg_E : out std_logic;
                    o_Seg_F : out std_logic;
                    o_Seg_G : out std_logic
                    );
        end component bin_to_7seg_3bit;
    
    --Debounce Switches
        component Debounce_Switch is
            generic (
                    DEBOUNCE_LIMIT : integer := 250000);
            port    (
                    i_Clk    : in  std_logic;
                    i_Switch : in  std_logic;
                    o_Switch : out std_logic
                    );
        end component Debounce_Switch;

        component Debounce_Multi_Input is
            generic (
                    NUM_INPUTS     : integer := 2;
                    DEBOUNCE_LIMIT : integer := 250000
                    );
            port    (
                    i_Clk      : in  std_logic;
                    i_Switches : in  std_logic_vector(NUM_INPUTS-1 downto 0);
                    o_Switches : out std_logic_vector(NUM_INPUTS-1 downto 0)
                    );
        end component Debounce_Multi_Input; 

    --SRAM
        component single_port_SRAM is
            generic (
                    WIDTH : integer := 256;
                    DEPTH : integer := 16
                    );
            port    (
                    i_Ram_Addr: in std_logic_vector(f_log2(WIDTH) - 1 downto 0); -- Address to write/read RAM
                    i_Ram_Data_in: in std_logic_vector(7 downto 0); -- Data to write into RAM
                    i_Ram_WR_en: in std_logic; -- Write enable 
                    i_Ram_Clk: in std_logic; -- clock input for RAM
                    o_Ram_Data_out: out std_logic_vector(7 downto 0) -- Data output of RAM
                    );
        end component single_port_SRAM;    



    

        
    end package;

    package body my_Useful_Utils_pkg is

    --function returns the log base 2 of a number(input needs to be power of 2)
    function f_log2 (x : positive) return natural is
        variable i : natural;
    begin
        i := 0;  
        while (2**i < x) and i < 31 loop
            i := i + 1;
        end loop;
        return i;
    end function;
        
    end package body;