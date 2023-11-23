library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use work.all;

entity tubes1 is
	port(	clk, rst : in std_logic;
			modeSin, modeCos, modeTan: in std_logic;
			Sudut: in std_logic_vector(31 downto 0);
			--counterOut : in std_logic_vector(3 downto 0); -- udah. hasil dari counter masuk ke main
			--counterOut2 : out std_logic_vector(3 downto 0); -- dari main ke counter
			--enMain : in std_logic; -- udah
			xI1 : out std_logic_vector(31 downto 0);
			xI2 : out std_logic_vector(31 downto 0);
			angka: out std_logic_vector(31 downto 0)
	);
end entity;

architecture tubes1_arc of tubes1 is

component counter is
	port(	clk, rst: in std_logic;
			rstCounter : in std_logic;
			enCounter : in std_logic;
			counterOut : out std_logic_vector(3 downto 0);
			counterOut2 : in std_logic_vector(3 downto 0)
	);
end component;

component fsm is
	port(	clk, rst : in std_logic; -- rst akan membuat nilai counter menjadu nol
			enMain : out std_logic;
			rstCounter : out std_logic;
			counterOut : in std_logic_vector(3 downto 0);
			enCounter : out std_logic			
	);
end component;

signal x0 : std_logic_vector(31 downto 0);
signal y0 : std_logic_vector(31 downto 0);
signal angle0 : std_logic_vector(31 downto 0);

-- xTemp = x -+ a. a = y*d*(2^-i)
-- yTemp = y +- b. b = x*d*(2^-i)
-- angleTemp = angle +- tanInv.
signal xTemp0 : std_logic_vector(32 downto 0);
signal yTemp0 : std_logic_vector(32 downto 0);
signal angleTemp0 : std_logic_vector(32 downto 0);
signal a0 : std_logic_vector(31 downto 0);
signal b0 : std_logic_vector(31 downto 0);

signal x1 : std_logic_vector(31 downto 0);
signal y1 : std_logic_vector(31 downto 0);
signal angle1 : std_logic_vector(31 downto 0);
signal xTemp1 : std_logic_vector(32 downto 0);
signal yTemp1 : std_logic_vector(32 downto 0);
signal angleTemp1 : std_logic_vector(32 downto 0);
signal a1 : std_logic_vector(31 downto 0);
signal b1 : std_logic_vector(31 downto 0);

signal x2 : std_logic_vector(31 downto 0);
signal y2 : std_logic_vector(31 downto 0);
signal angle2 : std_logic_vector(31 downto 0);
signal xTemp2 : std_logic_vector(32 downto 0);
signal yTemp2 : std_logic_vector(32 downto 0);
signal angleTemp2 : std_logic_vector(32 downto 0);
signal a2 : std_logic_vector(31 downto 0);
signal b2 : std_logic_vector(31 downto 0);

signal x3 : std_logic_vector(31 downto 0);
signal y3 : std_logic_vector(31 downto 0);
signal angle3 : std_logic_vector(31 downto 0);
signal xTemp3 : std_logic_vector(32 downto 0);
signal yTemp3 : std_logic_vector(32 downto 0);
signal angleTemp3 : std_logic_vector(32 downto 0);
signal a3 : std_logic_vector(31 downto 0);
signal b3 : std_logic_vector(31 downto 0);

signal x4 : std_logic_vector(31 downto 0);
signal y4 : std_logic_vector(31 downto 0);
signal angle4 : std_logic_vector(31 downto 0);
signal xTemp4 : std_logic_vector(32 downto 0);
signal yTemp4 : std_logic_vector(32 downto 0);
signal angleTemp4 : std_logic_vector(32 downto 0);
signal a4 : std_logic_vector(31 downto 0);
signal b4 : std_logic_vector(31 downto 0);

signal x5 : std_logic_vector(31 downto 0);
signal y5 : std_logic_vector(31 downto 0);
signal angle5 : std_logic_vector(31 downto 0);
signal xTemp5 : std_logic_vector(32 downto 0);
signal yTemp5 : std_logic_vector(32 downto 0);
signal angleTemp5 : std_logic_vector(32 downto 0);
signal a5 : std_logic_vector(31 downto 0);
signal b5 : std_logic_vector(31 downto 0);

signal x6 : std_logic_vector(31 downto 0);
signal y6 : std_logic_vector(31 downto 0);
signal angle6 : std_logic_vector(31 downto 0);
signal xTemp6 : std_logic_vector(32 downto 0);
signal yTemp6 : std_logic_vector(32 downto 0);
signal angleTemp6 : std_logic_vector(32 downto 0);
signal a6 : std_logic_vector(31 downto 0);
signal b6 : std_logic_vector(31 downto 0);

