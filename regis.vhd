library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity regis is								-- hannya untuk x saja
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)      
	);
end regis;

architecture regis_arc of regis is
begin
	process(reset_Reg, clk, Enable_Reg, inputRegister)
	begin
		if (reset_Reg = '1') then
			outputRegister <= "00000000000000000000000000000000";
		elsif (Enable_Reg = '1' and reset_Reg = '0') then
				outputRegister <= inputRegister;
		end if;
	end process;


end regis_arc;