----------------------------------------------------------------------------------
--Developed By : Jacob Seal
--sealenator@gmail.com
--07-28-2021
--filename: craps_types_pkg.vhd
--package craps_types_pkg
--
--********************************************************************************
--general notes:
--Package file containing all Constants, Components, and functions 
--      used for VGA synthesis.
--********************************************************************************
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.bitmaps_pkg.all;

package VGA_pkg is

  -----------------------------------------------------------------------------
  -- Constants 
  -----------------------------------------------------------------------------
   
     --array containing all large dice bitmaps
--   type t_large_dicemap is array (1 to 6) of t_large_dice_bitmap;
--   constant c_dicemap : t_large_dicemap :=
--   (
--       large_dice_bitmap_1,
--       large_dice_bitmap_2,
--       large_dice_bitmap_3,
--       large_dice_bitmap_4,
--       large_dice_bitmap_5,
--       large_dice_bitmap_6
--   );


    --test text generation on the VGA
    type t_stringmap is array (0 to 4) of string(1 to 10);
        constant stringmap : t_stringmap :=
        (
            ("Empty     "),
            ("Test      "),
            ("Text      "),
            ("Generation"),
            ("On the VGA")
        );

    --x and y position arrays
    type t_x_pos_map is array (0 to 4) of integer;
        constant c_x_pos_map : t_x_pos_map :=
        (
            (50),
            (100),
            (300),
            (400),
            (500)
        );

    type t_y_pos_map is array (0 to 4) of integer;
        constant c_y_pos_map : t_y_pos_map :=
        (
            (50),
            (100),
            (200),
            (300),
            (400)
        );

        --x and y position arrays for red chip
    type t_x_pos_chipmap is array (0 to 6) of integer;
        constant c_x_pos_chipmap : t_x_pos_chipmap :=
        (
            (80),--0
            (155),--4
            (238),--5
            (320),--6
            (402),--8
            (485),--9
            (568)--10
        );

    type t_y_pos_chipmap is array (0 to 6) of integer;
        constant c_y_pos_chipmap : t_y_pos_chipmap :=
        (
            (23),
            (23),
            (23),
            (23),
            (23),
            (23),
            (23)
        );    
  


  -----------------------------------------------------------------------------
  -- Component Declarations
  -----------------------------------------------------------------------------
  

  -----------------------------------------------------------------------------
  -- Function Declarations
  -----------------------------------------------------------------------------
    function int_to_str_width_2 (int : in integer) return string;
    function int_to_str_width_4 (int : in integer) return string;

    function char_to_str (char : in std_logic_vector(7 downto 0)) return string;    

    

  
end package VGA_pkg;  

