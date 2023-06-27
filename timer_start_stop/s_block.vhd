library ieee;
use ieee.std_logic_1164.all;

entity s_block is
	port(
		clk, clear: in std_logic;
		q: out std_logic_vector(7 downto 0));
end s_block;

architecture behavioral of s_block is
	signal counter_0_9_s: std_logic_vector(3 downto 0);
	signal counter_0_5_s: std_logic_vector(3 downto 0);
	signal clear_s: std_logic;
	
	component counter_0_9
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	component counter_0_5
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	begin
		counter_0_9a: counter_0_9 port map(
			clk=>clk, clear=>clear_s, 
			q(3)=>counter_0_9_s(3), 
			q(2)=>counter_0_9_s(2), 
			q(1)=>counter_0_9_s(1), 
			q(0)=>counter_0_9_s(0));
			
		counter_0_5a: counter_0_5 port map(
			clk=>not(counter_0_9_s(3)), 
			clear=>clear_s, 
			q(3)=>counter_0_5_s(3), 
			q(2)=>counter_0_5_s(2), 
			q(1)=>counter_0_5_s(1), 
			q(0)=>counter_0_5_s(0));
		
		
		q(7)<=counter_0_5_s(3);
		q(6)<=counter_0_5_s(2);
		q(5)<=counter_0_5_s(1);
		q(4)<=counter_0_5_s(0);
		
		q(3)<=counter_0_9_s(3);
		q(2)<=counter_0_9_s(2);
		q(1)<=counter_0_9_s(1);
		q(0)<=counter_0_9_s(0);
		
		clear_s<=clear;
		
end behavioral;
