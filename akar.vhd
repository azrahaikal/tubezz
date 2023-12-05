library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity akar is
	port(	inputUser : in std_logic_vector(31 downto 0); -- 1 9 22
			hasilAkar : out std_logic_vector(31 downto 0); -- 1 1 30
			tesPersamaan : out integer --BERHASIL NGITUNG SMxK
		);
end entity;

architecture akar_arc of akar is
constant nol : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";  -- 1 10 22

constant batas002 : std_logic_vector(31 downto 0) := "00000000000000010100011110101110"; -- 1 9 22 (Kecuali yg dikasih tanda komen)
constant batas017 : std_logic_vector(31 downto 0) := "00000000000010101110000101000111";
constant batas037 : std_logic_vector(31 downto 0) := "00000000000101111010111000010100";
constant batas05  : std_logic_vector(31 downto 0) := "00000000001000000000000000000000";
constant batas1	  : std_logic_vector(31 downto 0) := "00000000010000000000000000000000";
constant kons9	: std_logic_vector(31 downto 0) := "00000010010000000000000000000000";
constant kons25p15	: std_logic_vector(31 downto 0) := "00000000011010101010101010101010";  -- 1 9 22 AAA 0 000000000 1101010101010101010101
constant kons2p15	: std_logic_vector(63 downto 0) := "0000000000000000001000100010001000100010001000100010001000100000";  -- 1 19 44
constant kons16p17	: std_logic_vector(31 downto 0) := "00000000001111000011110000111100";  -- 1 9 22
constant kons4p17	: std_logic_vector(63 downto 0) := "0000000000000000000000111100001111000011110000111100001111000010"; -- 1 19 44
constant kons10p14	: std_logic_vector(31 downto 0) := "00000000001011011011011011011010"; -- 1 9 22
constant kons5p14	: std_logic_vector(63 downto 0) := "0000000000000000000001011011011011011011011011011011011011001100"; -- 1 19 44
constant kons29p49 : std_logic_vector(31 downto 0) := "00000000001001011110000010100111"; -- 1 9 22
constant kons20p49 : std_logic_vector(63 downto 0) := "0000000000000000000001101000011111010110001101000011111001000101"; -- 1 19 44 BENER
constant kons0	: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

signal b002 : std_logic_vector(32 downto 0);
signal b017 : std_logic_vector(32 downto 0);
signal b037 : std_logic_vector(32 downto 0);
signal b05	: std_logic_vector(32 downto 0);
signal b1	: std_logic_vector(32 downto 0);


signal yK	: std_logic_vector(63 downto 0);
signal tambahTemp : std_logic_vector(64 downto 0);


signal hxK : std_logic_vector(63 downto 0);		   -- 1 19 44
signal hSMxKTemp : std_logic_vector(64 downto 0);  -- 1 20 44
signal satu64bit : std_logic_vector(63 downto 0):= "0000000000000000000100000000000000000000000000000000000000000000";  -- 1 19 44
signal inputAkar : std_logic_vector(31 downto 0);  -- 1 9 22. Soalnya bakal dioperasikan dengan bilangan lain
signal inputUser2 : std_logic_vector(31 downto 0);

signal outFTemp1 : std_logic_vector(63 downto 0);   -- 1 19 44
signal hK2 : std_logic_vector(63 downto 0);
signal hT2 : std_logic_vector(64 downto 0);
signal hK3 : std_logic_vector (63 downto 0);
signal hT3 : std_logic_vector (64 downto 0);
signal hK4 : std_logic_vector(63 downto 0);
signal hT4 : std_logic_vector(64 downto 0);
signal hK5 : std_logic_vector(63 downto 0);
signal hT5 : std_logic_vector(64 downto 0);

begin
-- 1-X^2 = hSMxK = inputAkar (32 bit)
inputUser2 <= inputUser;
hxK <= inputUser * inputUser2;						-- X ADALAH INPUT USER
hSMxKTemp <= ((satu64bit(63)& satu64bit) - (hxK(63)& hxK));
inputAkar(31) <= hSMxKTemp(64);
inputAkar(30 downto 22) <= hSMxKTemp(52 downto 44); -- SELALU POSITIF
inputAkar(21 downto 0) <= hSmxKTemp(43 downto 22);

b002 <= ((inputAkar(31)& inputAkar) - (batas002(31)& batas002)); -- 1 10 22
b017 <= ((inputAkar(31)& inputAkar) - (batas017(31)& batas017)); -- 1 10 22
b037 <= ((inputAkar(31)& inputAkar) - (batas037(31)& batas037)); -- 1 10 22
b05 <= ((inputAkar(31)& inputAkar) - (batas05(31)& batas05));	 -- 1 10 22
b1 <= ((inputAkar(31)& inputAkar) - (batas1(31)& batas1));		 -- 1 10 22
hK2 <= kons25p15* inputAkar;  -- 1 19 44
hK3 <= kons16p17* inputAkar; 
hK4 <= kons10p14* inputAkar;
hK5 <= kons29p49* inputAkar;

process(inputAkar, b002, b017, b037, b05, b1, hK2, hT2, outFTemp1)
begin

outFTemp1 <= kons9 * inputAkar;	-- 1 19 44

--hK2 <= kons25* inputAkar;  -- 1 19 44
hT2 <= (hK2(63)& hK2) + (kons2p15(63)& kons2p15); -- 1 20 44
hT3 <= (hK3(63) & hK3) + (kons4p17(63) & kons4p17) ; 
hT4 <= (hK4(63) & hK4) + (kons5p14(63) & kons5p14);
hT5 <= (hK5(63) & hK5) + (kons20p49(63) & kons20p49);

if inputAkar >= nol and b002 <= nol then

	-- PERSAMAAN 1
	tesPersamaan <= 1;
	
	hasilAkar(31) <= outFTemp1(63);
	hasilAkar(30) <= outFTemp1(44);
	hasilAkar(29 downto 0) <= outFTemp1(43 downto 14);

elsif b002 > nol and b017 <= nol then
	-- PERSAMAAN 2
	tesPersamaan <= 2;
	--hT2 <= (hK2(63)& hk2) + (kons2(63)& kons2); -- 1 20 44
	
	hasilAkar(31) <= '0';
	hasilAkar(30) <= hT2(44);
	hasilAkar(29 downto 0) <= hT2(43 downto 14);

elsif b017 > nol and b037 <= nol then
	-- PERSAMAAN 3
	tesPersamaan <= 3;
	
	hasilAkar(31) <= '0';
	hasilAkar(30) <= hT3(44);
	hasilAkar(29 downto 0) <= hT3(43 downto 14);

elsif b037 > nol and b05 <= nol then
	-- PERSAMAAN 4
	tesPersamaan <= 4;
	--ht3 <=
	
	hasilAkar(31) <= '0';
	hasilAkar(30) <= hT4(44);
	hasilAkar(29 downto 0) <= hT4(43 downto 14);
	
	--hasilAkar(31)<= '0' ;
	--hasilAkar(30)<= hT4(48);
	--hasilAkar(29 downto 0) <= hT4(47 downto 18);
	
	
elsif b05 > nol and b1 <= nol then
	-- PERSAMAAN 5
	tesPersamaan <= 5;
	
	hasilAkar(31) <= '0';
	hasilAkar(30) <= hT5(44);
	hasilAkar(29 downto 0) <= hT5(43 downto 14);

end if;

end process;

end architecture;