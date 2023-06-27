library ieee;
use ieee.std_logic_1164.all;

entity counter_0_to_F is
	port(
		clk: in std_logic;
		q: out std_logic_vector(3 downto 0));
end counter_0_to_F;

architecture gate_level of counter_0_to_F is
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal d_s, q_s: std_logic_vector(3 downto 0);
	
begin
	d_ff0: d_ff port map(d=>d_s(0), clk=>clk, preset=>'1', clear=>'1', q=>q_s(0));
	d_ff1: d_ff port map(d=>d_s(1), clk=>clk, preset=>'1', clear=>'1', q=>q_s(1));
	d_ff2: d_ff port map(d=>d_s(2), clk=>clk, preset=>'1', clear=>'1', q=>q_s(2));
	d_ff3: d_ff port map(d=>d_s(3), clk=>clk, preset=>'1', clear=>'1', q=>q_s(3));
	
	d_s(3)<=(not(q_s(3)) and q_s(2) and q_s(1) and q_s(0)) or
		(q_s(3) and not(q_s(2))) or
		(q_s(3) and not(q_s(0))) or
		(q_s(3) and not(q_s(1)));
	
	d_s(2)<=(not(q_s(2)) and q_s(1) and q_s(0)) or
		(q_s(2) and not(q_s(1))) or
		(q_s(2) and not(q_s(0)));
	
	d_s(1)<=(not(q_s(1)) and q_s(0)) or
		(q_s(1) and not(q_s(0)));
	
	d_s(0)<=(not(q_s(0)));
	
	q(3)<=q_s(3);
	q(2)<=q_s(2);
	q(1)<=q_s(1);
	q(0)<=q_s(0);
	
end gate_level;
