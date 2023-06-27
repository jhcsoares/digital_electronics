library ieee;
use ieee.std_logic_1164.all;

entity piso_test is
	port(
		ls, clk: in std_logic;
		d: in std_logic_vector(7 downto 0);
		s: out std_logic);
end piso_test;

architecture gate_level of piso_test is
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal d_s, q_s: std_logic_vector(7 downto 0);
	signal clk_s: std_logic;
	
begin
	dff0: d_ff port map(d=>d_s(0), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(0));
	dff1: d_ff port map(d=>d_s(1), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(1));
	dff2: d_ff port map(d=>d_s(2), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(2));
	dff3: d_ff port map(d=>d_s(3), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(3));
	dff4: d_ff port map(d=>d_s(4), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(4));
	dff5: d_ff port map(d=>d_s(5), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(5));
	dff6: d_ff port map(d=>d_s(6), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(6));
	dff7: d_ff port map(d=>d_s(7), clk=>clk_s, preset=>'1', clear=>'1', q=>q_s(7));
	
	clk_s<=clk;
	
	d_s(0)<=(d(0) and ls) or ('0' and not(ls));
	d_s(1)<=(d(1) and ls) or (q_s(0) and not(ls));
	d_s(2)<=(d(2) and ls) or (q_s(1) and not(ls));
	d_s(3)<=(d(3) and ls) or (q_s(2) and not(ls));
	d_s(4)<=(d(4) and ls) or (q_s(3) and not(ls));
	d_s(5)<=(d(5) and ls) or (q_s(4) and not(ls));
	d_s(6)<=(d(6) and ls) or (q_s(5) and not(ls));
	d_s(7)<=(d(7) and ls) or (q_s(6) and not(ls));
	s<=q_s(7);
	
end gate_level;
