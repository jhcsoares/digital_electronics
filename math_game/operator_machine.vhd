library ieee;
use ieee.std_logic_1164.all;

entity operator_machine is
	port(
		clk: in std_logic;
		b: out std_logic_vector(1 downto 0));
end operator_machine;

architecture gate_level of operator_machine is
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;

	signal q_s: std_logic_Vector(1 downto 0);
	signal d_s: std_logic_vector(1 downto 0);

	begin
		d_ff0: d_ff port map(d=>d_s(0), clk=>clk, preset=>'1', clear=>'1', q=>q_s(0));
		d_ff1: d_ff port map(d=>d_s(1), clk=>clk, preset=>'1', clear=>'1', q=>q_s(1));
		
		d_s(0)<=not(q_s(0));
		d_s(1)<=(q_s(1) and not(q_s(0))) or (not(q_s(1)) and q_s(0));
		
		b(0)<=q_s(0);
		b(1)<=q_s(1);
		
	end gate_level;
