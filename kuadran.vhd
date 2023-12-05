library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity kuadran is 
	port(	rst : in std_logic;
			inputSudut : in std_logic_vector(31 downto 0); -- 1 9 22
			kuadranOut : out integer;
			modeSin, modeCos, modeTan, modeArcSin, modeArcCos : in std_logic;
			Sudut : out std_logic_vector(31 downto 0)  -- 1 7 24 sin cos tan, 1 1 30 untuk ARC
		);
end entity;

architecture kuadran_arc of kuadran is

signal degree0p : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";

signal degree90p : std_logic_vector(31 downto 0) := "00010110100000000000000000000000";
signal degree180p : std_logic_vector(31 downto 0) := "00101101000000000000000000000000";
signal degree270p : std_logic_vector(31 downto 0) := "01000011100000000000000000000000";
signal degree360p : std_logic_vector(31 downto 0) := "01011010000000000000000000000000";
signal degree90p2 : std_logic_vector(32 downto 0) := "000010110100000000000000000000000";
signal degree180p2 : std_logic_vector(32 downto 0) := "000101101000000000000000000000000";
signal degree270p2 : std_logic_vector(32 downto 0) := "001000011100000000000000000000000";

signal degree90n : std_logic_vector(31 downto 0) := "11101001100000000000000000000000";
signal degree180n : std_logic_vector(31 downto 0) := "11010011000000000000000000000000";
signal degree270n : std_logic_vector(31 downto 0) := "10111100100000000000000000000000";

signal inputSudut2 : std_logic_vector(32 downto 0);
signal yAtas : std_logic_vector(32 downto 0);
signal xKiri : std_logic_vector(32 downto 0);
signal yBawah : std_logic_vector(32 downto 0);
signal sudutNegatif : std_logic_vector(32 downto 0);  -- HANYA gunakan ini jika sudut inputnya negatif

signal notInputSudut : std_logic_vector(31 downto 0);
signal SudutTemp : std_logic_vector(32 downto 0);
signal SudutTemp2 : std_logic_vector(33 downto 0);  -- yang kedua dipake kalo inputnya negatif

begin
inputSudut2(32) <= inputSudut(31);
inputSudut2(31 downto 1) <= inputSudut(30 downto 0);
inputSudut2(0) <= '0';
yAtas <= ((inputSudut(31)& inputSudut) - (degree90p(31)& degree90p)); -- ngecek apakah lebih dari 90
xKiri <= ((inputSudut(31)& inputSudut) - (degree180p(31)& degree180p)); -- dibandingin sama 180
yBawah <= ((inputSudut(31)& inputSudut) - (degree270p(31)& degree270p)); -- dibandingin ama 270
sudutNegatif <= ((inputSudut(31)& inputSudut) + (degree360p(31)& degree360p));
notInputSudut <= not(inputSudut) + "00000000000000000000000000000001";

process(inputSudut, yAtas, SudutTemp, degree0p, degree90p, degree180p, degree270p, degree360p, degree90p2, degree180p2, degree270p2,
degree90n, degree180n, degree270n, inputSudut2, xKiri, yBawah, sudutNegatif, notInputSudut, SudutTemp2)
begin
if (modeSin = '1' or modeCos = '1' or modeTan = '1') then
	if (inputSudut(31) = '0') then
		if yAtas <= degree0p and inputSudut2 >= degree0p then
			kuadranOut <= 1;
			Sudut(31) <= inputSudut(31);
			Sudut(30 downto 24) <= inputSudut(28 downto 22);
			Sudut(23 downto 2) <= inputSudut(21 downto 0);
			Sudut(1 downto 0) <= "00";
		elsif yAtas > degree0p and xKiri <= degree0p then
			kuadranOut <= 2;
			
			SudutTemp <= ((degree180p(31)& degree180p) - (inputSudut(31)& inputSudut)); -- 180 - inputSudut
			
			Sudut(31) <= SudutTemp(31);
			Sudut(30 downto 24) <= SudutTemp(28 downto 22);
			Sudut(23 downto 2) <= SudutTemp(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		elsif xKiri > degree0p and yBawah <= degree0p then
			kuadranOut <= 3;
			
			SudutTemp <= ((inputSudut(31)& inputSudut) - (degree180p(31)& degree180p)); -- inputSudut - 180
			
			Sudut(31) <= SudutTemp(31);
			Sudut(30 downto 24) <= SudutTemp(28 downto 22);
			Sudut(23 downto 2) <= SudutTemp(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		elsif yBawah > degree0p then
			kuadranOut <= 4;
			
			SudutTemp <= ((degree360p(31)& degree360p) - (inputSudut(31)& inputSudut)); -- 360 - inputSudut
			
			Sudut(31) <= SudutTemp(31);
			Sudut(30 downto 24) <= SudutTemp(28 downto 22);	
			Sudut(23 downto 2) <= SudutTemp(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		end if;
		
	elsif (inputSudut(31) = '1') then
		if sudutNegatif <= degree90p2 and sudutNegatif >= degree0p then
			kuadranOut <= 1;
			
			SudutTemp <= ((degree360p(31)& degree360p) + (inputSudut(31)& inputSudut)); -- -360 + inputSudut
			
			Sudut(31) <= SudutTemp(31);
			Sudut(30 downto 24) <= SudutTemp(28 downto 22);
			Sudut(23 downto 2) <= SudutTemp(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		elsif sudutNegatif > degree90p2 and sudutNegatif <= degree180p2 then
			kuadranOut <= 2;
			
			SudutTemp(31 downto 0) <= not(inputSudut) + "00000000000000000000000000000001";
			SudutTemp(32) <= '0';
			SudutTemp2 <= ((SudutTemp(32)& SudutTemp) - (degree180p2(32)& degree180p2)); -- -inputSudut - 180
			
			
			Sudut(31) <= SudutTemp2(33);
			Sudut(30 downto 24) <= SudutTemp2(28 downto 22);	
			Sudut(23 downto 2) <= SudutTemp2(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		elsif sudutNegatif > degree180p2 and sudutNegatif <= degree270p2 then
			kuadranOut <= 3;
			
			SudutTemp(31 downto 0) <= not(inputSudut) + "00000000000000000000000000000001";
			SudutTemp(32) <= '0';
			SudutTemp2 <= ((degree180p2(32)& degree180p) - (SudutTemp(32)& SudutTemp));
			
			Sudut(31) <= SudutTemp2(33);
			Sudut(30 downto 24) <= SudutTemp2(28 downto 22);
			Sudut(23 downto 2) <= SudutTemp2(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		elsif sudutNegatif > degree270p2 then
			kuadranOut <= 4;
			
			SudutTemp(32) <= '0';
			SudutTemp(31 downto 0) <= not(inputSudut - "00000000000000000000000000000001");
			
			Sudut(31) <= '0';
			Sudut(30 downto 24) <= SudutTemp(28 downto 22);
			Sudut(23 downto 2) <= SudutTemp(21 downto 0);
			Sudut(1 downto 0) <= "00";
			
		end if;
	
	end if;
elsif modeArcSin = '1' or modeArcCos = '1' then
	Sudut(31) <= inputSudut(31);
	Sudut(30) <= inputSudut(22);
	Sudut(29 downto 8) <= inputSudut(21 downto 0);
	Sudut(8 downto 0) <= "000000000";

end if; 
end process;
end kuadran_arc;