signal x7 : std_logic_vector(31 downto 0);
signal y7 : std_logic_vector(31 downto 0);
signal angle7 : std_logic_vector(31 downto 0);
signal xTemp7 : std_logic_vector(32 downto 0);
signal yTemp7 : std_logic_vector(32 downto 0);
signal angleTemp7 : std_logic_vector(32 downto 0);
signal a7 : std_logic_vector(31 downto 0);
signal b7 : std_logic_vector(31 downto 0);

signal x8 : std_logic_vector(31 downto 0);
signal y8 : std_logic_vector(31 downto 0);
signal angle8 : std_logic_vector(31 downto 0);
signal xTemp8 : std_logic_vector(32 downto 0);
signal yTemp8 : std_logic_vector(32 downto 0);
signal angleTemp8 : std_logic_vector(32 downto 0);
signal a8 : std_logic_vector(31 downto 0);
signal b8 : std_logic_vector(31 downto 0);

signal x9 : std_logic_vector(31 downto 0);
signal y9 : std_logic_vector(31 downto 0);
signal angle9 : std_logic_vector(31 downto 0);
signal xTemp9 : std_logic_vector(32 downto 0);
signal yTemp9 : std_logic_vector(32 downto 0);
signal angleTemp9 : std_logic_vector(32 downto 0);
signal a9 : std_logic_vector(31 downto 0);
signal b9 : std_logic_vector(31 downto 0);

signal x10 : std_logic_vector(31 downto 0);
signal y10 : std_logic_vector(31 downto 0);
signal angle10 : std_logic_vector(31 downto 0);
signal xTemp10 : std_logic_vector(32 downto 0);
signal yTemp10 : std_logic_vector(32 downto 0);
signal angleTemp10 : std_logic_vector(32 downto 0);
signal a10 : std_logic_vector(31 downto 0);
signal b10 : std_logic_vector(31 downto 0);

signal x11 : std_logic_vector(31 downto 0);
signal y11 : std_logic_vector(31 downto 0);
signal angle11 : std_logic_vector(31 downto 0);
signal xTemp11 : std_logic_vector(32 downto 0);
signal yTemp11 : std_logic_vector(32 downto 0);
signal angleTemp11 : std_logic_vector(32 downto 0);
signal a11 : std_logic_vector(31 downto 0);
signal b11 : std_logic_vector(31 downto 0);

signal x12 : std_logic_vector(31 downto 0);
signal y12 : std_logic_vector(31 downto 0);
signal angle12 : std_logic_vector(31 downto 0);
signal xTemp12 : std_logic_vector(32 downto 0);
signal yTemp12 : std_logic_vector(32 downto 0);
signal angleTemp12 : std_logic_vector(32 downto 0);
signal a12 : std_logic_vector(31 downto 0);
signal b12 : std_logic_vector(31 downto 0);

signal x13 : std_logic_vector(31 downto 0);
signal y13 : std_logic_vector(31 downto 0);
signal angle13 : std_logic_vector(31 downto 0);
signal xTemp13 : std_logic_vector(32 downto 0);
signal yTemp13 : std_logic_vector(32 downto 0);
signal angleTemp13 : std_logic_vector(32 downto 0);
signal a13 : std_logic_vector(31 downto 0);
signal b13 : std_logic_vector(31 downto 0);

signal xF : std_logic_vector(31 downto 0);
signal yF : std_logic_vector(31 downto 0);
signal angleF : std_logic_vector(31 downto 0);
signal tanInv0 : std_logic_vector(31 downto 0);



signal tanInv : std_logic_vector(31 downto 0);

signal angkaTemp : std_logic_vector(63 downto 0);
constant k : std_logic_vector(31 downto 0) := "00100110110111010010111100011010";  -- 1.1.30
signal rstCounter : std_logic;
signal enCounter : std_logic;
signal counterOut2 : std_logic_vector(3 downto 0);
signal counterOut : std_logic_vector(3 downto 0) := "0000";
signal enMain : std_logic:= '1';
signal iterasi1Cek : std_logic := '0';

signal kuadran: std_logic_vector(1 downto 0);
constant yP : std_logic_vector(31 downto 0) := "01011010000000000000000000000000";
--constant x- : std_logic_vector(31 downto 0) := "";
--constant y- : std_logic_vector(31 downto 0) := "";

