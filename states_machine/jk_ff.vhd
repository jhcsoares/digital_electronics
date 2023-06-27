library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is
	port(
		j: in std_logic;
		k: in std_logic;
		clk: in std_logic;
		q: out std_logic);
end jk_ff;

architecture behavioral of jk_ff is
	signal qx: std_logic;
	begin
		process(clk)
			begin 
				if clk'event and clk='1' then
					if j='0' and k='0' then
						qx <= qx;
					elsif j='0' and k='1' then
						qx<='0';
					elsif j='1' and k='0' then
						qx<='1';
					elsif j='1' and k='1' then
						qx<=not(qx);
					end if;
				end if;
		end process;
	q<=qx;
end behavioral;
		
