library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use work.all;

entity tubesTopLevel is
	port(	clk, rst: in std_logic;
			modeSin, modeCos, modeTan: in std_logic;
			inputSudut: in std_logic_vector(31 downto 0);  -- 1 9 22
			angka: out std_logic_vector(31 downto 0)
	);
end tubesTopLevel;

architecture tTL_arc of tubesTopLevel is

component kuadran is
	port(	rst : in std_logic;
			inputSudut : in std_logic_vector(31 downto 0); -- 1 9 22
			kuadranOut : out integer;
			Sudut : out std_logic_vector(31 downto 0)  -- 1 7 24
		);
end component;

component fsm is
	port(	rst, clk: in std_logic;
			inputCount: out std_logic;		-- buat enable count biar naik
			resetCounter : out std_logic;
			counter : in std_logic_vector(3 downto 0);
			comparison: in std_logic; -- 0: angle<inputSudut. 1: angle>=inputSudut.
			en_Subtractor: out std_logic;
			en_Register: out std_logic;
			reset_Register: out std_logic;
			modeSin, modeCos, modeTan : in std_logic;
			enFSM : in std_logic;
			outFinal: out std_logic
	);

end component;

component comparator is
	port(	rst, clk: in std_logic;
			Sudut : in std_logic_vector(31 downto 0);
			angle : in std_logic_vector(31 downto 0);
			comparison : out std_logic					-- 0: angle < inputSudut. 1: angle >= inputSudut
	);
end component;

component subtractor is
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
			En_Subtractor : in std_logic
	);
end component;

component regis is
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)  
	);
end component;

component regisX is
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)      
	);
end component;

component regisY is
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)     
	);
end component;

component regisAngle is
	port(	clk : in std_logic;
			Enable_Reg : in std_logic;
			inputRegister : in std_logic_vector(31 downto 0);
			reset_Reg : in std_logic;
			outputRegister : out std_logic_vector(31 downto 0)  
	);
end component;

component counter is
	port(	rst, clk: in std_logic;
			input	: in std_logic;
			counter : buffer std_logic_vector(3 downto 0)
	);
end component;

signal comparison : std_logic;
signal outFinal : std_logic;
signal En_Subtractor : std_logic;
signal En_Reg : std_logic;
signal reset_Register : std_logic;
signal angle : std_logic_vector(31 downto 0);
signal x : std_logic_vector(31 downto 0);
signal y : std_logic_vector(31 downto 0);
signal x_out : std_logic_vector(31 downto 0);
signal y_out : std_logic_vector(31 downto 0);
signal angle_out : std_logic_vector(31 downto 0);
signal outSin : std_logic_vector(31 downto 0);
signal outCos : std_logic_vector(31 downto 0);
signal angkaTemp : std_logic_vector(63 downto 0);  -- 1.3.60
constant k : std_logic_vector(31 downto 0) := "00100110110111010010111100011010";  -- 1.1.30
signal inputCount : std_logic;
signal resetCounter : std_logic;
signal counter2 : std_logic_vector(3 downto 0) := "0000";
signal tesShifter : std_logic;
signal tesComparison : std_logic;
signal enFSM : std_logic := '1';
signal cekWilbert : std_logic;
signal Sudut : std_logic_vector(31 downto 0); -- Sudut adalah 1 7 24, inputSudut adalah 1 9 22 (yang diinput user)
signal kuadranOut : integer;
signal angkaTemp2: std_logic_vector(63 downto 0);
signal counterInternal : std_logic_vector(4 downto 0) := "00000";

begin
	blokKuadran : kuadran port map(rst, inputSudut, kuadranOut, Sudut);
	-- FSM
	TOFSM : fsm port map(rst, clk, inputCount, resetCounter, counter2, comparison, En_Subtractor, En_Reg, reset_Register, modeSin, modeCos, modeTan, enFSM, outFinal);
	-- Datapath
	blokKomparator : comparator port map(rst, clk, Sudut, angle, comparison);  -- Sudut di sini adalah 1 7 24
	blokCounter : counter port map(rst, clk, inputCount, counter2);
	blokSubtractor : subtractor port map(x, y, comparison, angle, counter2, x_out, y_out, angle_out, clk, tesShifter, tesComparison, enFSM, En_Subtractor);
	blokRegisX : regisX port map(clk, En_Reg, x_out, reset_Register, x);
	blokRegisY : regisY port map(clk, En_Reg, y_out, reset_Register, y);
	blokRegisAngle : regisAngle port map(clk, En_Reg, angle_out, reset_Register, angle);
	blokOutSin : regis port map(clk, outFinal, x, reset_Register, outSin);
	blokOutCos : regis port map(clk, outFinal, y, reset_Register, outCos);
	
	process(counterInternal, clk, outFinal)
	begin
	
	if outFinal = '1' then
		if clk'EVENT and clk = '1' then
			counterInternal <= counterInternal + "01";
		end if;
	end if;
	
	end process;
	
	
	process(modeSin, modeCos, angkaTemp, outSin, outCos, cekWilbert, kuadranOut, clk)
	begin
	--if (falling_edge(clk)) then
	if counterInternal = "11" then
	if(modeSin = '1') then
		angkaTemp <= outCos * k;
		angkaTemp2 <= not(angkaTemp) + "0000000000000000000000000000000000000000000000000000000000000001";
		if kuadranOut = 1 or kuadranOut = 2 then 			
			angka(31) <= angkaTemp(63);		
			angka(30) <= angkaTemp(60);
			angka(29 downto 0) <= angkaTemp(59 downto 30);
		elsif kuadranOut = 3 or kuadranOut = 4 then
			--angkaTemp2 <= not(angkaTemp) + "0000000000000000000000000000000000000000000000000000000000000001";
			--if angkaTemp2(63) = '1' then
				cekWilbert <= '1';
				angka(31) <= angkaTemp2(63);		
				angka(30) <= angkaTemp2(60);
				angka(29 downto 0) <= angkaTemp2(59 downto 30);
			--end if;
		end if;
		
		
	elsif(modeCos = '1') then
		angkaTemp <= outSin * k;
		angkaTemp2 <= not(angkaTemp) + "0000000000000000000000000000000000000000000000000000000000000001";
		if kuadranOut = 1 or kuadranOut = 4 then 			
			angka(31) <= angkaTemp(63);		
			angka(30) <= angkaTemp(60);
			angka(29 downto 0) <= angkaTemp(59 downto 30);
		elsif kuadranOut = 2 or kuadranOut = 3 then
			--angkaTemp2 <= not(angkaTemp) + "0000000000000000000000000000000000000000000000000000000000000001";
			--if angkaTemp2(63) = '1' then
				cekWilbert <= '1';
				angka(31) <= angkaTemp2(63);		
				angka(30) <= angkaTemp2(60);
				angka(29 downto 0) <= angkaTemp2(59 downto 30);
			--end if;
		end if;
		
		
	else
		cekWilbert <= '0';
	end if;
	end if;
	end process;

end tTL_arc;