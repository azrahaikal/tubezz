library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity subtractor is
	port(	x, y : in std_logic_vector(31 downto 0);
			comparison : in std_logic;
			angle : in std_logic_vector(31 downto 0);
			count : in integer; --std_logic_vector(3 downto 0);
			x_out, y_out : out std_logic_vector(31 downto 0);
			angle_out : out std_logic_vector(31 downto 0);
			En_Subtractor : in std_logic
	);
end subtractor;

architecture subtractor_arc of subtractor is

	function tan_inv(count: integer := 0) return std_logic_vector is	
	begin
		if (count = 0) then
			return "00101101000000000000000000000000"; -- 1.7.24
		elsif (count = 1) then
			return "00011010100100001010001111010111"; 
		elsif (count = 2) then
			return "00001110010111000010100011110101";
		elsif (count = 3) then
			return "00000111001000000000000000000000";
		elsif (count = 4) then
			return "00000011100100110111010010111100";
		elsif (count = 5) then
			return "00000001110010100011110101110000";
		elsif (count = 6) then
			return "00000000111001010001111010111000";
		elsif (count = 7) then
			return "00000000011100101011000000100000";
		elsif (count = 8) then
			return "00000000001110010101100000010000";
		elsif (count = 9) then
			return "00000000000111001010110000001000";
		elsif (count = 10) then
			return "00000000000011100101011000000100";
		elsif (count = 11) then
			return "00000000000001110010101100000010";
		elsif (count = 12) then
			return "00000000000000111001010110000001";
		elsif (count = 13) then
			return "00000000000000011100101011000000";
		else
			return "00000001000000000000000000000000";
		end if;
	end function;
	
	signal a: std_logic_vector(31 downto 0);  -- (2**-i)*y*d = a
	signal b: std_logic_vector(31 downto 0);  -- (2**-i)*x*d = b
	
	signal x_outTemp, y_outTemp: std_logic_vector(32 downto 0);
	signal angle_outTemp: std_logic_vector(32 downto 0);
	signal tanInv: std_logic_vector(31 downto 0) := tan_inv(count => count);
	constant kCount : integer := count;
	
	begin
	process(a, b, x, y, count, comparison, x_outTemp, y_outTemp, angle_outTemp)

	begin
	
	if En_Subtractor = '1' then

		if count = 1 then
			a(30) <= '0';
			a(29 downto 0) <= y(30 downto 1);
			b(30) <= '0';
			b(29 downto 0) <= x(30 downto 1);
		elsif count = 0 then
			a <= y;
			b <= x;
		else
			for i in 30 downto (31 - kCount) loop
				a(i) <= '0';
				b(i) <= '0';
			end loop;
			--a(30 downto ((31 - kCount))) <= (others => '0');
			a((30 - kCount) downto 0) <= y(30 downto kCount);
			--b(30 downto (31 - kCount)) <= (others => '0');
			b((30 - kCount) downto 0) <= x(30 downto kCount);		
		end if;
		-- a dan b sudah dibuat. Berati tinggal x = x +- a, y = y +- b, dan angle = angle +- tan_inv
		
			if comparison = '0' then	-- angel < Sudut
				x_outTemp <= ((x(31)& x) - (a(31)& a));
				y_outTemp <= ((y(31)& y) + (b(31)& b));
				angle_outTemp <= ((angle(31)& angle) + (tanInv(31)& tanInv));
				
			elsif comparison = '1' then	-- angle >= Sudut
				x_outTemp <= ((x(31)& x) + (a(31)& a));
				y_outTemp <= ((y(31)& y) - (b(31)& b));
				angle_outTemp <= ((angle(31)& angle) - (tanInv(31)& tanInv));
				
			end if;
			
		
			
		-- PENYETARAAN BIT
		x_out(31) <= x_outTemp(32);
		x_out(30) <= x_outTemp(31);
		x_out(29 downto 0) <= x_outTemp(30 downto 1);  -- x dan y : 1 1 30
		
		y_out(31) <= y_outTemp(32);
		y_out(30) <= y_outTemp(31);
		y_out(29 downto 0) <= y_outTemp(30 downto 1); 	-- angle : 1 7 24
		
		angle_out(31) <= angle_outTemp(32);
		angle_out(30 downto 24) <= angle_outTemp(31 downto 25);  -- bit ke 24 diskip (integer part)
		angle_out(23 downto 0) <= angle_outTemp(23 downto 0);
		
	end if;
	end process;
	

end subtractor_arc;