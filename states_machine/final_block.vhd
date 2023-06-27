library ieee;
use ieee.std_logic_1164.all;

entity final_block is
	port(
		clk: in std_logic;
		a, b, c, d, e, f, g: out std_logic);
end final_block;

architecture main_arch of final_block is
	signal d3_s, d2_s, d1_s, d0_s : std_logic;

	component state_machine
		port(
			main_clk: in std_logic;
			q_out: out std_logic_vector(3 downto 0));
	end component;
	
	component hex10_to_7seg_dec 
		port(d3, d2, d1, d0 : in std_logic;
			a, b, c, d, e, f, g : out std_logic);
	end component;
	
	begin
		state_machine1: state_machine port map(main_clk=>clk, q_out(3)=>d3_s, q_out(2)=>d2_S, q_out(1)=>d1_S, q_out(0)=>d0_S);
		hex10_to_7seg_dec1: hex10_to_7seg_dec port map(d3=>d3_s, d2=>d2_S, d1=>d1_s, d0=>d0_s, a=>a, b=>b, c=>c, d=>d, e=>e, f=>f, g=>g); 
end main_arch;
		