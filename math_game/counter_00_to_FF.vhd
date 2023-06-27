library ieee;
use ieee.std_logic_1164.all;

entity counter_00_to_FF is
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(7 downto 0));
end counter_00_to_FF;

architecture gate_level of counter_00_to_FF is
	component counter_0_to_F 
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	signal q_s: std_logic_vector(7 downto 0);
	signal clk_s_b: std_logic;
	
begin
	counter_0_to_Fa: counter_0_to_F port map(clk=>clk, reset=>reset, q(3)=>q_s(3), q(2)=>q_s(2), q(1)=>q_s(1), q(0)=>q_s(0));
	counter_0_to_Fb: counter_0_to_F port map(clk=>clk_s_b, reset=>reset, q(3)=>q_s(7), q(2)=>q_s(6), q(1)=>q_s(5), q(0)=>q_s(4));
	
	clk_s_b<=(not(q_s(3)));
	
	q(7)<=q_s(7);
	q(6)<=q_s(6);
	q(5)<=q_s(5);
	q(4)<=q_s(4);
	q(3)<=q_s(3);
	q(2)<=q_s(2);
	q(1)<=q_s(1);
	q(0)<=q_s(0);
	
end gate_level;
