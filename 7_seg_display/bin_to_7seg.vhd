library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--input 4 bit binary number, drives signal bit outputs to 7 seg display
entity bin_to_7seg is
	port(
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
		

end entity bin_to_7seg;

architecture rtl of bin_to_7seg is

	signal r_Hex_Encoding : std_logic_vector(7 downto 0) := (others => '0');
	
	begin
	
		process(i_Clk) is 
		begin
			if rising_edge(i_Clk) then
				case i_Bin_Num is
					when  "0000"=>
						r_Hex_Encoding <= X"7E"; --Hex value
					when "0001" =>
						r_Hex_Encoding <= X"30";
					when "0010" =>
						r_Hex_Encoding <= X"6D";
					when  "0011"=>
						r_Hex_Encoding <= X"79";
					when  "0100"=>
						r_Hex_Encoding <= X"33";	
					when  "0101"=>
						r_Hex_Encoding <= X"5B";
					when  "0110"=>
						r_Hex_Encoding <= X"5F";
					when  "0111"=>
						r_Hex_Encoding <= X"70";	
					when  "1000"=>
						r_Hex_Encoding <= X"7F";
					when  "1001"=>
						r_Hex_Encoding <= X"7B";
					when  "1010"=>
						r_Hex_Encoding <= X"77";
					when  "1011"=>
						r_Hex_Encoding <= X"1F";
					when  "1100"=>
						r_Hex_Encoding <= X"4E";
					when  "1101"=>
						r_Hex_Encoding <= X"3D";
					when  "1110"=>
						r_Hex_Encoding <= X"4F";	
					when others =>
					r_Hex_Encoding <= X"47";
						
				end case;
			end if;
		end process;
		
		o_Seg_A <= r_Hex_Encoding(6);
		o_Seg_B <= r_Hex_Encoding(5);
		o_Seg_C <= r_Hex_Encoding(4);
		o_Seg_D <= r_Hex_Encoding(3);
		o_Seg_E <= r_Hex_Encoding(2);
		o_Seg_F <= r_Hex_Encoding(1);
		o_Seg_G <= r_Hex_Encoding(0);
end architecture rtl;		