begin

blokCounter : counter port map(
	clk => clk,
    rst => rst,
    rstCounter => rstCounter,  -- Updated to match the correct order and direction
    enCounter => enCounter,
    counterOut => counterOut,  -- Updated to match the correct order and direction
    counterOut2 => counterOut2
);

blokFSM : fsm port map(
	clk => clk,
    rst => rst,
    enMain => enMain,  -- Updated to match the correct order and direction
    rstCounter => rstCounter,
    counterOut => counterOut,
    enCounter => enCounter
);

process(xTemp0, yTemp0, angleTemp0, a0, b0, tanInv, x0, y0, angle0, angkaTemp, counterOut, counterOut2, enMain, Sudut,
x1, y1, angle1, xTemp1, yTemp1, angleTemp1, a1, b1,
x2, y2, angle2, xTemp2, yTemp2, angleTemp2, a2, b2,
x3, y3, angle3, xTemp3, yTemp3, angleTemp3, a3, b3,
x4, y4, angle4, xTemp4, yTemp4, angleTemp4, a4, b4,
x5, y5, angle5, xTemp5, yTemp5, angleTemp5, a5, b5,
x6, y6, angle6, xTemp6, yTemp6, angleTemp6, a6, b6,
x7, y7, angle7, xTemp7, yTemp7, angleTemp7, a7, b7,
x8, y8, angle8, xTemp8, yTemp8, angleTemp8, a8, b8,
x9, y9, angle9, xTemp9, yTemp9, angleTemp9, a9, b9,
x10, y10, angle10, xTemp10, yTemp10, angleTemp10, a10, b10,
x11, y11, angle11, xTemp11, yTemp11, angleTemp11, a11, b11,
x12, y12, angle12, xTemp12, yTemp12, angleTemp12, a12, b12,
x13, y13, angle13, xTemp13, yTemp13, angleTemp13, a13, b13,
xF, yF, angleF, tanInv0)

begin

--if Sudut > 

if enMain = '1' then

-- iterasi 0
if counterOut = "0000" then
counterOut2 <= "0000";
 x0 <= "01000000000000000000000000000000";
 y0 <= "00000000000000000000000000000000";
angle0 <= "00000000000000000000000000000000";

a0 <= y0;
b0 <= x0;
tanInv <= "00101101000000000000000000000000";

if (angle0 < Sudut) then
	xTemp0 <= ((x0(31)& x0) - (a0(31) & a0));
	yTemp0 <= ((y0(31)& y0) + (b0(31) & b0));
	angleTemp0 <= ((angle0(31)& angle0) + (tanInv(31)& tanInv));
	
