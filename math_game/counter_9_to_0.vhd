library ieee;
use ieee.std_logic_1164.all;

entity counter_9_to_0 is
	port(
		clk: in std_logic;
		s: out std_logic_vector(3 downto 0));
end counter_9_to_0;

architecture gate_level of counter_9_to_0 is
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal d_s: std_logic_vector(3 downto 0);
	signal q_s: std_logic_vector(3 downto 0);
	
	begin
		d_ff0: d_ff port map(
			d_s(0), 
			clk, 
			'1', 
			'1', 
			q_s(0));
		
		d_ff1: d_ff port map(
			d_s(1), 
			clk, 
			'1', 
			'1', 
			q_s(1));
		
		d_ff2: d_ff port map(
			d_s(2), 
			clk, 
			'1', 
			'1', 
			q_s(2));
		
		d_ff3: d_ff port map(
			d_s(3), 
			clk, 
			'1', 
			'1', 
			q_s(3));
		
		d_s(3)<=(not(q_s(3)) and not(q_s(2)) and not(q_s(1)) and not(q_s(0))) or
			(q_s(3) and q_s(0));
		
		d_s(2)<=(q_s(2) and q_s(0)) or
			(q_s(2) and q_s(1)) or
			(q_s(3) and not(q_s(0)));
		
		d_s(1)<=(q_s(2) and not(q_s(1)) and not (q_s(0))) or
			(q_s(3) and not(q_s(0))) or
			(q_s(1) and q_s(0));
		
		d_s(0)<=not(q_s(0));
		
		s(3)<=q_s(3);
		s(2)<=q_s(2);
		s(1)<=q_s(1);
		s(0)<=q_s(0);
		
	end gate_level;
