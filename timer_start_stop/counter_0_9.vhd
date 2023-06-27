library ieee;
use ieee.std_logic_1164.all;

entity counter_0_9 is
	port(
		clk, clear: in std_logic;
		q: out std_logic_vector(3 downto 0));
end counter_0_9;

architecture behavioral of counter_0_9 is
	signal d_s: std_logic_vector(3 downto 0);
	signal q_s: std_logic_vector(3 downto 0);
	signal clear_s: std_logic;

	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
		
	begin
		d_ff0: d_ff port map(
			d=>d_s(0), 
			clk=>clk, preset=>'1', 
			clear=>clear_s, 
			q=>q_s(0));
			
		d_ff1: d_ff port map(
			d=>d_s(1), clk=>clk, 
			preset=>'1', 
			clear=>clear_s, 
			q=>q_s(1));
			
		d_ff2: d_ff port map(
			d=>d_s(2), 
			clk=>clk, preset=>'1', 
			clear=>clear_s, 
			q=>q_s(2));
			
		d_ff3: d_ff port map(
			d=>d_s(3), 
			clk=>clk, 
			preset=>'1', 
			clear=>clear_s, 
			q=>q_s(3));
		
		process(clk, clear)
		begin
			d_s(3)<=(q_s(2) and q_s(1) and q_s(0)) or (q_s(3) and not(q_s(0)));
			d_s(2)<=(q_s(2) and not(q_s(1))) or (q_s(2) and not(q_s(0))) or (not(q_s(2)) and q_s(1) and q_s(0));
			d_s(1)<=(not(q_s(3)) and not(q_s(1)) and q_s(0)) or (q_s(1) and not(q_s(0)));
			d_s(0)<=not(q_s(0));
			clear_s<=clear;
		end process;
		
		q(3)<=q_s(3);
		q(2)<=q_s(2);
		q(1)<=q_s(1);
		q(0)<=q_s(0);
	
end behavioral;
