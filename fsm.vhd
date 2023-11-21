library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;

entity fsm is
	port(	rst, clk: in std_logic;
			count: out integer;
			comparison: in std_logic; -- 0: angle<Sudut. 1: angle>=Sudut.
			en_Subtractor: out std_logic;
			en_Register: out std_logic;
			reset_Register: out std_logic;
			outFinal: out std_logic
	);
end fsm;

architecture fsm_arc of fsm is
	type state is (s0, s1, s2, s3, s4, s5); -- s0: inisialisasi, s1: angle < inputSudut, s2: angle >= inputSudut, s3: save di register. s4 buat compare.
									   -- setelah di s1 atau s2, akan ada penyetaraan bit. s5 buat outFinal.
	--signal currentState, nextState : state;
	signal currentState : state := s0;
	signal nextState : state;
	
	signal modeSin, modeCos, modeTan : std_logic;
	--count <= 0;
	signal count_internal : integer := 0;
	
begin
	process(rst, clk, count_internal)
	begin
	if (rst = '1') then
		currentState <= s0;
		--count <= 0;
		count_internal <= 0;
	elsif (clk'EVENT and clk = '1') then
		currentState <= nextState;
		count <= count_internal;
	end if;
	end process;
	
	process(modeSin, modeCos, modeTan, comparison, currentState, count_internal)
	begin
	
	case currentState is
	
		when s0 =>
			if (modeSin = '0' and modeCos = '0' and modeTan = '0') then  -- pas disimulasiin, pencet reset dulu sekali
				reset_Register <= '1';		-- x diset ke 1, y ke 0, angle ke 0
				--count <= 0;
				count_internal <= 0;
				en_Subtractor <= '0';
				en_Register <= '0';
				outFinal <= '0';
				nextState <= s0;
			elsif (modeSin = '1' or modeCos = '1' or modeTan = '1') then
				reset_Register <= '1';
				--count <= 0;
				count_internal <= 0;
				en_Subtractor <= '0';
				en_Register <= '0';
				outFinal <= '0';
				nextState <= s1;
			end if;
			
		when s4 =>							-- buat compare
			reset_Register <= '0';			-- kalo reset gk aktif, register bakal nge-copy input
			--count <= count;
			count_internal <= count_internal;
			en_Subtractor <= '0';
			en_Register <= '0';
			outFinal <= '0';
			if (comparison = '0') then		-- angle < Sudut
				nextState <= s1;
			elsif (comparison = '1') then	-- angle >= Sudut
				nextState <= s2;
			end if;

		when s1 =>
			reset_Register <= '0';			-- x = x - ... . y = y + ... . angle = angle + ...
			en_Subtractor <= '1';
			--count <= count;
			count_internal <= count_internal;
			en_Register <= '0';
			outFinal <= '0';
			nextState <= s3;		-- save di register

		when s2 =>							-- x = x + ... . y = y - ... . angle = angle - ...
			reset_Register <= '0';
			en_Subtractor <= '1';
			--count <= count;
			count_internal <= count_internal;
			en_Register <= '0';
			outFinal <= '0';
			nextState <= s3;		-- save di register

		when s3 =>		-- save di register
			en_Subtractor <= '0';
			reset_Register <= '0';
			outFinal <= '0';
			en_Register <= '1';
			
			if (count_internal >= 13) then
				--count <= 0;
				count_internal <= count_internal;
				nextState <= s5; -- outFinal
			else
				--count <= count + 1;
				count_internal <= count_internal + 1;
				nextState <= s4;
			end if;
		
		when s5 =>			-- outFinal
			en_Subtractor <= '0';
			reset_Register <= '0';
			en_Register <= '0';
			--count <= 0;
			count_internal <= 0;
			outFinal <= '1';			-- register OUT_REG aktif			
			nextState <= s0;			-- if modeSin = '1' ... --> tulis di top level	
			
		when others =>
			nextState <= s0;
	
	end case;
	
	end process;

end fsm_arc;