library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_block is
	port(
		i: in std_logic_vector(7 downto 0);
		operation: in std_logic_vector(1 downto 0);
		clk: in std_logic;
		o: out std_logic_vector(4 downto 0));
end arithmetic_block;
	
architecture behavioral of arithmetic_block is
	signal operand1: unsigned(3 downto 0);
	signal operand2: unsigned(3 downto 0);
	
	begin
		operand1<=unsigned(i(7 downto 4));
		operand2<=unsigned(i(3 downto 0));
		
		process(clk)
		begin
			case operation is
				when "00" =>
					o<=std_logic_vector(('0' & operand1) + ('0' & operand2));
				
				when "01" =>
					if(operand1>=operand2) then
						o<=std_logic_vector(('0' & operand1) - ('0' & operand2));
					else
						o<=std_logic_vector(('0' & operand2) - ('0' & operand1));
					end if;
				
				when "10" =>
					o<=std_logic_vector(('0' & operand1) and ('0' & operand2));
				
				when "11" =>
					o<=std_logic_vector(('0' & operand1) or ('0' & operand2));
			end case;
		end process;
				
	end behavioral;
