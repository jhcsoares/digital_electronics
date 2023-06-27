library ieee;
use ieee.std_logic_1164.all;

entity final_block is
	port(
		MAX10_CLK1_50_PIN_P11, MAX10_CLK2_50_PIN_N14, SW0_PIN_C10, KEY0_PIN_B8, KEY1_PIN_A7: in std_logic;
		HEX00_PIN_C14, HEX01_PIN_E15, HEX02_PIN_C15, HEX03_PIN_C16, HEX04_PIN_E16, HEX05_PIN_D17, HEX06_PIN_C17, HEX07_PIN_D15: out std_logic;
		HEX10_PIN_C18, HEX11_PIN_D18, HEX12_PIN_E18, HEX13_PIN_B16, HEX14_PIN_A17, HEX15_PIN_A18, HEX16_PIN_B17, HEX17_PIN_A16: out std_logic; 
		HEX20_PIN_B20, HEX21_PIN_A20, HEX22_PIN_B19, HEX23_PIN_A21, HEX24_PIN_B21, HEX25_PIN_C22, HEX26_PIN_B22, HEX27_PIN_A19: out std_logic;
		HEX30_PIN_F21, HEX31_PIN_E22, HEX32_PIN_E21, HEX33_PIN_C19, HEX34_PIN_C20, HEX35_PIN_D19, HEX36_PIN_E17, HEX37_PIN_D22: out std_logic;
		HEX40_PIN_F18, HEX41_PIN_E20, HEX42_PIN_E19, HEX43_PIN_J18, HEX44_PIN_H19, HEX45_PIN_F19, HEX46_PIN_F20, HEX47_PIN_F17: out std_logic; 
		HEX50_PIN_J20, HEX51_PIN_K20, HEX52_PIN_L18, HEX53_PIN_N18, HEX54_PIN_M20, HEX55_PIN_N19, HEX56_PIN_N20, HEX57_PIN_L19: out std_logic);
end final_block;

architecture behavioral of final_block is
	component timing_reference_mux 
		port(
			clk1, clk2, switch: in std_logic;
			s: out std_logic);
	end component;
	
	component start_stop_block 
		port(
			start_stop_button, clk: in std_logic;
			s: out std_logic);
	end component;
	
	component timer
		port(
			clk, clear: in std_logic;
			q: out std_logic_vector(23 downto 0));
	end component;
	
	component ra_pause_block 
		port(
			b: in std_logic_vector(23 downto 0);
			s: out std_logic);
	end component;
	
	component hex10_to_7seg_dec 
		port(
			dot : in std_logic;
			d: in std_logic_vector(3 downto 0);
			a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s : out std_logic);
	end component;

	
	signal tmp: std_logic_vector(5 downto 0);
	signal q_s: std_logic_vector(23 downto 0);
	
