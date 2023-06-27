library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
	port(
		d, clk, preset, clear: in std_logic;
		q: out std_logic);
end d_ff;

architecture behavioral of d_ff is	
begin
	process(d, clk, preset, clear)
	begin
		if not(preset)='0' and not(clear)='0' then
			if clk'event and clk='1' then
				q<=d;
			end if;
		elsif not(preset)='0' and not(clear)='1' then
			q<='0';
		elsif not(preset)='1' and not(clear)='0' then
			q<='1';
		end if;
	end process;
end behavioral;
		