package body VGA_pkg is

    --accepts a single character(from ASCII VALUES) and returns it as a string
    function char_to_str (char : in std_logic_vector(7 downto 0)) return string is 

        variable a : std_logic_vector(7 downto 0);
        variable r : string( 1 to 1);
    begin

        a := char;

        case a is
            when X"30"      => r := "0";
            when X"31"      => r := "1";
            when X"32"      => r := "2";
            when X"33"      => r := "3";
            when X"34"      => r := "4";
            when X"35"      => r := "5";
            when X"36"      => r := "6";
            when X"37"      => r := "7";
            when X"38"      => r := "8";
            when X"39"      => r := "9";
            when X"61"      => r := "a";
            when X"62"      => r := "b";
            when X"63"      => r := "c";
            when X"64"      => r := "d";
            when X"65"      => r := "e";
            when X"66"      => r := "f";
            when X"67"      => r := "g";
            when X"68"      => r := "h";
            when X"69"      => r := "i";
            when X"6A"      => r := "j";
            when X"6B"      => r := "k";
            when X"6C"      => r := "l";
            when X"6D"      => r := "m";
            when X"6E"      => r := "n";
            when X"6F"      => r := "o";
            when X"70"      => r := "p";
            when X"71"      => r := "q";
            when X"72"      => r := "r";
            when X"73"      => r := "s";
            when X"74"      => r := "t";
            when X"75"      => r := "u";
            when X"76"      => r := "v";
            when X"77"      => r := "w";
            when X"78"      => r := "x";
            when X"79"      => r := "y";
            when X"7A"      => r := "z";
            when X"41"      => r := "A";
            when X"42"      => r := "B";
            when X"43"      => r := "C";
            when X"44"      => r := "D";
            when X"45"      => r := "E";
            when X"46"      => r := "F";
            when X"47"      => r := "G";
            when X"48"      => r := "H";
            when X"49"      => r := "I";
            when X"4A"      => r := "J";
            when X"4B"      => r := "K";
            when X"4C"      => r := "L";
            when X"4D"      => r := "M";
            when X"4E"      => r := "N";
            when X"4F"      => r := "O";
            when X"50"      => r := "P";
            when X"51"      => r := "Q";
            when X"52"      => r := "R";
            when X"53"      => r := "S";
            when X"54"      => r := "T";
            when X"55"      => r := "U";
            when X"56"      => r := "V";
            when X"57"      => r := "W";
            when X"58"      => r := "X";
            when X"59"      => r := "Y";
            when X"5A"      => r := "Z";
            when X"20"      => r := " ";--space bar
            when X"24"      => r := "$";--dollar sign
            when others     => r := "?";
        end case;

        return r;
    
    end function char_to_str;        

    --accepts an integer 0 through 12 and returns it as a string value
    function int_to_str_width_2 (int : in integer) return string is

        variable a : natural := 0;
        variable r : string(1 to 2);

    begin
        a := abs (int);

        case a is
            when 0 => r :=   "00";
            when 1 => r :=   "01";
            when 2 => r :=   "02";
            when 3 => r :=   "03";
            when 4 => r :=   "04";
            when 5 => r :=   "05";
            when 6 => r :=   "06";
            when 7 => r :=   "07";
            when 8 => r :=   "08";
            when 9 => r :=   "09";
            when 10 => r :=  "10";
            when 11 => r :=  "11";
            when 12 => r :=  "12";
            when 13 => r :=  "13";
            when 14 => r :=  "14";
            when 15 => r :=  "15";
            when 16 => r :=  "16";
            when 17 => r :=  "17";
            when 18 => r :=  "18";
            when 19 => r :=  "19";
            when 20 => r :=  "20";
            when 21 => r :=  "21";
            when 22 => r :=  "22";
            when 23 => r :=  "23";
            when 24 => r :=  "24";
            when 25 => r :=  "25";
            when 26 => r :=  "26";
            when 27 => r :=  "27";
            when 28 => r :=  "28";
            when 29 => r :=  "29";
            when 30 => r :=  "30";
            when 31 => r :=  "31";
            when 32 => r :=  "32";
            when 33 => r :=  "33";
            when 34 => r :=  "34";
            when 35 => r :=  "35";
            when 36 => r :=  "36";
            when 37 => r :=  "37";
            when 38 => r :=  "38";
            when 39 => r :=  "39";
            when 40 => r :=  "40";
            when 41 => r :=  "41";
            when 42 => r :=  "42";
            when 43 => r :=  "43";
            when 44 => r :=  "44";
            when 45 => r :=  "45";
            when 46 => r :=  "46";
            when 47 => r :=  "47";
            when 48 => r :=  "48";
            when 49 => r :=  "49";
            when 50 => r :=  "50";
            when 51 => r :=  "51";
            when 52 => r :=  "52";
            when 53 => r :=  "53";
            when 54 => r :=  "54";
            when 55 => r :=  "55";
            when 56 => r :=  "56";
            when 57 => r :=  "57";
            when 58 => r :=  "58";
            when 59 => r :=  "59";
            when 60 => r :=  "60";
            when 61 => r :=  "61";
            when 62 => r :=  "62";
            when 63 => r :=  "63";
            when 64 => r :=  "64";
            when 65 => r :=  "65";
            when 66 => r :=  "66";
            when 67 => r :=  "67";
            when 68 => r :=  "68";
            when 69 => r :=  "69";
            when 70 => r :=  "70";
            when 71 => r :=  "71";
            when 72 => r :=  "72";
            when 73 => r :=  "73";
            when 74 => r :=  "74";
            when 75 => r :=  "75";
            when 76 => r :=  "76";
            when 77 => r :=  "77";
            when 78 => r :=  "78";
            when 79 => r :=  "79";
            when 80 => r :=  "80";
            when 81 => r :=  "81";
            when 82 => r :=  "82";
            when 83 => r :=  "83";
            when 84 => r :=  "84";
            when 85 => r :=  "85";
            when 86 => r :=  "86";
            when 87 => r :=  "87";
            when 88 => r :=  "88";
            when 89 => r :=  "89";
            when 90 => r :=  "90";
            when 91 => r :=  "91";
            when 92 => r :=  "92";
            when 93 => r :=  "93";
            when 94 => r :=  "94";
            when 95 => r :=  "95";
            when 96 => r :=  "96";
            when 97 => r :=  "97";
            when 98 => r :=  "98";
            when 99 => r :=  "99";
            when others => r := "??";
        end case;

        return r;
         
    end function int_to_str_width_2;
    
    
    --accepts an integer 0 through 12 and returns it as a string value
    function int_to_str_width_4 (int : in integer) return string is

        variable a : natural := 0;
        variable r : string(1 to 4);

    begin
        a := abs (int);

        case a is
            when 0 => r :=   "0000";
            when 1 => r :=   "0001";
            when 2 => r :=   "0002";
            when 3 => r :=   "0003";
            when 4 => r :=   "0004";
            when 5 => r :=   "0005";
            when 6 => r :=   "0006";
            when 7 => r :=   "0007";
            when 8 => r :=   "0008";
            when 9 => r :=   "0009";
            when 10 => r :=  "0010";
            when 11 => r :=  "0011";
            when 12 => r :=  "0012";
            when 13 => r :=  "0013";
            when 14 => r :=  "0014";
            when 15 => r :=  "0015";
            when 16 => r :=  "0016";
            when 17 => r :=  "0017";
            when 18 => r :=  "0018";
            when 19 => r :=  "0019";
            when 20 => r :=  "0020";
            when 21 => r :=  "0021";
            when 22 => r :=  "0022";
            when 23 => r :=  "0023";
            when 24 => r :=  "0024";
            when 25 => r :=  "0025";
            when 26 => r :=  "0026";
            when 27 => r :=  "0027";
            when 28 => r :=  "0028";
            when 29 => r :=  "0029";
            when 30 => r :=  "0030";
            when 31 => r :=  "0031";
            when 32 => r :=  "0032";
            when 33 => r :=  "0033";
            when 34 => r :=  "0034";
            when 35 => r :=  "0035";
            when 36 => r :=  "0036";
            when 37 => r :=  "0037";
            when 38 => r :=  "0038";
            when 39 => r :=  "0039";
            when 40 => r :=  "0040";
            when 41 => r :=  "0041";
            when 42 => r :=  "0042";
            when 43 => r :=  "0043";
            when 44 => r :=  "0044";
            when 45 => r :=  "0045";
            when 46 => r :=  "0046";
            when 47 => r :=  "0047";
            when 48 => r :=  "0048";
            when 49 => r :=  "0049";
            when 50 => r :=  "0050";
            when 51 => r :=  "0051";
            when 52 => r :=  "0052";
            when 53 => r :=  "0053";
            when 54 => r :=  "0054";
            when 55 => r :=  "0055";
            when 56 => r :=  "0056";
            when 57 => r :=  "0057";
            when 58 => r :=  "0058";
            when 59 => r :=  "0059";
            when 60 => r :=  "0060";
            when 61 => r :=  "0061";
            when 62 => r :=  "0062";
            when 63 => r :=  "0063";
            when 64 => r :=  "0064";
            when 65 => r :=  "0065";
            when 66 => r :=  "0066";
            when 67 => r :=  "0067";
            when 68 => r :=  "0068";
            when 69 => r :=  "0069";
            when 70 => r :=  "0070";
            when 71 => r :=  "0071";
            when 72 => r :=  "0072";
            when 73 => r :=  "0073";
            when 74 => r :=  "0074";
            when 75 => r :=  "0075";
            when 76 => r :=  "0076";
            when 77 => r :=  "0077";
            when 78 => r :=  "0078";
            when 79 => r :=  "0079";
            when 80 => r :=  "0080";
            when 81 => r :=  "0081";
            when 82 => r :=  "0082";
            when 83 => r :=  "0083";
            when 84 => r :=  "0084";
            when 85 => r :=  "0085";
            when 86 => r :=  "0086";
            when 87 => r :=  "0087";
            when 88 => r :=  "0088";
            when 89 => r :=  "0089";
            when 90 => r :=  "0090";
            when 91 => r :=  "0091";
            when 92 => r :=  "0092";
            when 93 => r :=  "0093";
            when 94 => r :=  "0094";
            when 95 => r :=  "0095";
            when 96 => r :=  "0096";
            when 97 => r :=  "0097";
            when 98 => r :=  "0098";
            when 99 => r :=  "0099";
            when 100 => r :=  "0100";
            when 101 => r :=  "0101";
            when 102 => r :=  "0102";
            when 103 => r :=  "0103";
            when 104 => r :=  "0104";
            when 105 => r :=  "0105";
            when 106 => r :=  "0106";
            when 107 => r :=  "0107";
            when 108 => r :=  "0108";
            when 109 => r :=  "0109";
            when 110 => r :=  "0110";
            when 111 => r :=  "0111";
            when 112 => r :=  "0112";
            when 113 => r :=  "0113";
            when 114 => r :=  "0114";
            when 115 => r :=  "0115";
            when 116 => r :=  "0116";
            when 117 => r :=  "0117";
            when 118 => r :=  "0118";
            when 119 => r :=  "0119";
            when 120 => r :=  "0120";
            when 121 => r :=  "0121";
            when 122 => r :=  "0122";
            when 123 => r :=  "0123";
            when 124 => r :=  "0124";
            when 125 => r :=  "0125";
            when 126 => r :=  "0126";
            when 127 => r :=  "0127";
            when 128 => r :=  "0128";
            when 129 => r :=  "0129";
            when 130 => r :=  "0130";
            when 131 => r :=  "0131";
            when 132 => r :=  "0132";
            when 133 => r :=  "0133";
            when 134 => r :=  "0134";
            when 135 => r :=  "0135";
            when 136 => r :=  "0136";
            when 137 => r :=  "0137";
            when 138 => r :=  "0138";
            when 139 => r :=  "0139";
            when 140 => r :=  "0140";
            when 141 => r :=  "0141";
            when 142 => r :=  "0142";
            when 143 => r :=  "0143";
            when 144 => r :=  "0144";
            when 145 => r :=  "0145";
            when 146 => r :=  "0146";
            when 147 => r :=  "0147";
            when 148 => r :=  "0148";
            when 149 => r :=  "0149";
            when 150 => r :=  "0150";
            when 151 => r :=  "0151";
            when 152 => r :=  "0152";
            when 153 => r :=  "0153";
            when 154 => r :=  "0154";
            when 155 => r :=  "0155";
            when 156 => r :=  "0156";
            when 157 => r :=  "0157";
            when 158 => r :=  "0158";
            when 159 => r :=  "0159";
            when 160 => r :=  "0160";
            when 161 => r :=  "0161";
            when 162 => r :=  "0162";
            when 163 => r :=  "0163";
            when 164 => r :=  "0164";
            when 165 => r :=  "0165";
            when 166 => r :=  "0166";
            when 167 => r :=  "0167";
            when 168 => r :=  "0168";
            when 169 => r :=  "0169";
            when 170 => r :=  "0170";
            when 171 => r :=  "0171";
            when 172 => r :=  "0172";
            when 173 => r :=  "0173";
            when 174 => r :=  "0174";
            when 175 => r :=  "0175";
            when 176 => r :=  "0176";
            when 177 => r :=  "0177";
            when 178 => r :=  "0178";
            when 179 => r :=  "0179";
            when 180 => r :=  "0180";
            when 181 => r :=  "0181";
            when 182 => r :=  "0182";
            when 183 => r :=  "0183";
            when 184 => r :=  "0184";
            when 185 => r :=  "0185";
            when 186 => r :=  "0186";
            when 187 => r :=  "0187";
            when 188 => r :=  "0188";
            when 189 => r :=  "0189";
            when 190 => r :=  "0190";
            when 191 => r :=  "0191";
            when 192 => r :=  "0192";
            when 193 => r :=  "0193";
            when 194 => r :=  "0194";
            when 195 => r :=  "0195";
            when 196 => r :=  "0196";
            when 197 => r :=  "0197";
            when 198 => r :=  "0198";
            when 199 => r :=  "0199";
            when 200 => r :=  "0200";
            when 201 => r :=  "0201";
            when 202 => r :=  "0202";
            when 203 => r :=  "0203";
            when 204 => r :=  "0204";
            when 205 => r :=  "0205";
            when 206 => r :=  "0206";
            when 207 => r :=  "0207";
            when 208 => r :=  "0208";
            when 209 => r :=  "0209";
            when 210 => r :=  "0210";
            when 211 => r :=  "0211";
            when 212 => r :=  "0212";
            when 213 => r :=  "0213";
            when 214 => r :=  "0214";
            when 215 => r :=  "0215";
            when 216 => r :=  "0216";
            when 217 => r :=  "0217";
            when 218 => r :=  "0218";
            when 219 => r :=  "0219";
            when 220 => r :=  "0220";
            when 221 => r :=  "0221";
            when 222 => r :=  "0222";
            when 223 => r :=  "0223";
            when 224 => r :=  "0224";
            when 225 => r :=  "0225";
            when 226 => r :=  "0226";
            when 227 => r :=  "0227";
            when 228 => r :=  "0228";
            when 229 => r :=  "0229";
            when 230 => r :=  "0230";
            when 231 => r :=  "0231";
            when 232 => r :=  "0232";
            when 233 => r :=  "0233";
            when 234 => r :=  "0234";
            when 235 => r :=  "0235";
            when 236 => r :=  "0236";
            when 237 => r :=  "0237";
            when 238 => r :=  "0238";
            when 239 => r :=  "0239";
            when 240 => r :=  "0240";
            when 241 => r :=  "0241";
            when 242 => r :=  "0242";
            when 243 => r :=  "0243";
            when 244 => r :=  "0244";
            when 245 => r :=  "0245";
            when 246 => r :=  "0246";
            when 247 => r :=  "0247";
            when 248 => r :=  "0248";
            when 249 => r :=  "0249";
            when 250 => r :=  "0250";
            when 251 => r :=  "0251";
            when 252 => r :=  "0252";
            when 253 => r :=  "0253";
            when 254 => r :=  "0254";
            when 255 => r :=  "0255";
            when 256 => r :=  "0256";
            when 257 => r :=  "0257";
            when 258 => r :=  "0258";
            when 259 => r :=  "0259";
            when 260 => r :=  "0260";
            when 261 => r :=  "0261";
            when 262 => r :=  "0262";
            when 263 => r :=  "0263";
            when 264 => r :=  "0264";
            when 265 => r :=  "0265";
            when 266 => r :=  "0266";
            when 267 => r :=  "0267";
            when 268 => r :=  "0268";
            when 269 => r :=  "0269";
            when 270 => r :=  "0270";
            when 271 => r :=  "0271";
            when 272 => r :=  "0272";
            when 273 => r :=  "0273";
            when 274 => r :=  "0274";
            when 275 => r :=  "0275";
            when 276 => r :=  "0276";
            when 277 => r :=  "0277";
            when 278 => r :=  "0278";
            when 279 => r :=  "0279";
            when 280 => r :=  "0280";
            when 281 => r :=  "0281";
            when 282 => r :=  "0282";
            when 283 => r :=  "0283";
            when 284 => r :=  "0284";
            when 285 => r :=  "0285";
            when 286 => r :=  "0286";
            when 287 => r :=  "0287";
            when 288 => r :=  "0288";
            when 289 => r :=  "0289";
            when 290 => r :=  "0290";
            when 291 => r :=  "0291";
            when 292 => r :=  "0292";
            when 293 => r :=  "0293";
            when 294 => r :=  "0294";
            when 295 => r :=  "0295";
            when 296 => r :=  "0296";
            when 297 => r :=  "0297";
            when 298 => r :=  "0298";
            when 299 => r :=  "0299";
            when 300 => r :=  "0300";
            when 301 => r :=  "0301";
            when 302 => r :=  "0302";
            when 303 => r :=  "0303";
            when 304 => r :=  "0304";
            when 305 => r :=  "0305";
            when 306 => r :=  "0306";
            when 307 => r :=  "0307";
            when 308 => r :=  "0308";
            when 309 => r :=  "0309";
            when 310 => r :=  "0310";
            when 311 => r :=  "0311";
            when 312 => r :=  "0312";
            when 313 => r :=  "0313";
            when 314 => r :=  "0314";
            when 315 => r :=  "0315";
            when 316 => r :=  "0316";
            when 317 => r :=  "0317";
            when 318 => r :=  "0318";
            when 319 => r :=  "0319";
            when 320 => r :=  "0320";
            when 321 => r :=  "0321";
            when 322 => r :=  "0322";
            when 323 => r :=  "0323";
            when 324 => r :=  "0324";
            when 325 => r :=  "0325";
            when 326 => r :=  "0326";
            when 327 => r :=  "0327";
            when 328 => r :=  "0328";
            when 329 => r :=  "0329";
            when 330 => r :=  "0330";
            when 331 => r :=  "0331";
            when 332 => r :=  "0332";
            when 333 => r :=  "0333";
            when 334 => r :=  "0334";
            when 335 => r :=  "0335";
            when 336 => r :=  "0336";
            when 337 => r :=  "0337";
            when 338 => r :=  "0338";
            when 339 => r :=  "0339";
            when 340 => r :=  "0340";
            when 341 => r :=  "0341";
            when 342 => r :=  "0342";
            when 343 => r :=  "0343";
            when 344 => r :=  "0344";
            when 345 => r :=  "0345";
            when 346 => r :=  "0346";
            when 347 => r :=  "0347";
            when 348 => r :=  "0348";
            when 349 => r :=  "0349";
            when 350 => r :=  "0350";
            when 351 => r :=  "0351";
            when 352 => r :=  "0352";
            when 353 => r :=  "0353";
            when 354 => r :=  "0354";
            when 355 => r :=  "0355";
            when 356 => r :=  "0356";
            when 357 => r :=  "0357";
            when 358 => r :=  "0358";
            when 359 => r :=  "0359";
            when 360 => r :=  "0360";
            when 361 => r :=  "0361";
            when 362 => r :=  "0362";
            when 363 => r :=  "0363";
            when 364 => r :=  "0364";
            when 365 => r :=  "0365";
            when 366 => r :=  "0366";
            when 367 => r :=  "0367";
            when 368 => r :=  "0368";
            when 369 => r :=  "0369";
            when 370 => r :=  "0370";
            when 371 => r :=  "0371";
            when 372 => r :=  "0372";
            when 373 => r :=  "0373";
            when 374 => r :=  "0374";
            when 375 => r :=  "0375";
            when 376 => r :=  "0376";
            when 377 => r :=  "0377";
            when 378 => r :=  "0378";
            when 379 => r :=  "0379";
            when 380 => r :=  "0380";
            when 381 => r :=  "0381";
            when 382 => r :=  "0382";
            when 383 => r :=  "0383";
            when 384 => r :=  "0384";
            when 385 => r :=  "0385";
            when 386 => r :=  "0386";
            when 387 => r :=  "0387";
            when 388 => r :=  "0388";
            when 389 => r :=  "0389";
            when 390 => r :=  "0390";
            when 391 => r :=  "0391";
            when 392 => r :=  "0392";
            when 393 => r :=  "0393";
            when 394 => r :=  "0394";
            when 395 => r :=  "0395";
            when 396 => r :=  "0396";
            when 397 => r :=  "0397";
            when 398 => r :=  "0398";
            when 399 => r :=  "0399";
            when 400 => r :=  "0400";
            when 401 => r :=  "0401";
            when 402 => r :=  "0402";
            when 403 => r :=  "0403";
            when 404 => r :=  "0404";
            when 405 => r :=  "0405";
            when 406 => r :=  "0406";
            when 407 => r :=  "0407";
            when 408 => r :=  "0408";
            when 409 => r :=  "0409";
            when 410 => r :=  "0410";
            when 411 => r :=  "0411";
            when 412 => r :=  "0412";
            when 413 => r :=  "0413";
            when 414 => r :=  "0414";
            when 415 => r :=  "0415";
            when 416 => r :=  "0416";
            when 417 => r :=  "0417";
            when 418 => r :=  "0418";
            when 419 => r :=  "0419";
            when 420 => r :=  "0420";
            when 421 => r :=  "0421";
            when 422 => r :=  "0422";
            when 423 => r :=  "0423";
            when 424 => r :=  "0424";
            when 425 => r :=  "0425";
            when 426 => r :=  "0426";
            when 427 => r :=  "0427";
            when 428 => r :=  "0428";
            when 429 => r :=  "0429";
            when 430 => r :=  "0430";
            when 431 => r :=  "0431";
            when 432 => r :=  "0432";
            when 433 => r :=  "0433";
            when 434 => r :=  "0434";
            when 435 => r :=  "0435";
            when 436 => r :=  "0436";
            when 437 => r :=  "0437";
            when 438 => r :=  "0438";
            when 439 => r :=  "0439";
            when 440 => r :=  "0440";
            when 441 => r :=  "0441";
            when 442 => r :=  "0442";
            when 443 => r :=  "0443";
            when 444 => r :=  "0444";
            when 445 => r :=  "0445";
            when 446 => r :=  "0446";
            when 447 => r :=  "0447";
            when 448 => r :=  "0448";
            when 449 => r :=  "0449";
            when 450 => r :=  "0450";
            when 451 => r :=  "0451";
            when 452 => r :=  "0452";
            when 453 => r :=  "0453";
            when 454 => r :=  "0454";
            when 455 => r :=  "0455";
            when 456 => r :=  "0456";
            when 457 => r :=  "0457";
            when 458 => r :=  "0458";
            when 459 => r :=  "0459";
            when 460 => r :=  "0460";
            when 461 => r :=  "0461";
            when 462 => r :=  "0462";
            when 463 => r :=  "0463";
            when 464 => r :=  "0464";
            when 465 => r :=  "0465";
            when 466 => r :=  "0466";
            when 467 => r :=  "0467";
            when 468 => r :=  "0468";
            when 469 => r :=  "0469";
            when 470 => r :=  "0470";
            when 471 => r :=  "0471";
            when 472 => r :=  "0472";
            when 473 => r :=  "0473";
            when 474 => r :=  "0474";
            when 475 => r :=  "0475";
            when 476 => r :=  "0476";
            when 477 => r :=  "0477";
            when 478 => r :=  "0478";
            when 479 => r :=  "0479";
            when 480 => r :=  "0480";
            when 481 => r :=  "0481";
            when 482 => r :=  "0482";
            when 483 => r :=  "0483";
            when 484 => r :=  "0484";
            when 485 => r :=  "0485";
            when 486 => r :=  "0486";
            when 487 => r :=  "0487";
            when 488 => r :=  "0488";
            when 489 => r :=  "0489";
            when 490 => r :=  "0490";
            when 491 => r :=  "0491";
            when 492 => r :=  "0492";
            when 493 => r :=  "0493";
            when 494 => r :=  "0494";
            when 495 => r :=  "0495";
            when 496 => r :=  "0496";
            when 497 => r :=  "0497";
            when 498 => r :=  "0498";
            when 499 => r :=  "0499";
            when 500 => r :=  "0500";
            when 501 => r :=  "0501";
            when 502 => r :=  "0502";
            when 503 => r :=  "0503";
            when 504 => r :=  "0504";
            when 505 => r :=  "0505";
            when 506 => r :=  "0506";
            when 507 => r :=  "0507";
            when 508 => r :=  "0508";
            when 509 => r :=  "0509";
            when 510 => r :=  "0510";
            when 511 => r :=  "0511";
            when 512 => r :=  "0512";
            when 513 => r :=  "0513";
            when 514 => r :=  "0514";
            when 515 => r :=  "0515";
            when 516 => r :=  "0516";
            when 517 => r :=  "0517";
            when 518 => r :=  "0518";
            when 519 => r :=  "0519";
            when 520 => r :=  "0520";
            when 521 => r :=  "0521";
            when 522 => r :=  "0522";
            when 523 => r :=  "0523";
            when 524 => r :=  "0524";
            when 525 => r :=  "0525";
            when 526 => r :=  "0526";
            when 527 => r :=  "0527";
            when 528 => r :=  "0528";
            when 529 => r :=  "0529";
            when 530 => r :=  "0530";
            when 531 => r :=  "0531";
            when 532 => r :=  "0532";
            when 533 => r :=  "0533";
            when 534 => r :=  "0534";
            when 535 => r :=  "0535";
            when 536 => r :=  "0536";
            when 537 => r :=  "0537";
            when 538 => r :=  "0538";
            when 539 => r :=  "0539";
            when 540 => r :=  "0540";
            when 541 => r :=  "0541";
            when 542 => r :=  "0542";
            when 543 => r :=  "0543";
            when 544 => r :=  "0544";
            when 545 => r :=  "0545";
            when 546 => r :=  "0546";
            when 547 => r :=  "0547";
            when 548 => r :=  "0548";
            when 549 => r :=  "0549";
            when 550 => r :=  "0550";
            when 551 => r :=  "0551";
            when 552 => r :=  "0552";
            when 553 => r :=  "0553";
            when 554 => r :=  "0554";
            when 555 => r :=  "0555";
            when 556 => r :=  "0556";
            when 557 => r :=  "0557";
            when 558 => r :=  "0558";
            when 559 => r :=  "0559";
            when 560 => r :=  "0560";
            when 561 => r :=  "0561";
            when 562 => r :=  "0562";
            when 563 => r :=  "0563";
            when 564 => r :=  "0564";
            when 565 => r :=  "0565";
            when 566 => r :=  "0566";
            when 567 => r :=  "0567";
            when 568 => r :=  "0568";
            when 569 => r :=  "0569";
            when 570 => r :=  "0570";
            when 571 => r :=  "0571";
            when 572 => r :=  "0572";
            when 573 => r :=  "0573";
            when 574 => r :=  "0574";
            when 575 => r :=  "0575";
            when 576 => r :=  "0576";
            when 577 => r :=  "0577";
            when 578 => r :=  "0578";
            when 579 => r :=  "0579";
            when 580 => r :=  "0580";
            when 581 => r :=  "0581";
            when 582 => r :=  "0582";
            when 583 => r :=  "0583";
            when 584 => r :=  "0584";
            when 585 => r :=  "0585";
            when 586 => r :=  "0586";
            when 587 => r :=  "0587";
            when 588 => r :=  "0588";
            when 589 => r :=  "0589";
            when 590 => r :=  "0590";
            when 591 => r :=  "0591";
            when 592 => r :=  "0592";
            when 593 => r :=  "0593";
            when 594 => r :=  "0594";
            when 595 => r :=  "0595";
            when 596 => r :=  "0596";
            when 597 => r :=  "0597";
            when 598 => r :=  "0598";
            when 599 => r :=  "0599";
            when 600 => r :=  "0600";
            when 601 => r :=  "0601";
            when 602 => r :=  "0602";
            when 603 => r :=  "0603";
            when 604 => r :=  "0604";
            when 605 => r :=  "0605";
            when 606 => r :=  "0606";
            when 607 => r :=  "0607";
            when 608 => r :=  "0608";
            when 609 => r :=  "0609";
            when 610 => r :=  "0610";
            when 611 => r :=  "0611";
            when 612 => r :=  "0612";
            when 613 => r :=  "0613";
            when 614 => r :=  "0614";
            when 615 => r :=  "0615";
            when 616 => r :=  "0616";
            when 617 => r :=  "0617";
            when 618 => r :=  "0618";
            when 619 => r :=  "0619";
            when 620 => r :=  "0620";
            when 621 => r :=  "0621";
            when 622 => r :=  "0622";
            when 623 => r :=  "0623";
            when 624 => r :=  "0624";
            when 625 => r :=  "0625";
            when 626 => r :=  "0626";
            when 627 => r :=  "0627";
            when 628 => r :=  "0628";
            when 629 => r :=  "0629";
            when 630 => r :=  "0630";
            when 631 => r :=  "0631";
            when 632 => r :=  "0632";
            when 633 => r :=  "0633";
            when 634 => r :=  "0634";
            when 635 => r :=  "0635";
            when 636 => r :=  "0636";
            when 637 => r :=  "0637";
            when 638 => r :=  "0638";
            when 639 => r :=  "0639";
            when 640 => r :=  "0640";
            when 641 => r :=  "0641";
            when 642 => r :=  "0642";
            when 643 => r :=  "0643";
            when 644 => r :=  "0644";
            when 645 => r :=  "0645";
            when 646 => r :=  "0646";
            when 647 => r :=  "0647";
            when 648 => r :=  "0648";
            when 649 => r :=  "0649";
            when 650 => r :=  "0650";
            when 651 => r :=  "0651";
            when 652 => r :=  "0652";
            when 653 => r :=  "0653";
            when 654 => r :=  "0654";
            when 655 => r :=  "0655";
            when 656 => r :=  "0656";
            when 657 => r :=  "0657";
            when 658 => r :=  "0658";
            when 659 => r :=  "0659";
            when 660 => r :=  "0660";
            when 661 => r :=  "0661";
            when 662 => r :=  "0662";
            when 663 => r :=  "0663";
            when 664 => r :=  "0664";
            when 665 => r :=  "0665";
            when 666 => r :=  "0666";
            when 667 => r :=  "0667";
            when 668 => r :=  "0668";
            when 669 => r :=  "0669";
            when 670 => r :=  "0670";
            when 671 => r :=  "0671";
            when 672 => r :=  "0672";
            when 673 => r :=  "0673";
            when 674 => r :=  "0674";
            when 675 => r :=  "0675";
            when 676 => r :=  "0676";
            when 677 => r :=  "0677";
            when 678 => r :=  "0678";
            when 679 => r :=  "0679";
            when 680 => r :=  "0680";
            when 681 => r :=  "0681";
            when 682 => r :=  "0682";
            when 683 => r :=  "0683";
            when 684 => r :=  "0684";
            when 685 => r :=  "0685";
            when 686 => r :=  "0686";
            when 687 => r :=  "0687";
            when 688 => r :=  "0688";
            when 689 => r :=  "0689";
            when 690 => r :=  "0690";
            when 691 => r :=  "0691";
            when 692 => r :=  "0692";
            when 693 => r :=  "0693";
            when 694 => r :=  "0694";
            when 695 => r :=  "0695";
            when 696 => r :=  "0696";
            when 697 => r :=  "0697";
            when 698 => r :=  "0698";
            when 699 => r :=  "0699";
            when 700 => r :=  "0700";
            when 701 => r :=  "0701";
            when 702 => r :=  "0702";
            when 703 => r :=  "0703";
            when 704 => r :=  "0704";
            when 705 => r :=  "0705";
            when 706 => r :=  "0706";
            when 707 => r :=  "0707";
            when 708 => r :=  "0708";
            when 709 => r :=  "0709";
            when 710 => r :=  "0710";
            when 711 => r :=  "0711";
            when 712 => r :=  "0712";
            when 713 => r :=  "0713";
            when 714 => r :=  "0714";
            when 715 => r :=  "0715";
            when 716 => r :=  "0716";
            when 717 => r :=  "0717";
            when 718 => r :=  "0718";
            when 719 => r :=  "0719";
            when 720 => r :=  "0720";
            when 721 => r :=  "0721";
            when 722 => r :=  "0722";
            when 723 => r :=  "0723";
            when 724 => r :=  "0724";
            when 725 => r :=  "0725";
            when 726 => r :=  "0726";
            when 727 => r :=  "0727";
            when 728 => r :=  "0728";
            when 729 => r :=  "0729";
            when 730 => r :=  "0730";
            when 731 => r :=  "0731";
            when 732 => r :=  "0732";
            when 733 => r :=  "0733";
            when 734 => r :=  "0734";
            when 735 => r :=  "0735";
            when 736 => r :=  "0736";
            when 737 => r :=  "0737";
            when 738 => r :=  "0738";
            when 739 => r :=  "0739";
            when 740 => r :=  "0740";
            when 741 => r :=  "0741";
            when 742 => r :=  "0742";
            when 743 => r :=  "0743";
            when 744 => r :=  "0744";
            when 745 => r :=  "0745";
            when 746 => r :=  "0746";
            when 747 => r :=  "0747";
            when 748 => r :=  "0748";
            when 749 => r :=  "0749";
            when 750 => r :=  "0750";
            when 751 => r :=  "0751";
            when 752 => r :=  "0752";
            when 753 => r :=  "0753";
            when 754 => r :=  "0754";
            when 755 => r :=  "0755";
            when 756 => r :=  "0756";
            when 757 => r :=  "0757";
            when 758 => r :=  "0758";
            when 759 => r :=  "0759";
            when 760 => r :=  "0760";
            when 761 => r :=  "0761";
            when 762 => r :=  "0762";
            when 763 => r :=  "0763";
            when 764 => r :=  "0764";
            when 765 => r :=  "0765";
            when 766 => r :=  "0766";
            when 767 => r :=  "0767";
            when 768 => r :=  "0768";
            when 769 => r :=  "0769";
            when 770 => r :=  "0770";
            when 771 => r :=  "0771";
            when 772 => r :=  "0772";
            when 773 => r :=  "0773";
            when 774 => r :=  "0774";
            when 775 => r :=  "0775";
            when 776 => r :=  "0776";
            when 777 => r :=  "0777";
            when 778 => r :=  "0778";
            when 779 => r :=  "0779";
            when 780 => r :=  "0780";
            when 781 => r :=  "0781";
            when 782 => r :=  "0782";
            when 783 => r :=  "0783";
            when 784 => r :=  "0784";
            when 785 => r :=  "0785";
            when 786 => r :=  "0786";
            when 787 => r :=  "0787";
            when 788 => r :=  "0788";
            when 789 => r :=  "0789";
            when 790 => r :=  "0790";
            when 791 => r :=  "0791";
            when 792 => r :=  "0792";
            when 793 => r :=  "0793";
            when 794 => r :=  "0794";
            when 795 => r :=  "0795";
            when 796 => r :=  "0796";
            when 797 => r :=  "0797";
            when 798 => r :=  "0798";
            when 799 => r :=  "0799";
            when 800 => r :=  "0800";
            when 801 => r :=  "0801";
            when 802 => r :=  "0802";
            when 803 => r :=  "0803";
            when 804 => r :=  "0804";
            when 805 => r :=  "0805";
            when 806 => r :=  "0806";
            when 807 => r :=  "0807";
            when 808 => r :=  "0808";
            when 809 => r :=  "0809";
            when 810 => r :=  "0810";
            when 811 => r :=  "0811";
            when 812 => r :=  "0812";
            when 813 => r :=  "0813";
            when 814 => r :=  "0814";
            when 815 => r :=  "0815";
            when 816 => r :=  "0816";
            when 817 => r :=  "0817";
            when 818 => r :=  "0818";
            when 819 => r :=  "0819";
            when 820 => r :=  "0820";
            when 821 => r :=  "0821";
            when 822 => r :=  "0822";
            when 823 => r :=  "0823";
            when 824 => r :=  "0824";
            when 825 => r :=  "0825";
            when 826 => r :=  "0826";
            when 827 => r :=  "0827";
            when 828 => r :=  "0828";
            when 829 => r :=  "0829";
            when 830 => r :=  "0830";
            when 831 => r :=  "0831";
            when 832 => r :=  "0832";
            when 833 => r :=  "0833";
            when 834 => r :=  "0834";
            when 835 => r :=  "0835";
            when 836 => r :=  "0836";
            when 837 => r :=  "0837";
            when 838 => r :=  "0838";
            when 839 => r :=  "0839";
            when 840 => r :=  "0840";
            when 841 => r :=  "0841";
            when 842 => r :=  "0842";
            when 843 => r :=  "0843";
            when 844 => r :=  "0844";
            when 845 => r :=  "0845";
            when 846 => r :=  "0846";
            when 847 => r :=  "0847";
            when 848 => r :=  "0848";
            when 849 => r :=  "0849";
            when 850 => r :=  "0850";
            when 851 => r :=  "0851";
            when 852 => r :=  "0852";
            when 853 => r :=  "0853";
            when 854 => r :=  "0854";
            when 855 => r :=  "0855";
            when 856 => r :=  "0856";
            when 857 => r :=  "0857";
            when 858 => r :=  "0858";
            when 859 => r :=  "0859";
            when 860 => r :=  "0860";
            when 861 => r :=  "0861";
            when 862 => r :=  "0862";
            when 863 => r :=  "0863";
            when 864 => r :=  "0864";
            when 865 => r :=  "0865";
            when 866 => r :=  "0866";
            when 867 => r :=  "0867";
            when 868 => r :=  "0868";
            when 869 => r :=  "0869";
            when 870 => r :=  "0870";
            when 871 => r :=  "0871";
            when 872 => r :=  "0872";
            when 873 => r :=  "0873";
            when 874 => r :=  "0874";
            when 875 => r :=  "0875";
            when 876 => r :=  "0876";
            when 877 => r :=  "0877";
            when 878 => r :=  "0878";
            when 879 => r :=  "0879";
            when 880 => r :=  "0880";
            when 881 => r :=  "0881";
            when 882 => r :=  "0882";
            when 883 => r :=  "0883";
            when 884 => r :=  "0884";
            when 885 => r :=  "0885";
            when 886 => r :=  "0886";
            when 887 => r :=  "0887";
            when 888 => r :=  "0888";
            when 889 => r :=  "0889";
            when 890 => r :=  "0890";
            when 891 => r :=  "0891";
            when 892 => r :=  "0892";
            when 893 => r :=  "0893";
            when 894 => r :=  "0894";
            when 895 => r :=  "0895";
            when 896 => r :=  "0896";
            when 897 => r :=  "0897";
            when 898 => r :=  "0898";
            when 899 => r :=  "0899";
            when 900 => r :=  "0900";
            when 901 => r :=  "0901";
            when 902 => r :=  "0902";
            when 903 => r :=  "0903";
            when 904 => r :=  "0904";
            when 905 => r :=  "0905";
            when 906 => r :=  "0906";
            when 907 => r :=  "0907";
            when 908 => r :=  "0908";
            when 909 => r :=  "0909";
            when 910 => r :=  "0910";
            when 911 => r :=  "0911";
            when 912 => r :=  "0912";
            when 913 => r :=  "0913";
            when 914 => r :=  "0914";
            when 915 => r :=  "0915";
            when 916 => r :=  "0916";
            when 917 => r :=  "0917";
            when 918 => r :=  "0918";
            when 919 => r :=  "0919";
            when 920 => r :=  "0920";
            when 921 => r :=  "0921";
            when 922 => r :=  "0922";
            when 923 => r :=  "0923";
            when 924 => r :=  "0924";
            when 925 => r :=  "0925";
            when 926 => r :=  "0926";
            when 927 => r :=  "0927";
            when 928 => r :=  "0928";
            when 929 => r :=  "0929";
            when 930 => r :=  "0930";
            when 931 => r :=  "0931";
            when 932 => r :=  "0932";
            when 933 => r :=  "0933";
            when 934 => r :=  "0934";
            when 935 => r :=  "0935";
            when 936 => r :=  "0936";
            when 937 => r :=  "0937";
            when 938 => r :=  "0938";
            when 939 => r :=  "0939";
            when 940 => r :=  "0940";
            when 941 => r :=  "0941";
            when 942 => r :=  "0942";
            when 943 => r :=  "0943";
            when 944 => r :=  "0944";
            when 945 => r :=  "0945";
            when 946 => r :=  "0946";
            when 947 => r :=  "0947";
            when 948 => r :=  "0948";
            when 949 => r :=  "0949";
            when 950 => r :=  "0950";
            when 951 => r :=  "0951";
            when 952 => r :=  "0952";
            when 953 => r :=  "0953";
            when 954 => r :=  "0954";
            when 955 => r :=  "0955";
            when 956 => r :=  "0956";
            when 957 => r :=  "0957";
            when 958 => r :=  "0958";
            when 959 => r :=  "0959";
            when 960 => r :=  "0960";
            when 961 => r :=  "0961";
            when 962 => r :=  "0962";
            when 963 => r :=  "0963";
            when 964 => r :=  "0964";
            when 965 => r :=  "0965";
            when 966 => r :=  "0966";
            when 967 => r :=  "0967";
            when 968 => r :=  "0968";
            when 969 => r :=  "0969";
            when 970 => r :=  "0970";
            when 971 => r :=  "0971";
            when 972 => r :=  "0972";
            when 973 => r :=  "0973";
            when 974 => r :=  "0974";
            when 975 => r :=  "0975";
            when 976 => r :=  "0976";
            when 977 => r :=  "0977";
            when 978 => r :=  "0978";
            when 979 => r :=  "0979";
            when 980 => r :=  "0980";
            when 981 => r :=  "0981";
            when 982 => r :=  "0982";
            when 983 => r :=  "0983";
            when 984 => r :=  "0984";
            when 985 => r :=  "0985";
            when 986 => r :=  "0986";
            when 987 => r :=  "0987";
            when 988 => r :=  "0988";
            when 989 => r :=  "0989";
            when 990 => r :=  "0990";
            when 991 => r :=  "0991";
            when 992 => r :=  "0992";
            when 993 => r :=  "0993";
            when 994 => r :=  "0994";
            when 995 => r :=  "0995";
            when 996 => r :=  "0996";
            when 997 => r :=  "0997";
            when 998 => r :=  "0998";
            when 999 => r :=  "0999";
            when 1000=> r :=  "1000";
            when others => r := "????";

        end case;

        
        	return r;
         
    end function int_to_str_width_4;
    
end package body VGA_pkg;




