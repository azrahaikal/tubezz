library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity regisX is								-- hannya untuk x saja
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0);
			modeArcSin, modeArcCos : in std_logic;
			hasilAkar : in std_logic_vector(31 downto 0);
			inputUser : in std_logic_vector(31 downto 0)    -- 1 9 22
	);
end regisX;

architecture regisX_arc of regisX is
begin
	process(reset_Reg, clk, Enable_Reg, inputRegister)
	begin
		if (reset_Reg = '1') then
			if modeArcSin = '1' then
				outputRegister <= hasilAkar;
			elsif modeArcCos = '1' then
				outputRegister(31) <= inputUser(31);
				outputRegister(30) <= inputUser(22);
				outputRegister(29 downto 8) <= inputUser(21 downto 0);
				outputRegister(7 downto 0) <= "00000000";
			else
				outputRegister <= "01000000000000000000000000000000";
			end if;
			
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

end regisX_arc;