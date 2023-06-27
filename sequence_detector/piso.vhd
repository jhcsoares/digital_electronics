library ieee;
use ieee.std_logic_1164.all;

entity piso is
	port(
		d: in std_logic_vector(6 downto 0);
		clk, l_s: in std_logic;
		q: out std_logic);
end piso;

architecture gate_level of piso is

	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal q_s: std_logic_vector(6 downto 0);
	signal d_s: std_logic_vector(6 downto 1);
	
begin
	d_ff0:d_ff port map(d=>d(0), clk=>clk, preset=>'1', clear=>'1', q=>q_s(0));
	d_ff1:d_ff port map(d=>d_s(1), clk=>clk, preset=>'1', clear=>'1', q=>q_s(1));
	d_ff2:d_ff port map(d=>d_S(2), clk=>clk, preset=>'1', clear=>'1', q=>q_s(2));
	d_ff3:d_ff port map(d=>d_s(3), clk=>clk, preset=>'1', clear=>'1', q=>q_s(3));
	d_ff4:d_ff port map(d=>d_s(4), clk=>clk, preset=>'1', clear=>'1', q=>q_s(4));
	d_ff5:d_ff port map(d=>d_s(5), clk=>clk, preset=>'1', clear=>'1', q=>q_s(5));
	d_ff6:d_ff port map(d=>d_s(6), clk=>clk, preset=>'1', clear=>'1', q=>q_s(6));
	
	process(clk)
	begin
		d_s(1)<=(d(1) and l_s) or (q_s(0) and not(l_s));
		d_s(2)<=(d(2) and l_s) or (q_s(1) and not(l_s));
		d_s(3)<=(d(3) and l_s) or (q_s(2) and not(l_s));
		d_s(4)<=(d(4) and l_s) or (q_s(3) and not(l_s));
		d_s(5)<=(d(5) and l_s) or (q_s(4) and not(l_s));
		d_s(6)<=(d(6) and l_s) or (q_s(5) and not(l_s));
		q<=q_s(6);
	end process;
	
end gate_level;
