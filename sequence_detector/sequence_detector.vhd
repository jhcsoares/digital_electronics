library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector is
	port(
		i, clk: in std_logic;
		q: out std_logic_vector(3 downto 0));
end sequence_detector;

architecture gate_level of sequence_detector is
	
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal d_s: std_logic_vector(2 downto 0);
	signal q_s: std_logic_vector(2 downto 0);
	
begin
	d_ff0: d_ff port map(d=>d_s(0), clk=>clk, preset=>'1', clear=>'1', q=>q_s(0));
	d_ff1: d_ff port map(d=>d_s(1), clk=>clk, preset=>'1', clear=>'1', q=>q_s(1));
	d_ff2: d_ff port map(d=>d_s(2), clk=>clk, preset=>'1', clear=>'1', q=>q_s(2));
	
	process(clk)
	begin
		d_s(0)<=(not(i) and not(q_s(2)) and q_s(1)) or (not(i) and not(q_s(0)));
		
		d_s(1)<=(q_s(2) and not(q_s(1)) and q_s(0)) or (not(i) and q_s(0)) or (not(i) and q_s(1));
		
		d_s(2)<=(not(i) and q_s(2) and not(q_s(0))) or
			(i and q_s(2) and not(q_s(1)) and q_s(0)) or
			(i and not(q_s(2)) and q_s(1) and q_s(0));
		
		q(0)<=q_s(0);
		q(1)<=q_s(1);
		q(2)<=q_s(2);
		q(3)<='0';
	end process;
end gate_level;
