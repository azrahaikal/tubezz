library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity comparator is
	port(	rst, clk: in std_logic;
			Sudut : in std_logic_vector(31 downto 0);
			angle : in std_logic_vector(31 downto 0);
			modeSin, modeCos, modeTan, modeArcSin, modeArcCos : in std_logic;
			comparison : out std_logic					-- 0: angle < Sudut. 1: angle >= Sudut
	);
end comparator;

architecture comparator_arc of comparator is
constant nol : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
constant satu : std_logic_vector(31 downto 0) := "01000000000000000000000000000000";
begin
	process(angle, Sudut, modeSin, modeCos, modeTan, modeArcSin, modeArcCos, modeTan)
	begin
		if modeSin = '1' or modeCos = '1' or modeTan = '1' then
			if (angle < Sudut) then
				comparison <= '0';
			elsif (angle >= Sudut) then
				comparison <= '1';
			end if;
		elsif modeArcSin = '1' then
			if (Sudut >= nol) then
				comparison <= '1';
			elsif (Sudut < nol) then
				comparison <= '0';
			end if ;
		elsif modeArcCos = '1' then
			if (Sudut >= satu) then
				comparison <= '0';
			elsif (Sudut < satu) then
				comparison <= '1';
			end if ;
		end if ;
	end process;
end comparator_arc;