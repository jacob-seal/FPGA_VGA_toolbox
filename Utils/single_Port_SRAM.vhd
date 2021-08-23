
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

library work; 
use work.my_Useful_Utils_pkg.all;

-- A single-port RAM in VHDL
-- size is controlled by the generics
entity single_port_SRAM is
generic (
    WIDTH : integer := 256;
    DEPTH : integer := 16
);
port(
 i_Ram_Addr: in std_logic_vector(f_log2(WIDTH) - 1 downto 0); -- Address to write/read RAM
 i_Ram_Data_in: in std_logic_vector(DEPTH-1 downto 0); -- Data to write into RAM
 i_Ram_WR_en: in std_logic; -- Write enable 
 i_Ram_Clk: in std_logic; -- clock input for RAM
 o_Ram_Data_out: out std_logic_vector(DEPTH-1 downto 0) -- Data output of RAM
);
end single_port_SRAM;

architecture Behavioral of single_port_SRAM is
-- define the new type for the 256x16 RAM 
type RAM_ARRAY is array (0 to WIDTH-1 ) of std_logic_vector (DEPTH-1 downto 0);
signal RAM: RAM_ARRAY;
-- initial values in the RAM
--signal RAM: RAM_ARRAY :=(
--  x"5555",x"6666",x"7777",x"8888",-- 0x00: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x04: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x08: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x0C: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x10: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x14: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x18: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x1C: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x20: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x24: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x28: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x2C: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x30: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x34: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x38: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x3C: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x40: 
--  x"5555",x"6666",x"7777",x"8888",-- 0x44: 
--x"5555",x"6666",x"7777",x"8888",-- 0x48: 
--x"5555",x"6666",x"7777",x"8888",-- 0x4C: 
--x"5555",x"6666",x"7777",x"8888",-- 0x50: 
--x"5555",x"6666",x"7777",x"8888",-- 0x54: 
--x"5555",x"6666",x"7777",x"8888",-- 0x58: 
--x"5555",x"6666",x"7777",x"8888",-- 0x5C: 
--x"5555",x"6666",x"7777",x"8888",-- 0x60
--x"5555",x"6666",x"7777",x"8888",-- 0x64
--x"5555",x"6666",x"7777",x"8888",-- 0x68
--x"5555",x"6666",x"7777",x"8888",-- 0x6C
--x"5555",x"6666",x"7777",x"8888",-- 0x70
--x"5555",x"6666",x"7777",x"8888",-- 0x74
--x"5555",x"6666",x"7777",x"8888",-- 0x78
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888", 
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888",
--x"5555",x"6666",x"7777",x"8888" 
--); 
begin
process(i_Ram_Clk)
begin
 if(rising_edge(i_Ram_Clk)) then
 if(i_Ram_WR_en='1') then -- when write enable = 1, 
 -- write input data into RAM at the provided address
 RAM(to_integer(unsigned(i_Ram_Addr))) <= i_Ram_Data_in;
 -- The index of the RAM array type needs to be integer so
 -- converts i_Ram_Addr from std_logic_vector -> Unsigned -> Interger using numeric_std library
 end if;
 end if;
end process;
 -- Data to be read out 
 o_Ram_Data_out <= RAM(to_integer(unsigned(i_Ram_Addr)));
end Behavioral;