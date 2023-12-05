library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity coba1 is
	port(	inputUser : in std_logic_vector(31 downto 0); -- 1 9 22
			hasilAkar : out std_logic_vector(31 downto 0); -- 1 1 30
			tesPersamaan : out integer --BERHASIL NGITUNG SMxK
		);
end entity;

architecture coba1_arc of coba1 is
constant nol : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";  -- 1 10 22

constant batas002 : std_logic_vector(31 downto 0) := "00000000000000010100011110101110"; -- 1 9 22 (Kecuali yg dikasih tanda komen)
constant batas017 : std_logic_vector(31 downto 0) := "00000000000010101110000101000111";
constant batas037 : std_logic_vector(31 downto 0) := "00000000000101111010111000010100";
constant batas05  : std_logic_vector(31 downto 0) := "00000000001000000000000000000000";
constant batas1	  : std_logic_vector(31 downto 0) := "00000000010000000000000000000000";
constant kons9	: std_logic_vector(31 downto 0) := "00000010010000000000000000000000";
constant kons25	: std_logic_vector(31 downto 0) := "00000110010000000000000000000000";
constant kons2	: std_logic_vector(63 downto 0) := "0000000000000000001000000000000000000000000000000000000000000000";  -- 1 19 44
constant kons16	: std_logic_vector(31 downto 0) := "00000100000000000000000000000000";
constant kons4	: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000001000000000000000000000000";
constant kons10	: std_logic_vector(31 downto 0) := "00000010100000000000000000000000";
constant kons5	: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000001010000000000000000000000";
constant kons29 : std_logic_vector(31 downto 0) := "00000111010000000000000000000000";
constant kons20 : std_logic_vector(31 downto 0) := "00000101000000000000000000000000";
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
signal hT3 : std_logic_vector (64 downto 0) ;
signal hK4 : std_logic_vector(63 downto 0);
signal hT4 : std_logic_vector(64 downto 0);

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
hK2 <= kons25* inputAkar;  -- 1 19 44
hK3 <= kons16* inputAkar; 
hK4 <= kons10* inputAkar; 
--hT2 <= (hK2(63)& hk2) + (kons2(63)& kons2); -- 1 20 44

	--outFTemp <= kons9 * inputAkar;	-- 1 19 44


process(inputAkar, b002, b017, b037, b05, b1, hK2, hT2, outFTemp1)
begin

outFTemp1 <= kons9 * inputAkar;	-- 1 19 44

--hK2 <= kons25* inputAkar;  -- 1 19 44
hT2 <= (hK2(63)& hK2) + (kons2(63)& kons2); -- 1 20 44
hT3 <= (hK3(63) & hK3) + (kons4(63) & kons4) ; 
hT4 <= (hK4(63) & hK4) + (kons5(63) & kons5);

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
	hasilAkar(30) <= hT2(48);
	hasilAkar(29 downto 0) <= hT2(47 downto 18);

elsif b017 > nol and b037 <= nol then
	-- PERSAMAAN 3
	tesPersamaan <= 3;
	--ht2 <= 
	
	hasilAkar(31)<= '0' ; 
	hasilAkar(30)<= hT3(48) ;
	hasilAkar(29 downto 0) <= hT3(47 downto 18);

elsif b037 > nol and b05 <= nol then
	-- PERSAMAAN 4
	tesPersamaan <= 4;
	--ht3 <=
	
	hasilAkar(31)<= '0' ;
	hasilAkar(30)<= hT4(48);
	hasilAkar(29 downto 0) <= hT4(47 downto 18);
	
	
elsif b05 > nol and b1 <= nol then
	-- PERSAMAAN 5
	tesPersamaan <= 5;
	

end if;

end process;

end architecture;