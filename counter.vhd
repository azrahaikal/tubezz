library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter is
	port(	rst, clk: in std_logic;
			input	: in std_logic;
			counter : buffer std_logic_vector(3 downto 0)
	);
end entity;

architecture counter_arc of counter is
begin
	process(rst, clk, input, counter)
	begin
	if (rst = '1') then
		counter <= "0000";
	elsif (clk'EVENT and clk = '1') then
		if (input = '1') then 
	
			if (counter = "0000") then
				counter <= "0001";
			elsif (counter = "0001") then
				counter <= "0010";
			elsif (counter = "0010") then
				counter <= "0011";
			elsif (counter = "0011") then
				counter <= "0100";
			elsif (counter = "0100") then
				counter <= "0101";
			elsif (counter = "0101") then
				counter <= "0110";
			elsif (counter = "0110") then
				counter <= "0111";
			elsif (counter = "0111") then
				counter <= "1000";
			elsif (counter = "1000") then
				counter <= "1001";
			elsif (counter = "1001") then
				counter <= "1010";
			elsif (counter = "1010") then
				counter <= "1011";
			elsif (counter = "1011") then
				counter <= "1100";
			elsif (counter = "1100") then
				counter <= "1101";
			elsif (counter = "1101") then
				counter <= "0000";
				
			else
				counter <= "0000";
			
		end if;
		end if;
	end if;
	end process;
end counter_arc;