library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity lab7 is
	port(
		clk, pb: in std_logic;
		hex0, hex1, hex2, hex3, hex4: out std_logic_vector(7 downto 0);
		led: out std_logic);
end lab7;

architecture gate_level of lab7 is
	component Timing_Reference_1 
		port ( 
			clk: in std_logic; 
			clk_2Hz: out std_logic);
	end component;
	
	component counter_0_to_F 
		port(
			clk: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	component counter_00_to_FF 
		port(
			clk: in std_logic;
			q: out std_logic_vector(7 downto 0));
	end component;
	
	component hex10_to_7seg_dec 
		port(
			dot: in std_logic;
			d: in std_logic_vector(3 downto 0);
			a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s: out std_logic);
	end component;
	
	component rom_memory 
		port(
			address: in std_logic_vector (7 downto 0);
			clock: in std_logic  := '1';
			q: out std_logic_vector (7 downto 0));
	end component;
	
	component piso_test 
		port(
			ls, clk: in std_logic;
			d: in std_logic_vector(7 downto 0);
			s: out std_logic);
	end component;
	
	component sequence_detector 
		port(
			i, clk: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	signal memory_to_piso: std_logic_vector(7 downto 0);
	signal counter_to_memory: std_logic_vector(7 downto 0);
	signal controller: std_logic_vector(3 downto 0);
	signal sequence_detector_out: std_logic_vector(3 downto 0);
	signal controlled_clock: std_logic;
	signal load_or_shift: std_logic;
	signal piso_to_seq_detector: std_logic;
	signal seq_pause: std_logic;
	signal d_ff_clk_signal, d_ff_d, d_ff_q: std_logic;
	signal timing_reference_out: std_logic;
	
begin
	counter_0_to_F_a: counter_0_to_F port map(
		controlled_clock, 
		controller);
		
	counter_00_to_FF_a: counter_00_to_FF port map(
		controller(3), 
		counter_to_memory);
		
	rom_memory_a: rom_memory port map(
		counter_to_memory,
		controller(3),
		memory_to_piso);
		
	piso_test_a: piso_test port map(
		load_or_shift,
		controller(0),
		memory_to_piso,
		piso_to_seq_detector);
	
	sequence_detector_a: sequence_detector port map(
		piso_to_seq_detector,
		controller(0),
		sequence_detector_out(3 downto 0));
	
	d_ff_a: d_ff port map( 
		d_ff_d, 
		d_ff_clk_signal,
		'1',
		'1',
		d_ff_q);
	
	Timing_Reference_1_a: Timing_Reference_1 port map(
		clk, 
		timing_reference_out); 
	
	hex10_to_7seg_dec_counter_msb: hex10_to_7seg_dec port map(
		'0',
		counter_to_memory(7 downto 4),
		hex1(0),
		hex1(1),
		hex1(2),
		hex1(3),
		hex1(4),
		hex1(5),
		hex1(6),
		hex1(7));
		
	hex10_to_7seg_dec_counter_lsb: hex10_to_7seg_dec port map(
		'1',
		counter_to_memory(3 downto 0),
		hex0(0),
		hex0(1),
		hex0(2),
		hex0(3),
		hex0(4),
		hex0(5),
		hex0(6),
		hex0(7));
	
	hex10_to_7seg_dec_rom_msb: hex10_to_7seg_dec port map(
		'0',
		memory_to_piso(7 downto 4),
		hex3(0),
		hex3(1),
		hex3(2),
		hex3(3),
		hex3(4),
		hex3(5),
		hex3(6),
		hex3(7));
	
	hex10_to_7seg_dec_rom_lsb: hex10_to_7seg_dec port map(
		'1',
		memory_to_piso(3 downto 0),
		hex2(0),
		hex2(1),
		hex2(2),
		hex2(3),
		hex2(4),
		hex2(5),
		hex2(6),
		hex2(7));
	
	hex10_to_7seg_dec_rom_seq_det: hex10_to_7seg_dec port map(
		'1',
		sequence_detector_out(3 downto 0),
		hex4(0),
		hex4(1),
		hex4(2),
		hex4(3),
		hex4(4),
		hex4(5),
		hex4(6),
		hex4(7));
	
	seq_pause<=not(sequence_detector_out(3)) and
		sequence_detector_out(2) and
		sequence_detector_out(1) and
		sequence_detector_out(0);
		
	load_or_shift<=controller(3) and
		not(controller(2)) and
		not(controller(1)) and
		not(controller(0));
	
	d_ff_clk_signal<=not(pb) xor seq_pause;

	d_ff_d<=not(d_ff_q);
	
	controlled_clock<=d_ff_q and timing_reference_out;
	
	led<=seq_pause;
	
end gate_level;
