library ieee;
use ieee.std_logic_1164.all;

entity ra_pause_block is
	port(
		b: in std_logic_vector(23 downto 0);
		s: out std_logic);
end ra_pause_block;

architecture behavioral of ra_pause_block is
begin

	s<=
		not(b(23)) and
		not(b(22)) and
		b(21) and
		b(20) and
		not(b(19)) and
		b(18) and
		not(b(17)) and
		b(16) and
		not(b(15)) and
		b(14) and
		not(b(13)) and
		b(12) and
		b(11) and 
		not(b(10)) and
		not(b(9)) and
		b(8) and
		not(b(7)) and
		not(b(6)) and 
		not(b(5)) and
		b(4) and
		not(b(3)) and
		b(2) and
		not(b(1)) and
		not(b(0));
		
end behavioral;
