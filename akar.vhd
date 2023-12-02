library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity akar is
	port(	inputUser : in std_logic_vector(31 downto 0); -- 1 9 22
			hasilAkar : out std_logic_vector(31 downto 0)	
		);
end entity;

-- BELUM NGITUNG 1-X^2 = hSMxK

architecture akar_arc of akar is
constant satu : std_logic_vector(31 downto 0) : = "0 000000000 0000000000000000000000";


constant batas002 : std_logic_vector(31 downto 0) := "0 000000000 0000010100011110101110";
constant batas017 : std_logic_vector(31 downto 0) := "0 000000000 0010101110000101000111";
constant batas037 : std_logic_vector(31 downto 0) := "0 000000000 0101111010111000010100";
constant batas05  : std_logic_vector(31 downto 0) := "0 000000000 1000000000000000000000";
constant batas1	  : std_logic_vector(31 downto 0) := "0 000000001 0000000000000000000000";
constant kons9	: std_logic_vector(31 downto 0) := "0 000001001 0000000000000000000000";
constant kons25	: std_logic_vector(31 downto 0) := "0 000011001 0000000000000000000000";
constant kons2	: std_logic_vector(31 downto 0) := "0 000000010 0000000000000000000000";
constant kons16	: std_logic_vector(31 downto 0) := "0 000010000 0000000000000000000000";
constant kons4	: std_logic_vector(31 downto 0) := "0 000000100 0000000000000000000000";
constant kons10	: std_logic_vector(31 downto 0) := "0 000001010 0000000000000000000000";
constant kons5	: std_logic_vector(31 downto 0) := "0 000000101 0000000000000000000000";
constant kons29 : std_logic_vector(31 downto 0) := "0 000011101 0000000000000000000000";
constant kons20 : std_logic_vector(31 downto 0) := "0 000010100 0000000000000000000000";
constant kons0	: std_logic_vector(31 downto 0) := "0 000000000 0000000000000000000000";

signal b002 : std_logic_vector(32 downto 0) := ((inputUser(31)& inputUser) - (batas002(31)& batas002));
signal b017 : std_logic_vector(32 downto 0) := ((inputUser(31)& inputUser) - (batas017(31)& batas017));
signal b037 : std_logic_vector(32 downto 0) := ((inputUser(31)& inputUser) - (batas037(31)& batas037));
signal b05	: std_logic_vector(32 downto 0) := ((inputUser(31)& inputUser) - (batas05(31)& batas05));


signal yK	: std_logic_vector(63 downto 0);
signal tambahTemp : std_logic_vector(64 downto 0);


begin
hxK <= ;
hSMxKTemp <= ((satu(31)& satu) - (hxK(31)& hxK));

process(inputUser, yK, tambahTemp)
begin

if 

end if;


end process;

end architecture;