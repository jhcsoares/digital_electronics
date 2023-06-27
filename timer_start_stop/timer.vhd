library ieee;
use ieee.std_logic_1164.all;

entity timer is
	port(
		clk, clear: in std_logic;
		q: out std_logic_vector(23 downto 0));
end timer;

architecture behavioral of timer is
	component ms_block 
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(11 downto 0));
	end component;
	
	component s_block 
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(7 downto 0));
	end component;
	
	component counter_0_9
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	signal ms_block_s: std_logic_vector(11 downto 0);
	signal s_block_s: std_logic_vector(7 downto 0);
	signal m_block_s: std_logic_vector(3 downto 0);
	signal clear_s: std_logic;
	
	begin
		ms_block_a: ms_block port map(
			clk=>clk,
			clear=>clear_s,
			q(11)=>ms_block_s(11), 
			q(10)=>ms_block_s(10), 
			q(9)=>ms_block_s(9), 
			q(8)=>ms_block_s(8), 
			q(7)=>ms_block_s(7), 
			q(6)=>ms_block_s(6), 
			q(5)=>ms_block_s(5), 
			q(4)=>ms_block_s(4), 
			q(3)=>ms_block_s(3), 
			q(2)=>ms_block_s(2), 
			q(1)=>ms_block_s(1), 
			q(0)=>ms_block_s(0));
			
		s_block_a: s_block port map(
			clk=>not(ms_block_s(11)), 
			clear=>clear_s,
			q(7)=>s_block_s(7), 
			q(6)=>s_block_s(6), 
			q(5)=>s_block_s(5), 
			q(4)=>s_block_s(4), 
			q(3)=>s_block_s(3), 
			q(2)=>s_block_s(2), 
			q(1)=>s_block_s(1), 
			q(0)=>s_block_s(0));
			
		m_block_a: counter_0_9 port map(
			clk=>not(s_block_s(6)),
			clear=>clear_s,	
			q(3)=>m_block_s(3), 
			q(2)=>m_block_s(2), 
			q(1)=>m_block_s(1), 
			q(0)=>m_block_s(0));
		
		q(23)<=m_block_s(3);
		q(22)<=m_block_s(2);
		q(21)<=m_block_s(1);
		q(20)<=m_block_s(0);
		q(19)<=s_block_s(7);
		q(18)<=s_block_s(6);
		q(17)<=s_block_s(5);
		q(16)<=s_block_s(4);
		q(15)<=s_block_s(3);
		q(14)<=s_block_s(2);
		q(13)<=s_block_s(1);
		q(12)<=s_block_s(0);
		q(11)<=ms_block_s(11);
		q(10)<=ms_block_s(10);
		q(9)<=ms_block_s(9);
		q(8)<=ms_block_s(8);
		q(7)<=ms_block_s(7);
		q(6)<=ms_block_s(6);
		q(5)<=ms_block_s(5);
		q(4)<=ms_block_s(4);
		q(3)<=ms_block_s(3);
		q(2)<=ms_block_s(2);
		q(1)<=ms_block_s(1);
		q(0)<=ms_block_s(0);
		
		clear_s<=clear;	
end behavioral;