elsif (angle0 >= Sudut) then
	xTemp0 <= ((x0(31)& x0) + (a0(31) & a0));
	yTemp0 <= ((y0(31)& y0) - (b0(31) & b0));
	angleTemp0 <= ((angle0(31)& angle0) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x1(31) <= xTemp0(32);
x1(30) <= xTemp0(30);
x1(29 downto 0) <= xTemp0(29 downto 0);  -- x dan y : 1 1 30
xI1 <= x1;
		
y1(31) <= yTemp0(32);
y1(30) <= yTemp0(30);
y1(29 downto 0) <= yTemp0(29 downto 0); 	-- angle : 1 7 24
		
angle1(31) <= angleTemp0(32);
angle1(30 downto 24) <= angleTemp0(30 downto 24);  -- bit ke 24 diskip (integer part)
angle1(23 downto 0) <= angleTemp0(23 downto 0);

-- iterasi 1
elsif counterOut = "0001" then
iterasi1Cek <= '1';
counterOut2 <= "0001";

----------------------------------------------------- PAKSA

x0 <= "01000000000000000000000000000000";
y0 <= "00000000000000000000000000000000";
angle0 <= "00000000000000000000000000000000";

a0 <= y0;
b0 <= x0;
tanInv0 <= "00101101000000000000000000000000";

if (angle0 < Sudut) then
	xTemp0 <= ((x0(31)& x0) - (a0(31) & a0));
	yTemp0 <= ((y0(31)& y0) + (b0(31) & b0));
	angleTemp0 <= ((angle0(31)& angle0) + (tanInv0(31)& tanInv0));
	
elsif (angle0 >= Sudut) then
	xTemp0 <= ((x0(31)& x0) + (a0(31) & a0));
	yTemp0 <= ((y0(31)& y0) - (b0(31) & b0));
	angleTemp0 <= ((angle0(31)& angle0) - (tanInv0(31)& tanInv0));		
end if;

	-- Penyetaraan bit

x1(31) <= xTemp0(32);
x1(30) <= xTemp0(30);
x1(29 downto 0) <= xTemp0(29 downto 0);  -- x dan y : 1 1 30
xI1 <= x1;
		
y1(31) <= yTemp0(32);
y1(30) <= yTemp0(30);
y1(29 downto 0) <= yTemp0(29 downto 0); 	-- angle : 1 7 24
		
angle1(31) <= angleTemp0(32);
angle1(30 downto 24) <= angleTemp0(30 downto 24);  -- bit ke 24 diskip (integer part)
angle1(23 downto 0) <= angleTemp0(23 downto 0);

------------------------------------------------------ PAKSA

a1(31) <= y1(31);
b1(31) <= x1(31);
a1(30) <= '0';
a1(29 downto 0) <= y1(30 downto 1);
b1(30) <= '0';
b1(29 downto 0) <= x1(30 downto 1);
tanInv <= "00011010100100001010001111010111";

if (angle1 < Sudut) then
	xTemp1 <= ((x1(31)& x1) - (a1(31) & a1));
	yTemp1 <= ((y1(31)& y1) + (b1(31) & b1));
	angleTemp1 <= ((angle1(31)& angle1) + (tanInv(31)& tanInv));
	
elsif (angle1 >= Sudut) then
	xTemp1 <= ((x1(31)& x1) + (a1(31) & a1));
	yTemp1 <= ((y1(31)& y1) - (b1(31) & b1));
	angleTemp1 <= ((angle1(31)& angle1) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x2(31) <= xTemp1(32);
x2(30) <= xTemp1(30);
x2(29 downto 0) <= xTemp1(29 downto 0);  -- x dan y : 1 1 30
xI1 <= x2;
		
y2(31) <= yTemp1(32);
y2(30) <= yTemp1(30);
y2(29 downto 0) <= yTemp1(29 downto 0); 	-- angle : 1 7 24
		
angle2(31) <= angleTemp1(32);
angle2(30 downto 24) <= angleTemp1(30 downto 24);  -- bit ke 24 diskip (integer part)
angle2(23 downto 0) <= angleTemp1(23 downto 0);
	

-- iterasi 2
elsif counterOut = "0010" then
counterOut2 <= "0010";
a2(31) <= y2(31);
b2(31) <= x2(31);
a2(30 downto 29) <= "00";
b2(30 downto 29) <= "00";
a2(28 downto 0) <= y2(30 downto 2);
b2(28 downto 0) <= x2(30 downto 2);
tanInv <= "00001110000010010011011101001011";

if (angle2 < Sudut) then
	xTemp2 <= ((x2(31)& x2) - (a2(31) & a2));
	yTemp2 <= ((y2(31)& y2) + (b2(31) & b2));
	angleTemp2 <= ((angle2(31)& angle2) + (tanInv(31)& tanInv));
	
elsif (angle2 >= Sudut) then
	xTemp2 <= ((x2(31)& x2) + (a2(31) & a2));
	yTemp2 <= ((y2(31)& y2) - (b2(31) & b2));
	angleTemp2 <= ((angle2(31)& angle2) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x3(31) <= xTemp2(32);
x3(30) <= xTemp2(30);
x3(29 downto 0) <= xTemp2(29 downto 0);  -- x dan y : 1 1 30
		
y3(31) <= yTemp2(32);
y3(30) <= yTemp2(30);
y3(29 downto 0) <= yTemp2(29 downto 0); 	-- angle : 1 7 24
		
angle3(31) <= angleTemp2(32);
angle3(30 downto 24) <= angleTemp2(30 downto 24);  -- bit ke 24 diskip (integer part)
angle3(23 downto 0) <= angleTemp2(23 downto 0);


-- iterasi 3
elsif counterOut = "0011" then
counterOut2 <= "0011";
a3(31) <= y3(31);
b3(31) <= x3(31);
a3(30 downto 28) <= "000";
b3(30 downto 28) <= "000";
a3(27 downto 0) <= y3(30 downto 3);
b3(27 downto 0) <= x3(30 downto 3);
tanInv <= "00000111001000000000000000000000"; -- ini udh y

if (angle3 < Sudut) then
	xTemp3 <= ((x3(31)& x3) - (a3(31) & a3));
	yTemp3 <= ((y3(31)& y3) + (b3(31) & b3));
	angleTemp3 <= ((angle3(31)& angle3) + (tanInv(31)& tanInv));
	
elsif (angle3 >= Sudut) then
	xTemp3 <= ((x3(31)& x3) + (a3(31) & a3));
	yTemp3 <= ((y3(31)& y3) - (b3(31) & b3));
	angleTemp3 <= ((angle3(31)& angle3) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x4(31) <= xTemp3(32);
x4(30) <= xTemp3(30);
x4(29 downto 0) <= xTemp3(29 downto 0);  -- x dan y : 1 1 30
		
y4(31) <= yTemp3(32);
y4(30) <= yTemp3(30);
y4(29 downto 0) <= yTemp3(29 downto 0); 	-- angle : 1 7 24
		
angle4(31) <= angleTemp3(32);
angle4(30 downto 24) <= angleTemp3(30 downto 24);  -- bit ke 24 diskip (integer part)
angle4(23 downto 0) <= angleTemp3(23 downto 0);



-- iterasi 4
elsif counterOut = "0100" then
counterOut2 <= "0100";
			a4(31) <= y4(31);
			b4(31) <= x4(31);
			a4(30 downto 27) <= "0000";
			b4(30 downto 27) <= "0000";
			a4(26 downto 0) <= y4(30 downto 4);
			b4(26 downto 0) <= x4(30 downto 4);
tanInv <= "00000011100100110111010010111100";

if (angle4 < Sudut) then
	xTemp4 <= ((x4(31)& x4) - (a4(31) & a4));
	yTemp4 <= ((y4(31)& y4) + (b4(31) & b4));
	angleTemp4 <= ((angle4(31)& angle4) + (tanInv(31)& tanInv));
	
elsif (angle4 >= Sudut) then
	xTemp4 <= ((x4(31)& x4) + (a4(31) & a4));
	yTemp4 <= ((y4(31)& y4) - (b4(31) & b4));
	angleTemp4 <= ((angle4(31)& angle4) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x5(31) <= xTemp4(32);
x5(30) <= xTemp4(30);
x5(29 downto 0) <= xTemp4(29 downto 0);  -- x dan y : 1 1 30
		
y5(31) <= yTemp4(32);
y5(30) <= yTemp4(30);
y5(29 downto 0) <= yTemp4(29 downto 0); 	-- angle : 1 7 24
		
angle5(31) <= angleTemp4(32);
angle5(30 downto 24) <= angleTemp4(30 downto 24);  -- bit ke 24 diskip (integer part)
angle5(23 downto 0) <= angleTemp4(23 downto 0);

-- iterasi 5
elsif counterOut = "0101" then
counterOut2 <= "0101";
			a5(31) <= y5(31);
			b5(31) <= x5(31);
			a5(30 downto 26) <= "00000";
			b5(30 downto 26) <= "00000";
			a5(25 downto 0) <= y5(30 downto 5);
			b5(25 downto 0) <= x5(30 downto 5);
tanInv <= "00000001110010100011110101110000";

if (angle5 < Sudut) then
	xTemp5 <= ((x5(31)& x5) - (a5(31) & a5));
	yTemp5 <= ((y5(31)& y5) + (b5(31) & b5));
	angleTemp5 <= ((angle5(31)& angle5) + (tanInv(31)& tanInv));
	
elsif (angle5 >= Sudut) then
	xTemp5 <= ((x5(31)& x5) + (a5(31) & a5));
	yTemp5 <= ((y5(31)& y5) - (b5(31) & b5));
	angleTemp5 <= ((angle5(31)& angle5) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x6(31) <= xTemp5(32);
x6(30) <= xTemp5(30);
x6(29 downto 0) <= xTemp5(29 downto 0);  -- x dan y : 1 1 30
		
y6(31) <= yTemp5(32);
y6(30) <= yTemp5(30);
y6(29 downto 0) <= yTemp5(29 downto 0); 	-- angle : 1 7 24
		
angle6(31) <= angleTemp5(32);
angle6(30 downto 24) <= angleTemp5(30 downto 24);  -- bit ke 24 diskip (integer part)
angle6(23 downto 0) <= angleTemp5(23 downto 0);

-- iterasi 6
elsif counterOut = "0110" then
counterOut2 <= "0110";
			a6(31) <= y6(31);
			b6(31) <= x6(31);
			a6(30 downto 25) <= "000000";
			b6(30 downto 25) <= "000000";
			a6(24 downto 0) <= y6(30 downto 6);
			b6(24 downto 0) <= x6(30 downto 6);
tanInv <= "00000000111001010001111010111000";

if (angle6 < Sudut) then
	xTemp6 <= ((x6(31)& x6) - (a6(31) & a6));
	yTemp6 <= ((y6(31)& y6) + (b6(31) & b6));
	angleTemp6 <= ((angle6(31)& angle6) + (tanInv(31)& tanInv));
	
elsif (angle6 >= Sudut) then
	xTemp6 <= ((x6(31)& x6) + (a6(31) & a6));
	yTemp6 <= ((y6(31)& y6) - (b6(31) & b6));
	angleTemp6 <= ((angle6(31)& angle6) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x7(31) <= xTemp6(32);
x7(30) <= xTemp6(30);
x7(29 downto 0) <= xTemp6(29 downto 0);  -- x dan y : 1 1 30
		
y7(31) <= yTemp6(32);
y7(30) <= yTemp6(30);
y7(29 downto 0) <= yTemp6(29 downto 0); 	-- angle : 1 7 24
		
angle7(31) <= angleTemp6(32);
angle7(30 downto 24) <= angleTemp6(30 downto 24);  -- bit ke 24 diskip (integer part)
angle7(23 downto 0) <= angleTemp6(23 downto 0);


-- iterasi 7
elsif counterOut = "0111" then
counterOut2 <= "0111";
			a7(31) <= y7(31);
			b7(31) <= x7(31);
			a7(30 downto 24) <= "0000000";
			b7(30 downto 24) <= "0000000";
			a7(23 downto 0) <= y7(30 downto 7);
			b7(23 downto 0) <= x7(30 downto 7);
tanInv <= "00000000011100101011000000100000";

if (angle7 < Sudut) then
	xTemp7 <= ((x7(31)& x7) - (a7(31) & a7));
	yTemp7 <= ((y7(31)& y7) + (b7(31) & b7));
	angleTemp7 <= ((angle7(31)& angle7) + (tanInv(31)& tanInv));
	
elsif (angle7 >= Sudut) then
	xTemp7 <= ((x7(31)& x7) + (a7(31) & a7));
	yTemp7 <= ((y7(31)& y7) - (b7(31) & b7));
	angleTemp7 <= ((angle7(31)& angle7) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x8(31) <= xTemp7(32);
x8(30) <= xTemp7(30);
x8(29 downto 0) <= xTemp7(29 downto 0);  -- x dan y : 1 1 30
		
y8(31) <= yTemp7(32);
y8(30) <= yTemp7(30);
y8(29 downto 0) <= yTemp7(29 downto 0); 	-- angle : 1 7 24
		
angle8(31) <= angleTemp7(32);
angle8(30 downto 24) <= angleTemp7(30 downto 24);  -- bit ke 24 diskip (integer part)
angle8(23 downto 0) <= angleTemp7(23 downto 0);


-- iterasi 8
elsif counterOut = "1000" then
counterOut2 <= "1000";
			a8(31) <= y8(31);
			b8(31) <= x8(31);
			a8(30 downto 23) <= "00000000";
			b8(30 downto 23) <= "00000000";
			a8(22 downto 0) <= y8(30 downto 8);
			b8(22 downto 0) <= x8(30 downto 8);
tanInv <= "00000000001110010101100000010000";

if (angle8 < Sudut) then
	xTemp8 <= ((x8(31)& x8) - (a8(31) & a8));
	yTemp8 <= ((y8(31)& y8) + (b8(31) & b8));
	angleTemp8 <= ((angle8(31)& angle8) + (tanInv(31)& tanInv));
	
elsif (angle8 >= Sudut) then
	xTemp8 <= ((x8(31)& x8) + (a8(31) & a8));
	yTemp8 <= ((y8(31)& y8) - (b8(31) & b8));
	angleTemp8 <= ((angle8(31)& angle8) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x9(31) <= xTemp8(32);
x9(30) <= xTemp8(30);
x9(29 downto 0) <= xTemp8(29 downto 0);  -- x dan y : 1 1 30
		
y9(31) <= yTemp8(32);
y9(30) <= yTemp8(30);
y9(29 downto 0) <= yTemp8(29 downto 0); 	-- angle : 1 7 24
		
angle9(31) <= angleTemp8(32);
angle9(30 downto 24) <= angleTemp8(30 downto 24);  -- bit ke 24 diskip (integer part)
angle9(23 downto 0) <= angleTemp8(23 downto 0);


-- iterasi 9
elsif counterOut = "1001" then
counterOut2 <= "1001";
			a9(31) <= y9(31);
			b9(31) <= x9(31);
			a9(30 downto 22) <= "000000000";
			b9(30 downto 22) <= "000000000";
			a9(21 downto 0) <= y9(30 downto 9);
			b9(21 downto 0) <= x9(30 downto 9);
tanInv <= "00000000000111001010110000001000";

if (angle9 < Sudut) then
	xTemp9 <= ((x9(31)& x9) - (a9(31) & a9));
	yTemp9 <= ((y9(31)& y9) + (b9(31) & b9));
	angleTemp9 <= ((angle9(31)& angle9) + (tanInv(31)& tanInv));
	
elsif (angle9 >= Sudut) then
	xTemp9 <= ((x9(31)& x9) + (a9(31) & a9));
	yTemp9 <= ((y9(31)& y9) - (b9(31) & b9));
	angleTemp9 <= ((angle9(31)& angle9) - (tanInv(31)& tanInv));	
end if;

	-- Penyetaraan bit

x10(31) <= xTemp9(32);
x10(30) <= xTemp9(30);
x10(29 downto 0) <= xTemp9(29 downto 0);  -- x dan y : 1 1 30
		
y10(31) <= yTemp9(32);
y10(30) <= yTemp9(30);
y10(29 downto 0) <= yTemp9(29 downto 0); 	-- angle : 1 7 24
		
angle10(31) <= angleTemp9(32);
angle10(30 downto 24) <= angleTemp9(30 downto 24);  -- bit ke 24 diskip (integer part)
angle10(23 downto 0) <= angleTemp9(23 downto 0);


-- iterasi 10
elsif counterOut = "1010" then
counterOut2 <= "1010";
			a10(31) <= y10(31);
			b10(31) <= x10(31);
			a10(30 downto 21) <= "0000000000";
			b10(30 downto 21) <= "0000000000";
			a10(20 downto 0) <= y10(30 downto 10);
			b10(20 downto 0) <= x10(30 downto 10);
tanInv <= "00000000000011100101011000000100";

if (angle10 < Sudut) then
	xTemp10 <= ((x10(31)& x10) - (a10(31) & a10));
	yTemp10 <= ((y10(31)& y10) + (b10(31) & b10));
	angleTemp10 <= ((angle10(31)& angle10) + (tanInv(31)& tanInv));
	
elsif (angle10 >= Sudut) then
	xTemp10 <= ((x10(31)& x10) + (a10(31) & a10));
	yTemp10 <= ((y10(31)& y10) - (b10(31) & b10));
	angleTemp10 <= ((angle10(31)& angle10) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x11(31) <= xTemp10(32);
x11(30) <= xTemp10(30);
x11(29 downto 0) <= xTemp10(29 downto 0);  -- x dan y : 1 1 30
		
y11(31) <= yTemp10(32);
y11(30) <= yTemp10(30);
y11(29 downto 0) <= yTemp10(29 downto 0); 	-- angle : 1 7 24
		
angle11(31) <= angleTemp10(32);
angle11(30 downto 24) <= angleTemp10(30 downto 24);  -- bit ke 24 diskip (integer part)
angle11(23 downto 0) <= angleTemp10(23 downto 0);



-- iterasi 11
elsif counterOut = "1011" then
counterOut2 <= "1011";
			a11(31) <= y11(31);
			b11(31) <= x11(31);
			a11(30 downto 20) <= "00000000000";
			b11(30 downto 20) <= "00000000000";
			a11(19 downto 0) <= y11(30 downto 11);
			b11(19 downto 0) <= x11(30 downto 11);
tanInv <= "00000000000001110010101100000010";

if (angle11 < Sudut) then
	xTemp11 <= ((x11(31)& x11) - (a11(31) & a11));
	yTemp11 <= ((y11(31)& y11) + (b11(31) & b11));
	angleTemp11 <= ((angle11(31)& angle11) + (tanInv(31)& tanInv));
	
elsif (angle11 >= Sudut) then
	xTemp11 <= ((x11(31)& x11) + (a11(31) & a11));
	yTemp11 <= ((y11(31)& y11) - (b11(31) & b11));
	angleTemp11 <= ((angle11(31)& angle11) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x12(31) <= xTemp11(32);
x12(30) <= xTemp11(30);
x12(29 downto 0) <= xTemp11(29 downto 0);  -- x dan y : 1 1 30
		
y12(31) <= yTemp11(32);
y12(30) <= yTemp11(30);
y12(29 downto 0) <= yTemp11(29 downto 0); 	-- angle : 1 7 24
		
angle12(31) <= angleTemp11(32);
angle12(30 downto 24) <= angleTemp11(30 downto 24);  -- bit ke 24 diskip (integer part)
angle12(23 downto 0) <= angleTemp11(23 downto 0);


-- iterasi 12
elsif counterOut = "1100" then
counterOut2 <= "1100";
			a12(31) <= y12(31);
			b12(31) <= x12(31);
			a12(30 downto 19) <= "000000000000";
			b12(30 downto 19) <= "000000000000";
			a12(18 downto 0) <= y12(30 downto 12);
			b12(18 downto 0) <= x12(30 downto 12);
tanInv <= "00000000000000111001010110000001";

if (angle12 < Sudut) then
	xTemp12 <= ((x12(31)& x12) - (a12(31) & a12));
	yTemp12 <= ((y12(31)& y12) + (b12(31) & b12));
	angleTemp12 <= ((angle12(31)& angle12) + (tanInv(31)& tanInv));
	
elsif (angle12 >= Sudut) then
	xTemp12 <= ((x12(31)& x12) + (a12(31) & a12));
	yTemp12 <= ((y12(31)& y12) - (b12(31) & b12));
	angleTemp12 <= ((angle12(31)& angle12) - (tanInv(31)& tanInv));		
end if;

	-- Penyetaraan bit

x13(31) <= xTemp12(32);
x13(30) <= xTemp12(30);
x13(29 downto 0) <= xTemp12(29 downto 0);  -- x dan y : 1 1 30
		
y13(31) <= yTemp12(32);
y13(30) <= yTemp12(30);
y13(29 downto 0) <= yTemp12(29 downto 0); 	-- angle : 1 7 24
		
angle13(31) <= angleTemp12(32);
angle13(30 downto 24) <= angleTemp12(30 downto 24);  -- bit ke 24 diskip (integer part)
angle13(23 downto 0) <= angleTemp12(23 downto 0);


-- iterasi 13
elsif counterOut = "1101" then
counterOut2 <= "1101";
			a13(31) <= y13(31);
			b13(31) <= x13(31);
			a13(30 downto 18) <= "0000000000000";
			b13(30 downto 18) <= "0000000000000";
			a13(17 downto 0) <= y13(30 downto 13);
			b13(17 downto 0) <= x13(30 downto 13);
tanInv <= "00000000000000011100101011000000";

if (angle13 < Sudut) then
	xTemp13 <= ((x13(31)& x13) - (a13(31) & a13));
	yTemp13 <= ((y13(31)& y13) + (b13(31) & b13));
	angleTemp13 <= ((angle13(31)& angle13) + (tanInv(31)& tanInv));
	
elsif (angle13 >= Sudut) then
	xTemp13 <= ((x13(31)& x13) + (a13(31) & a13));
	yTemp13 <= ((y13(31)& y13) - (b13(31) & b13));
	angleTemp13 <= ((angle13(31)& angle13) - (tanInv(31)& tanInv));	
end if;

	-- Penyetaraan bit

xF(31) <= xTemp13(32);
xF(30) <= xTemp13(30);
xF(29 downto 0) <= xTemp13(29 downto 0);  -- x dan y : 1 1 30
		
yF(31) <= yTemp13(32);
yF(30) <= yTemp13(30);
yF(29 downto 0) <= yTemp13(29 downto 0); 	-- angle : 1 7 24
		
angleF(31) <= angleTemp13(32);
angleF(30 downto 24) <= angleTemp13(30 downto 24);  -- bit ke 24 diskip (integer part)
angleF(23 downto 0) <= angleTemp13(23 downto 0);

else
counterOut2 <= "0000";


end if;

end if;
end process;


process(clk)
begin
if (clk'EVENT and clk = '1') then
if modeSin = '1' then
	angkaTemp <= yF * k;
	angka(31) <= angkaTemp(63);		-- karena output sin cos cuman -1 sampe 1, maka 1.1.30
	angka(30) <= angkaTemp(60);
	angka(29 downto 0) <= angkaTemp(59 downto 30);	
elsif modeCos = '1' then
	angkaTemp <= xF * k;
	angka(31) <= angkaTemp(63);
	angka(30) <= angkaTemp(60);
	angka(29 downto 0) <= angkaTemp(59 downto 30);
	
end if;
end if;
end process;

end tubes1_arc;