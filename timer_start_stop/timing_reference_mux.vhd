library ieee;
use ieee.std_logic_1164.all;

entity timing_reference_mux is
	port(
		clk1, clk2, switch: in std_logic;
		s: out std_logic);
end timing_reference_mux;

architecture behavioral of timing_reference_mux is
	component Timing_Reference1
		port (
			clk: in std_logic; -- Pin connected to P11 (N14)
			clk_2Hz: out std_logic);-- Can check it using PIN A8 - LEDR0
	end component;
	
	component Timing_Reference2
		port (
			clk: in std_logic; -- Pin connected to P11 (N14)
			clk_2Hz: out std_logic);-- Can check it using PIN A8 - LEDR0
	end component;
	
	signal clk1_2hz_s, clk2_2hz_s: std_logic;
	signal signal_clk1, signal_clk2: std_logic;
	
begin
	timing_reference_a: Timing_Reference1 port map(
		clk=>clk1,
		clk_2Hz=>clk1_2hz_s);
		
	timing_reference_b: Timing_Reference2 port map(
		clk=>clk2,
		clk_2Hz=>clk2_2hz_s);
		
	process(clk1, clk2, switch)
	begin
		signal_clk1<=clk1_2hz_s and not(switch);
		signal_clk2<=clk2_2hz_s and switch;		
		s<=signal_clk1 or signal_clk2;
	end process;
end behavioral;
