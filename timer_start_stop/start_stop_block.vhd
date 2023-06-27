library ieee;
use ieee.std_logic_1164.all;

entity start_stop_block is
	port(
		start_stop_button, clk: in std_logic;
		s: out std_logic);
end start_stop_block;

architecture behavioral of start_stop_block is
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	signal d_s, q_s, start_stop_s, clk_s: std_logic;
	
begin
	d_ff1: d_ff port map(d=>d_s, clk=>start_stop_s, preset=>'1', clear=>'1', q=>q_s);
	
	process(start_stop_button)
	begin
		start_stop_s<=start_stop_button;
		clk_s<=clk;
		d_s<=not(q_s);
		s<=q_s and clk_s;
	end process;
end behavioral;