begin
	timing_reference_mux1: timing_reference_mux port map(
		clk1=>MAX10_CLK1_50_PIN_P11, 
		clk2=>MAX10_CLK2_50_PIN_N14, 
		switch=>SW0_PIN_C10, 
		s=>tmp(1));
	
	start_stop_block1: start_stop_block port map(
		start_stop_button=>tmp(5), 
		clk=>tmp(1),
		s=>tmp(2));
	
	tmp(5)<=not(KEY0_PIN_B8) xor tmp(4);
	
	timer1: timer port map(
		clk=>tmp(2),
		clear=>KEY1_PIN_A7, 
		q(23)=>q_s(23),
		q(22)=>q_s(22),
		q(21)=>q_s(21),
		q(20)=>q_s(20),
		q(19)=>q_s(19),
		q(18)=>q_s(18),
		q(17)=>q_s(17),
		q(16)=>q_s(16),
		q(15)=>q_s(15),
		q(14)=>q_s(14),
		q(13)=>q_s(13),
		q(12)=>q_s(12),
		q(11)=>q_s(11),
		q(10)=>q_s(10),
		q(9)=>q_s(9),
		q(8)=>q_s(8),
		q(7)=>q_s(7),
		q(6)=>q_s(6),
		q(5)=>q_s(5),
		q(4)=>q_s(4),
		q(3)=>q_s(3),
		q(2)=>q_s(2),
		q(1)=>q_s(1),
		q(0)=>q_s(0));
	
	ra_pause_block1: ra_pause_block port map(
		b(23)=>q_s(23),
		b(22)=>q_s(22),
		b(21)=>q_s(21),
		b(20)=>q_s(20),
		b(19)=>q_s(19),
		b(18)=>q_s(18),
		b(17)=>q_s(17),
		b(16)=>q_s(16),
		b(15)=>q_s(15),
		b(14)=>q_s(14),
		b(13)=>q_s(13),
		b(12)=>q_s(12),
		b(11)=>q_s(11),
		b(10)=>q_s(10),
		b(9)=>q_s(9),
		b(8)=>q_s(8),
		b(7)=>q_s(7),
		b(6)=>q_s(6),
		b(5)=>q_s(5),
		b(4)=>q_s(4),
		b(3)=>q_s(3),
		b(2)=>q_s(2),
		b(1)=>q_s(1),
		b(0)=>q_s(0),
		s=>tmp(4));
	
	hex10_to_7seg_dec0: hex10_to_7seg_dec port map(
		dot=>'0',
		d(3)=>q_s(3),
		d(2)=>q_s(2),
		d(1)=>q_s(1),
		d(0)=>q_s(0),
		a_s=>HEX00_PIN_C14, 
		b_s=>HEX01_PIN_E15,
		c_s=>HEX02_PIN_C15,
		d_s=>HEX03_PIN_C16,
		e_s=>HEX04_PIN_E16,
		f_s=>HEX05_PIN_D17,
		g_s=>HEX06_PIN_C17,
		h_s=>HEX07_PIN_D15);
	
	hex10_to_7seg_dec1: hex10_to_7seg_dec port map(
		dot=>'0',
		d(3)=>q_s(7),
		d(2)=>q_s(6),
		d(1)=>q_s(5),
		d(0)=>q_s(4),
		a_s=>HEX10_PIN_C18, 
		b_s=>HEX11_PIN_D18,
		c_s=>HEX12_PIN_E18,
		d_s=>HEX13_PIN_B16,
		e_s=>HEX14_PIN_A17,
		f_s=>HEX15_PIN_A18,
		g_s=>HEX16_PIN_B17,
		h_s=>HEX17_PIN_A16);
	
	hex10_to_7seg_dec2: hex10_to_7seg_dec port map(
		dot=>'0',
		d(3)=>q_s(11),
		d(2)=>q_s(10),
		d(1)=>q_s(9),
		d(0)=>q_s(8),
		a_s=>HEX20_PIN_B20,
		b_s=>HEX21_PIN_A20,
		c_s=>HEX22_PIN_B19,
		d_s=>HEX23_PIN_A21,
		e_s=>HEX24_PIN_B21,
		f_s=>HEX25_PIN_C22,
		g_s=>HEX26_PIN_B22,
		h_s=>HEX27_PIN_A19);
	
	hex10_to_7seg_dec3: hex10_to_7seg_dec port map(
		dot=>'1',
		d(3)=>q_s(15),
		d(2)=>q_s(14),
		d(1)=>q_s(13),
		d(0)=>q_s(12),
		a_s=>HEX30_PIN_F21,  
		b_s=>HEX31_PIN_E22,
		c_s=>HEX32_PIN_E21,
		d_s=>HEX33_PIN_C19,
		e_s=>HEX34_PIN_C20,
		f_s=>HEX35_PIN_D19,
		g_s=>HEX36_PIN_E17,
		h_s=>HEX37_PIN_D22);
	
	hex10_to_7seg_dec4: hex10_to_7seg_dec port map(
		dot=>'0',
		d(3)=>q_s(19),
		d(2)=>q_s(18),
		d(1)=>q_s(17),
		d(0)=>q_s(16),
		a_s=>HEX40_PIN_F18, 
		b_s=>HEX41_PIN_E20,
		c_s=>HEX42_PIN_E19,
		d_s=>HEX43_PIN_J18,
		e_s=>HEX44_PIN_H19,
		f_s=>HEX45_PIN_F19,
		g_s=>HEX46_PIN_F20,
		h_s=>HEX47_PIN_F17);
	
	hex10_to_7seg_dec5: hex10_to_7seg_dec port map(
		dot=>'1',
		d(3)=>q_s(23),
		d(2)=>q_s(22),
		d(1)=>q_s(21),
		d(0)=>q_s(20),
		a_s=>HEX50_PIN_J20, 
		b_s=>HEX51_PIN_K20,
		c_s=>HEX52_PIN_L18,
		d_s=>HEX53_PIN_N18,
		e_s=>HEX54_PIN_M20,
		f_s=>HEX55_PIN_N19,
		g_s=>HEX56_PIN_N20,
		h_s=>HEX57_PIN_L19);
end behavioral;		
