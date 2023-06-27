library ieee;
use ieee.std_logic_1164.all;

entity state_machine is
	port(
		main_clk: in std_logic;
		q_out: out std_logic_vector(3 downto 0));
end state_machine;

architecture state_machine_arch of state_machine is
	signal j3, j2, j1, j0 :std_logic;
	signal k3, k2, k1, k0 :std_logic;
	signal q3, q2, q1, q0 : std_logic;	
	
	component jk_ff
		port(
			j: in std_logic;
			k: in std_logic;
			clk: in std_logic;
			q: out std_logic);
	end component;
	
	begin
		jk_ff0: jk_ff port map(j=>j0, k=>k0, clk=>main_clk, q=>q0);
		jk_ff1: jk_ff port map(j=>j1, k=>k1, clk=>main_clk, q=>q1);
		jk_ff2: jk_ff port map(j=>j2, k=>k2, clk=>main_clk, q=>q2);
		jk_ff3: jk_ff port map(j=>j3, k=>k3, clk=>main_clk, q=>q3);
	
	j3 <= (q2 and q1) or (q2 and not(q0));
	k3 <= (not(q2) and not(q1) and q0) or (q2 and q1);
	
	j2 <= (q3 and q1) or (not(q3) and not(q1));
	k2 <= (q1 and q0) or (not(q3) and not(q0));
	
	j1 <= (not(q2) and not(q0)) or (q3 and q2) or (q2 and q0);
	k1 <= (not(q2) and q0) or (q3 and not(q0)) or (q2 and not(q0));
	
	j0 <= (not(q3) and q1) or (q2 and q1);
	k0 <= (q3 and q2 and q1) or (not(q3) and not(q2));
	
	q_out(0)<=q0;
	q_out(1)<=q1;
	q_out(2)<=q2;
	q_out(3)<=q3;
	
end state_machine_arch;		
