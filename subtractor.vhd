library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity subtractor is
	port(	x, y : in std_logic_vector(31 downto 0);
			comparison : in std_logic;
			angle : in std_logic_vector(31 downto 0);
			counter : in std_logic_vector(3 downto 0); --std_logic_vector(3 downto 0);
			x_out, y_out : out std_logic_vector(31 downto 0);
			angle_out : out std_logic_vector(31 downto 0);
			clk : in std_logic;
			tesShifter : out std_logic;
			tesComparison : out std_logic;
			enFSM : out std_logic;
			En_Subtractor : in std_logic;
			hasilAkar : in std_logic_vector(31 downto 0);
			Sudut : in std_logic_vector(31 downto 0); --ini buat arc
			modeSin, modeCos, modeTan, modeArcSin, modeArcCos : in std_logic
	);
end subtractor;

architecture subtractor_arc of subtractor is
	
	signal a: std_logic_vector(31 downto 0);  -- (2**-i)*y*d = a
	signal b: std_logic_vector(31 downto 0);  -- (2**-i)*x*d = b
	
	signal x_outTemp, y_outTemp: std_logic_vector(32 downto 0);
	signal angle_outTemp: std_logic_vector(32 downto 0);
	--signal kCount : integer := to_integer(unsigned(counter));
	signal tanInv: std_logic_vector(31 downto 0) ; --:= tan_inv(counter);
	signal x0, y0, angle0: std_logic_vector(31 downto 0);
	signal sekali : std_logic := '1';
	
	
	begin
	process(clk)
	begin
	--if clk = '1' then
	if (En_Subtractor = '1') then
	--kCount <= to_integer(unsigned(counter));
	tesShifter <= '1';

		if to_integer(unsigned(counter)) = 1 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30) <= '0';
			a(29 downto 0) <= y(30 downto 1);
			b(30) <= '0';
			b(29 downto 0) <= x(30 downto 1);
		elsif to_integer(unsigned(counter)) = 0 and sekali = '1' then
			if modeSin = '1' or modeCos = '1' or modeTan = '1' then
				a <= "00000000000000000000000000000000";		-- d*y*(2^-i)
				b <= "01000000000000000000000000000000";		-- d*x*(2^-i)
				x0 <= "01000000000000000000000000000000";
				y0 <= "00000000000000000000000000000000";
				angle0 <= "00000000000000000000000000000000";
				sekali <= '0';
			elsif modeArcSin = '1' then
				a <= Sudut;										-- d*y*(2^-i)
				b <= hasilAkar;									-- d*x*(2^-i)
				x0 <= hasilAkar;
				y0 <= Sudut;
				angle0 <= "00000000000000000000000000000000";
				sekali <= '0';				
			elsif modeArcCos = '1' then
				a <= hasilAkar;
				b <= Sudut;
				x0 <= Sudut;
				y0 <= hasilAkar;
				angle0 <= "00000000000000000000000000000000";
				sekali <= '0';
			end if;
		elsif to_integer(unsigned(counter)) = 2 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 29) <= "00";
			b(30 downto 29) <= "00";
			a(28 downto 0) <= y(30 downto 2);
			b(28 downto 0) <= x(30 downto 2);
		elsif to_integer(unsigned(counter)) = 3 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 28) <= "000";
			b(30 downto 28) <= "000";
			a(27 downto 0) <= y(30 downto 3);
			b(27 downto 0) <= x(30 downto 3);
		elsif to_integer(unsigned(counter)) = 4 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 27) <= "0000";
			b(30 downto 27) <= "0000";
			a(26 downto 0) <= y(30 downto 4);
			b(26 downto 0) <= x(30 downto 4);
		elsif to_integer(unsigned(counter)) = 5 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 26) <= "00000";
			b(30 downto 26) <= "00000";
			a(25 downto 0) <= y(30 downto 5);
			b(25 downto 0) <= x(30 downto 5);
		elsif to_integer(unsigned(counter)) = 6 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 25) <= "000000";
			b(30 downto 25) <= "000000";
			a(24 downto 0) <= y(30 downto 6);
			b(24 downto 0) <= x(30 downto 6);
		elsif to_integer(unsigned(counter)) = 7 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 24) <= "0000000";
			b(30 downto 24) <= "0000000";
			a(23 downto 0) <= y(30 downto 7);
			b(23 downto 0) <= x(30 downto 7);
		elsif to_integer(unsigned(counter)) = 8 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 23) <= "00000000";
			b(30 downto 23) <= "00000000";
			a(22 downto 0) <= y(30 downto 8);
			b(22 downto 0) <= x(30 downto 8);
		elsif to_integer(unsigned(counter)) = 9 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 22) <= "000000000";
			b(30 downto 22) <= "000000000";
			a(21 downto 0) <= y(30 downto 9);
			b(21 downto 0) <= x(30 downto 9);
		elsif to_integer(unsigned(counter)) = 10 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 21) <= "0000000000";
			b(30 downto 21) <= "0000000000";
			a(20 downto 0) <= y(30 downto 10);
			b(20 downto 0) <= x(30 downto 10);
		elsif to_integer(unsigned(counter)) = 11 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 20) <= "00000000000";
			b(30 downto 20) <= "00000000000";
			a(19 downto 0) <= y(30 downto 11);
			b(19 downto 0) <= x(30 downto 11);
		elsif to_integer(unsigned(counter)) = 12 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 19) <= "000000000000";
			b(30 downto 19) <= "000000000000";
			a(18 downto 0) <= y(30 downto 12);
			b(18 downto 0) <= x(30 downto 12);
		elsif to_integer(unsigned(counter)) = 13 then
			a(31) <= y(31);
			b(31) <= x(31);
			a(30 downto 18) <= "0000000000000";
			b(30 downto 18) <= "0000000000000";
			a(17 downto 0) <= y(30 downto 13);
			b(17 downto 0) <= x(30 downto 13);			
				
		end if;
	else
			tesShifter <= '0';
	end if;
	--end if;
	end process;
		
		process(En_Subtractor)
		begin
		--if clk = '1' then
		if (En_Subtractor = '1') then
		
		if (to_integer(unsigned(counter)) = 0) then
			tanInv <= "00101101000000000000000000000000";
		elsif (to_integer(unsigned(counter)) = 1) then
			tanInv <= "00011010100100001010001111010111";
		elsif (to_integer(unsigned(counter)) = 2) then
			tanInv <= "00001110000010010011011101001011";
		elsif (to_integer(unsigned(counter)) = 3) then
			tanInv <= "00000111001000000000000000000000";
		elsif (to_integer(unsigned(counter)) = 4) then
			tanInv <= "00000011100100110111010010111100";
		elsif (to_integer(unsigned(counter)) = 5) then
			tanInv <= "00000001110010100011110101110000";
		elsif (to_integer(unsigned(counter)) = 6) then
			tanInv <= "00000000111001010001111010111000";
		elsif (to_integer(unsigned(counter)) = 7) then
			tanInv <= "00000000011100101011000000100000";
		elsif (to_integer(unsigned(counter)) = 8) then
			tanInv <= "00000000001110010101100000010000";
		elsif (to_integer(unsigned(counter)) = 9) then
			tanInv <= "00000000000111001010110000001000";
		elsif (to_integer(unsigned(counter)) = 10) then
			tanInv <= "00000000000011100101011000000100";
		elsif (to_integer(unsigned(counter)) = 11) then
			tanInv <= "00000000000001110010101100000010";
		elsif (to_integer(unsigned(counter)) = 12) then
			tanInv <= "00000000000000111001010110000001";
		elsif (to_integer(unsigned(counter)) = 13) then
			tanInv <= "00000000000000011100101011000000";
		else
			tanInv <= "00000000000000000000000000000000";
		end if;		
		end if;
		--end if;
		end process;
		
		process(a, b, x, y, comparison, x_outTemp, y_outTemp, angle_outTemp, En_Subtractor)
		begin
		--if clk = '1' then
		if En_Subtractor = '1' then
		
		
		-- a dan b sudah dibuat. Berati tinggal x = x +- a, y = y +- b, dan angle = angle +- tan_inv
			if comparison = '0' then	-- angel < Sudut
					tesComparison <= '1';
					
					if modeSin = '1' or modeCos = '1' or modeTan = '1' then
						if to_integer(unsigned(counter)) = 0 then
							x_outTemp <= ((x0(31)& x0) - (a(31)& a));
							y_outTemp <= ((y0(31)& y0) + (b(31)& b));
							angle_outTemp <= ((angle0(31)& angle0) + (tanInv(31)& tanInv));
							
						else
							x_outTemp <= ((x(31)& x) - (a(31)& a));
							y_outTemp <= ((y(31)& y) + (b(31)& b));
							angle_outTemp <= ((angle(31)& angle) + (tanInv(31)& tanInv));
						end if;
						
					elsif modeArcSin = '1' or modeArcCos = '1' then
						if to_integer(unsigned(counter)) = 0 then
							x_outTemp <= ((x0(31)& x0) - (a(31)& a));
							y_outTemp <= ((y0(31)& y0) + (b(31)& b));
							angle_outTemp <= ((angle0(31)& angle0) - (tanInv(31)& tanInv));
							
						else
							x_outTemp <= ((x(31)& x) - (a(31)& a));
							y_outTemp <= ((y(31)& y) + (b(31)& b));
							angle_outTemp <= ((angle(31)& angle) - (tanInv(31)& tanInv));
						end if;
					end if;
			elsif comparison = '1' then -- angle >= Sudut				
					tesComparison <= '1';
					
					if modeSin = '1' or modeCos = '1' or modeTan = '1' then
						if to_integer(unsigned(counter)) = 0 then
							x_outTemp <= ((x0(31)& x0) + (a(31)& a));
							y_outTemp <= ((y0(31)& y0) - (b(31)& b));
							angle_outTemp <= ((angle0(31)& angle0) - (tanInv(31)& tanInv));
							
						else
							x_outTemp <= ((x(31)& x) + (a(31)& a));
							y_outTemp <= ((y(31)& y) - (b(31)& b));
							angle_outTemp <= ((angle(31)& angle) - (tanInv(31)& tanInv));
						end if;
						
					elsif modeArcSin = '1' or modeArcCos = '1' then
						if to_integer(unsigned(counter)) = 0 then
							x_outTemp <= ((x0(31)& x0) + (a(31)& a));
							y_outTemp <= ((y0(31)& y0) - (b(31)& b));
							angle_outTemp <= ((angle0(31)& angle0) + (tanInv(31)& tanInv));
							
						else
							x_outTemp <= ((x(31)& x) + (a(31)& a));
							y_outTemp <= ((y(31)& y) - (b(31)& b));
							angle_outTemp <= ((angle(31)& angle) + (tanInv(31)& tanInv));
						end if;
					end if;
			end if;
		
			
		-- PENYETARAAN BIT
		x_out(31) <= x_outTemp(32);
		x_out(30) <= x_outTemp(30);
		x_out(29 downto 0) <= x_outTemp(29 downto 0);  -- x dan y : 1 1 30
		
		y_out(31) <= y_outTemp(32);
		y_out(30) <= y_outTemp(30);
		y_out(29 downto 0) <= y_outTemp(29 downto 0); 	-- angle : 1 7 24
		
		angle_out(31) <= angle_outTemp(32);
		angle_out(30 downto 24) <= angle_outTemp(30 downto 24);
		angle_out(23 downto 0) <= angle_outTemp(23 downto 0);
		
		enFSM <= '1';		
	else
		tesComparison <= '0';
	 
	end if;
	--end if;
	end process;
	

end subtractor_arc;