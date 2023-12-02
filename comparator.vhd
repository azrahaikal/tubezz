library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity comparator is
	port(	rst, clk: in std_logic;
			Sudut : in std_logic_vector(31 downto 0);
			angle : in std_logic_vector(31 downto 0);
			comparison : out std_logic					-- 0: angle < Sudut. 1: angle >= Sudut
	);
end comparator;

architecture comparator_arc of comparator is
begin
	process(angle, Sudut)
	begin
		if (angle < Sudut) then
			comparison <= '0';
		elsif (angle >= Sudut) then
			comparison <= '1';
		end if;
	end process;
end comparator_arc;