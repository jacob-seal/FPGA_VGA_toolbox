-- This module is designed for 640x480 with a 25 MHz input clock.
-- All test patterns are being generated all the time.  This makes use of one
-- of the benefits of FPGAs, they are highly parallelizable.  Many different
-- things can all be happening at the same time.  In this case, there are several
-- test patterns that are being generated simulatenously.  The actual choice of
-- which test pattern gets displayed is done via the i_Pattern signal, which is
-- an input to a case statement.

-- Available Patterns:
-- Pattern 0: Disables the Test Pattern Generator
-- Pattern 1: Text Generator
-- Pattern 2: DICE!!
-- Pattern 3: All Blue
-- Pattern 4: Checkerboard white/black
-- Pattern 5: Color Bars
-- Pattern 6: White Box with Border (2 pixels)
-- Pattern 7: Tic Tac Toe board
-- Pattern 8: White box centerd on screen
-- Pattern 9: Bitmap test!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.VGA_pkg.all;
use work.bitmaps_pkg.all;

entity Test_Pattern_Gen is
  generic (
    g_VIDEO_WIDTH : integer := 3;
    g_TOTAL_COLS  : integer := 800;
    g_TOTAL_ROWS  : integer := 525;
    g_ACTIVE_COLS : integer := 640;
    g_ACTIVE_ROWS : integer := 480
    );
  port (
    i_Clk     : in std_logic;
    i_Pattern : in std_logic_vector(3 downto 0);
    i_HSync   : in std_logic;
    i_VSync   : in std_logic;
    --
    o_HSync     : out std_logic := '0';
    o_VSync     : out std_logic := '0';
    o_Red_Video : out std_logic_vector(g_VIDEO_WIDTH-1 downto 0);
    o_Grn_Video : out std_logic_vector(g_VIDEO_WIDTH-1 downto 0);
    o_Blu_Video : out std_logic_vector(g_VIDEO_WIDTH-1 downto 0)
    );
end entity Test_Pattern_Gen;

