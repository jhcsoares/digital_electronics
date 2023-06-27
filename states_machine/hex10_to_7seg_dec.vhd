library IEEE;
use IEEE.std_logic_1164.all;

entity hex10_to_7seg_dec is
	port(d3, d2, d1, d0 : in std_logic;
		a, b, c, d, e, f, g : out std_logic);
	end hex10_to_7seg_dec;

architecture arch_hex10_to_7seg_dec of hex10_to_7seg_dec is
	begin
		a <= not((not(d3) and d2 and d0) or (d3 and not(d2) and not(d1)) or (not(d2) and not(d0)) or (not(d3) and d1) or (d2 and d1) or(d3 and not(d0)));
		b <= not((not(d3) and not(d1) and not(d0)) or (not(d3) and d1 and d0) or (d3 and not(d1) and d0) or (not(d2) and not(d0)) or (not(d3) and not(d2)));
		c <= not((not(d3) and not(d1)) or (not(d3) and d2) or (not(d1) and d0) or (d3 and not(d2)) or (not(d3) and d0));
		d <= not((d2 and not(d1) and d0) or (not(d2) and d1 and d0) or (not(d3) and not(d2) and not(d0)) or (d2 and d1 and not(d0)) or (d3 and not(d1) and not(d0)));
		e <= not((not(d2) and not(d0)) or (d1 and not(d0)) or (d3 and d1) or (d3 and d2));
		f <= not((not(d3) and d2 and not(d1)) or (not(d1) and not(d0)) or (d3 and not(d2)) or (d3 and d1) or (d2 and not(d0)));
		g <= not((not(d2) and d1) or(d1 and not(d0)) or (d3 and not(d2)) or (d3 and d0) or (not(d3) and d2 and not(d1))); 
	end arch_hex10_to_7seg_dec;
