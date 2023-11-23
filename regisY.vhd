library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity regisY is								-- hannya untuk y saja
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)      -- GK YAKIN SAMA BUFFER
	);
end regisY;

architecture regisY_arc of regisY is
begin
	process(reset_Reg, clk, Enable_Reg, inputRegister)
	begin
		if (reset_Reg = '1') then
			outputRegister <= "00000000000000000000000000000000";
		--elsif ( Enable_Reg = '0' and reset_Reg = '0') then
		--	if (clk'EVENT and clk = '1') then
		--		outputRegister <= outputRegister;
		--	end if;
		elsif (Enable_Reg = '1' and reset_Reg = '0') then
			if (clk'EVENT and clk = '1') then
				outputRegister <= inputRegister;
			end if;
		end if;
	end process;


end regisY_arc;