architecture RTL of Test_Pattern_Gen is

  component Sync_To_Count is
    generic (
      g_TOTAL_COLS : integer;
      g_TOTAL_ROWS : integer
      );
    port (
      i_Clk   : in std_logic;
      i_HSync : in std_logic;
      i_VSync : in std_logic;

      o_HSync     : out std_logic;
      o_VSync     : out std_logic;
      o_Col_Count : out std_logic_vector(9 downto 0);
      o_Row_Count : out std_logic_vector(9 downto 0)
      );
  end component Sync_To_Count;

  signal w_VSync : std_logic;
  signal w_HSync : std_logic;

  
  -- Create a type that contains all Test Patterns.
  -- Patterns have 16 indexes (0 to 15) and can be g_VIDEO_WIDTH bits wide
  type t_Patterns is array (0 to 15) of std_logic_vector(g_VIDEO_WIDTH-1 downto 0);
  signal Pattern_Red : t_Patterns;
  signal Pattern_Grn : t_Patterns;
  signal Pattern_Blu : t_Patterns;
  
  -- Make these unsigned counters (always positive)
  --Col_Count is x position
  --Row_Count is y position
  signal w_Col_Count : std_logic_vector(9 downto 0);
  signal w_Row_Count : std_logic_vector(9 downto 0);

  signal w_Bar_Width  : integer range 0 to g_ACTIVE_COLS/8;
  signal w_Bar_Select : integer range 0 to 7;  -- Color Bars
    --output pixel for the VGA text generation
    signal pixel : std_logic;
    --counter to increment through the string array "stringmap"
    signal r_string_counter : integer range 0 to stringmap'high := 0;
    --connects the stringmap array to the input of Pixel On Text
    signal w_string : string (1 to stringmap(0)'high);
    --registers the input pattern signal
    signal r_i_Pattern : std_logic_vector(3 downto 0);
    --connects x and y position arrays to input of Pixel On Text
    signal w_x_pos_text : integer range 0 to 2**w_Col_Count'length;
    signal w_y_pos_text : integer range 0 to 2**w_Row_Count'length;


  --signal r_string_zero_flag : integer := 0;
  
begin
  
  -- Increment string counter to cycle through the array of messages
  p_string_counter : process (i_Clk) is 
  
  begin
    if rising_edge(i_clk) then 
        r_i_Pattern <= i_Pattern;                               --registered version of input pattern
        if i_Pattern = "0001" and r_i_Pattern /= "0001" then    --rising edge  
            
            if r_string_counter = 4 then
                r_string_counter <= 1;                          --index 0 is unused because it cannot first be displayed
            else                                                --can be done manually ex: w_string <= stringmap(0)
                r_string_counter <= r_string_counter + 1;    
            end if;

         end if;

    end if;

  end process p_string_counter;

  w_string <= stringmap(r_string_counter);
  w_x_pos_text <= c_x_pos_map(r_string_counter);
  w_y_pos_text <= c_y_pos_map(r_string_counter);

  
  
  --sets output pixel for text generator
  textElement1: entity work.Pixel_On_Text
        generic map (
        	textLength => stringmap(0)'high
        )
        port map(
        	clk => i_Clk,
        	displayText => w_string,
        	--position => (50, 50), -- text position (top left)
            x_pos => w_x_pos_text,
            y_pos => w_y_pos_text,
        	horzCoord => to_integer(unsigned(w_Col_Count)),
        	vertCoord => to_integer(unsigned(w_Row_Count)),
        	pixel => pixel -- result
        );
  
  
  
  
  
  
  Sync_To_Count_inst : Sync_To_Count
    generic map (
      g_TOTAL_COLS => g_TOTAL_COLS,
      g_TOTAL_ROWS => g_TOTAL_ROWS
      )
    port map (
      i_Clk       => i_Clk,
      i_HSync     => i_HSync,
      i_VSync     => i_VSync,
      o_HSync     => w_HSync,
      o_VSync     => w_VSync,
      o_Col_Count => w_Col_Count,
      o_Row_Count => w_Row_Count
      );

  
  -- Register syncs to align with output data.
  p_Reg_Syncs : process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      o_VSync <= w_VSync;
      o_HSync <= w_HSync;
    end if;
  end process p_Reg_Syncs; 

  

  -----------------------------------------------------------------------------
  -- Pattern 0: Disables the Test Pattern Generator
  -----------------------------------------------------------------------------
  Pattern_Red(0) <= (others => '0');
  Pattern_Grn(0) <= (others => '0');
  Pattern_Blu(0) <= (others => '0');
  
  -----------------------------------------------------------------------------
  -- Pattern 1: attempt at text generator
  -----------------------------------------------------------------------------
  Pattern_Red(1) <= (others => '1') when pixel = '1' else (others => '0');

                                          

  Pattern_Grn(1) <= Pattern_Red(1);
  Pattern_Blu(1) <= Pattern_Red(1);

  -----------------------------------------------------------------------------
  -- Pattern 2: writes the dice_bitmap to the screen
  -- with offset of 300 in x and 100 in y
  -----------------------------------------------------------------------------
  
  
  
  
  
--   Pattern_Red(2) <= (others => '1') when    (
--                                             ((to_integer(unsigned(w_Col_Count)) - 123 > -1 and
--                                             to_integer(unsigned(w_Row_Count)) - 150 > -1 and
--                                             to_integer(unsigned(w_Col_Count)) - 123 < c_dicemap(1)(0)'high + 1 and
--                                             to_integer(unsigned(w_Row_Count)) - 150 < c_dicemap(1)'high + 1) and
--                                             (c_dicemap(1)(to_integer(unsigned(w_Row_Count)) - 150)(to_integer(unsigned(w_Col_Count)) - 123) = '1'))
--                                              or
--                                              ((to_integer(unsigned(w_Col_Count)) - 370 > -1 and
--                                              to_integer(unsigned(w_Row_Count)) - 150 > -1 and
--                                              to_integer(unsigned(w_Col_Count)) - 370 < c_dicemap(3)(0)'high + 1 and
--                                              to_integer(unsigned(w_Row_Count)) - 150 < c_dicemap(3)'high + 1) and
--                                              (c_dicemap(3)(to_integer(unsigned(w_Row_Count)) - 150)(to_integer(unsigned(w_Col_Count)) - 370) = '1'))
--                                             )
--                                      else
--                                            (others => '0');


Pattern_Red(2) <= (others => '1') when    (
                                            ((to_integer(unsigned(w_Col_Count)) - ((g_ACTIVE_COLS - dual_dice_bitmap(0)'high)/2) > -1 and
                                            to_integer(unsigned(w_Row_Count)) - ((g_ACTIVE_ROWS - dual_dice_bitmap'high)/2) > -1 and
                                            to_integer(unsigned(w_Col_Count)) - (g_ACTIVE_COLS - dual_dice_bitmap(0)'high)/2 < dual_dice_bitmap(0)'high + 1 and
                                            to_integer(unsigned(w_Row_Count)) - ((g_ACTIVE_ROWS - dual_dice_bitmap'high)/2) < dual_dice_bitmap'high + 1) and
                                            (dual_dice_bitmap(to_integer(unsigned(w_Row_Count)) - ((g_ACTIVE_ROWS - dual_dice_bitmap'high)/2))(to_integer(unsigned(w_Col_Count)) - ((g_ACTIVE_COLS - dual_dice_bitmap(0)'high)/2)) = '1'))
                                             
                                            )
                                     else
                                           (others => '0');

                                          

  Pattern_Grn(2) <= Pattern_Red(2);
  Pattern_Blu(2) <= Pattern_Red(2);
  
  -----------------------------------------------------------------------------
  -- Pattern 3: All Blue
  -----------------------------------------------------------------------------
  Pattern_Red(3) <= (others => '0');
  Pattern_Grn(3) <= (others => '0');
  Pattern_Blu(3) <= (others => '1') when (to_integer(unsigned(w_Col_Count)) < g_ACTIVE_COLS and 
                                          to_integer(unsigned(w_Row_Count)) < g_ACTIVE_ROWS) else
                    (others => '0');

  -----------------------------------------------------------------------------
  -- Pattern 4: Checkerboard white/black
  -----------------------------------------------------------------------------
  --2^5 = 32. 640 / 32 = 20. this is the number of boxes horizontally
  --480 / 32 = 15. this is the number of boxes vertically
  Pattern_Red(4) <= (others => '1') when (w_Col_Count(5) = '0' xor  
                                          w_Row_Count(5) = '1') else
                    (others => '0');

  Pattern_Grn(4) <= Pattern_Red(4);
  Pattern_Blu(4) <= Pattern_Red(4);
  
  
  -----------------------------------------------------------------------------
  -- Pattern 5: Color Bars
  -- Divides active area into 8 Equal Bars and colors them accordingly
  -- Colors Each According to this Truth Table:
  -- R G B  w_Bar_Select  Ouput Color
  -- 0 0 0       0        Black
  -- 0 0 1       1        Blue
  -- 0 1 0       2        Green
  -- 0 1 1       3        Turquoise
  -- 1 0 0       4        Red
  -- 1 0 1       5        Purple
  -- 1 1 0       6        Yellow
  -- 1 1 1       7        White
  -----------------------------------------------------------------------------
  w_Bar_Width <= g_ACTIVE_COLS/8;
  
  w_Bar_Select <= 0 when unsigned(w_Col_Count) < w_Bar_Width*1 else
                  1 when unsigned(w_Col_Count) < w_Bar_Width*2 else
                  2 when unsigned(w_Col_Count) < w_Bar_Width*3 else
                  3 when unsigned(w_Col_Count) < w_Bar_Width*4 else
                  4 when unsigned(w_Col_Count) < w_Bar_Width*5 else
                  5 when unsigned(w_Col_Count) < w_Bar_Width*6 else
                  6 when unsigned(w_Col_Count) < w_Bar_Width*7 else
                  7;

  -- Implement Truth Table above with Conditional Assignments
  Pattern_Red(5) <= (others => '1') when (w_Bar_Select = 4 or w_Bar_Select = 5 or
                                          w_Bar_Select = 6 or w_Bar_Select = 7) else
                    (others => '0');

  Pattern_Grn(5) <= (others => '1') when (w_Bar_Select = 2 or w_Bar_Select = 3 or
                                          w_Bar_Select = 6 or w_Bar_Select = 7) else
                    (others => '0');

  Pattern_Blu(5) <= (others => '1') when (w_Bar_Select = 1 or w_Bar_Select = 3 or
                                          w_Bar_Select = 5 or w_Bar_Select = 7) else
                    (others => '0');
    
  
  -----------------------------------------------------------------------------
  -- Pattern 6: Black With White Border
  -- Creates a black screen with a white border 8 pixels wide around outside.
  -----------------------------------------------------------------------------
  Pattern_Red(6) <= (others => '1') when (to_integer(unsigned(w_Row_Count)) <= 7 or
                                          to_integer(unsigned(w_Row_Count)) >= g_ACTIVE_ROWS-7 or
                                          to_integer(unsigned(w_Col_Count)) <= 7 or
                                          to_integer(unsigned(w_Col_Count)) >= g_ACTIVE_COLS-7) else
                    (others => '0');

  Pattern_Grn(6) <= Pattern_Red(6);
  Pattern_Blu(6) <= Pattern_Red(6);

  -----------------------------------------------------------------------------
  -- Pattern 7: Tic-Tac-Toe board
  -- Creates a black screen with a lines outlining a tic tac toe board.
  -----------------------------------------------------------------------------
  Pattern_Red(7) <= (others => '1') when ((to_integer(unsigned(w_Row_Count)) <=
                                          g_ACTIVE_ROWS/3 and
                                          to_integer(unsigned(w_Row_Count)) >= g_ACTIVE_ROWS/3 - 2) or
                                          (to_integer(unsigned(w_Row_Count)) <=
                                          g_ACTIVE_ROWS - g_ACTIVE_ROWS/3 and
                                          to_integer(unsigned(w_Row_Count)) >=
                                          g_ACTIVE_ROWS - g_ACTIVE_ROWS/3 - 2) or
                                          (to_integer(unsigned(w_Col_Count)) <= g_ACTIVE_COLS/3 and
                                          to_integer(unsigned(w_Col_Count)) >= g_ACTIVE_COLS/3-2) or
                                          (to_integer(unsigned(w_Col_Count)) <=
                                          g_ACTIVE_COLS - g_ACTIVE_COLS/3 and 
                                          to_integer(unsigned(w_Col_Count)) >=
                                          g_ACTIVE_COLS - g_ACTIVE_COLS/3-2)) 
                                    else
                                          (others => '0');

                                          

  Pattern_Grn(7) <= Pattern_Red(7);
  Pattern_Blu(7) <= Pattern_Red(7);

  -----------------------------------------------------------------------------
  -- Pattern 8: Black With White Box in the middle
  -- Creates a black screen with a large-ish white box 2 pixels wide centered.
  -----------------------------------------------------------------------------
  Pattern_Red(8) <= (others => '1') 
    when  (--draw top line
          (to_integer(unsigned(w_Row_Count)) >=
          118 and
          to_integer(unsigned(w_Row_Count)) <= 
          120 and
          to_integer(unsigned(w_Col_Count)) >=
          158 and 
          to_integer(unsigned(w_Col_Count)) <=
          480) or
          --draw bottom line
          (to_integer(unsigned(w_Row_Count)) >=
          358 and
          to_integer(unsigned(w_Row_Count)) <= 
          360 and
          to_integer(unsigned(w_Col_Count)) >=
          160 and 
          to_integer(unsigned(w_Col_Count)) <=
          480) or 
          --draw left line
          (to_integer(unsigned(w_Row_Count)) >=
          120 and
          to_integer(unsigned(w_Row_Count)) <= 
          360 and
          to_integer(unsigned(w_Col_Count)) >=
          158 and 
          to_integer(unsigned(w_Col_Count)) <=
          160) or 
          --draw right line
          (to_integer(unsigned(w_Row_Count)) >=
          120 and
          to_integer(unsigned(w_Row_Count)) <= 
          360 and
          to_integer(unsigned(w_Col_Count)) >=
          478 and 
          to_integer(unsigned(w_Col_Count)) <=
          480)
          ) 
    else
      (others => '0');
  Pattern_Grn(8) <= Pattern_Red(8);
  Pattern_Blu(8) <= Pattern_Red(8);     

  -----------------------------------------------------------------------------
  -- Pattern 9: writes the bitmap to the screen
  -- current bitmap "test!" with offset of 300 in x and 100 in y
  -----------------------------------------------------------------------------
  Pattern_Red(9) <= (others => '1') when    (
                                            (to_integer(unsigned(w_Col_Count)) - 300 > -1 and
                                            to_integer(unsigned(w_Row_Count)) - 100 > -1 and
                                            to_integer(unsigned(w_Col_Count)) - 300 < bitmap(0)'high + 1 and
                                            to_integer(unsigned(w_Row_Count)) - 100 < bitmap'high + 1) and
                                            (bitmap(to_integer(unsigned(w_Row_Count)) - 100)(to_integer(unsigned(w_Col_Count)) - 300) = '1')
                                            )
                                     else
                                           (others => '0');

                                          

  Pattern_Grn(9) <= Pattern_Red(9);
  Pattern_Blu(9) <= Pattern_Red(9);


  -----------------------------------------------------------------------------
  -- Select between different test patterns
  -----------------------------------------------------------------------------
  p_TP_Select : process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      case i_Pattern is
        when "0000" =>
          o_Red_Video <= Pattern_Red(0);
          o_Grn_Video <= Pattern_Grn(0);
          o_Blu_Video <= Pattern_Blu(0);
        when "0001" =>
          o_Red_Video <= Pattern_Red(1);
          o_Grn_Video <= Pattern_Grn(1);
          o_Blu_Video <= Pattern_Blu(1);
        when "0010" =>
          o_Red_Video <= Pattern_Red(2);
          o_Grn_Video <= Pattern_Grn(2);
          o_Blu_Video <= Pattern_Blu(2);
        when "0011" =>
          o_Red_Video <= Pattern_Red(3);
          o_Grn_Video <= Pattern_Grn(3);
          o_Blu_Video <= Pattern_Blu(3);
        when "0100" =>
          o_Red_Video <= Pattern_Red(4);
          o_Grn_Video <= Pattern_Grn(4);
          o_Blu_Video <= Pattern_Blu(4);
        when "0101" =>
          o_Red_Video <= Pattern_Red(5);
          o_Grn_Video <= Pattern_Grn(5);
          o_Blu_Video <= Pattern_Blu(5);
        when "0110" =>
          o_Red_Video <= Pattern_Red(6);
          o_Grn_Video <= Pattern_Grn(6);
          o_Blu_Video <= Pattern_Blu(6);
          when "0111" =>
          o_Red_Video <= Pattern_Red(7);
          o_Grn_Video <= Pattern_Grn(7);
          o_Blu_Video <= Pattern_Blu(7);
        when "1000" =>
          o_Red_Video <= Pattern_Red(8);
          o_Grn_Video <= Pattern_Grn(8);
          o_Blu_Video <= Pattern_Blu(8); 
        when "1001" =>
          o_Red_Video <= Pattern_Red(9);
          o_Grn_Video <= Pattern_Grn(9);
          o_Blu_Video <= Pattern_Blu(9);    
        when others =>
          o_Red_Video <= Pattern_Red(0);
          o_Grn_Video <= Pattern_Grn(0);
          o_Blu_Video <= Pattern_Blu(0);
      end case;
    end if;
  end process p_TP_Select;

  
end architecture RTL;
