library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity final_project is
	port(
		PB, CLK_50_MHZ: in std_logic;
		u: in std_logic_vector(4 downto 0);
		HEX5: out std_logic_vector(7 downto 0);
		HEX4: out std_logic_vector(7 downto 0);
		HEX3: out std_logic_vector(7 downto 0);
		HEX2: out std_logic_vector(7 downto 0);
		HEX1: out std_logic_vector(7 downto 0);
		HEX0: out std_logic_vector(7 downto 0)
		);
end final_project;

architecture gate_level of final_project is
	component counter_00_to_FF 
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(7 downto 0));
	end component;
	
	component rom
		port(
			address: in std_logic_vector (7 downto 0);
			clock: in std_logic  := '1';
			q: out std_logic_vector (7 downto 0));
	end component;
	
	component arithmetic_block 
		port(
			i: in std_logic_vector(7 downto 0);
			operation: in std_logic_vector(1 downto 0);
			clk: in std_logic;
			o: out std_logic_vector(4 downto 0));
	end component;
	
	component operator_machine 
		port(
			clk: in std_logic;
			b: out std_logic_vector(1 downto 0));
	end component;
	
	component d_ff 
		port(
			d, clk, preset, clear: in std_logic;
			q: out std_logic);
	end component;
	
	component counter_0_to_F 
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	component Timing_Reference 
		port ( clk: in std_logic; -- Pin connected to P11 (N14)
				clk_2Hz: out std_logic);-- Can check it using PIN A8 - LEDR0
	end component;
	
	component counter_9_to_0 
		port(
			clk: in std_logic;
			s: out std_logic_vector(3 downto 0));
	end component;

	component debouncing_block 
		port(
			data: in std_logic;
			clk: in std_logic;
			output_data: out std_logic
		);
	end component;

	component Timing_Reference_2 
		port ( clk: in std_logic; -- Pin connected to P11 (N14)
				clk_2Hz: out std_logic);-- Can check it using PIN A8 - LEDR0

	end component;

	component hex10_to_7seg_dec 
		port(
			dot : in std_logic;
			d: in std_logic_vector(3 downto 0);
			a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s : out std_logic);
	end component;

	component operator_decoder 
		port(
			i: in std_logic_vector(1 downto 0);
			a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s: out std_logic
		);
	end component;
	
	signal counter_to_rom: std_logic_vector(7 downto 0);
	signal rom_to_arithmetic: std_logic_vector(7 downto 0);
	signal operator_mach_to_arithmetic: std_logic_vector(1 downto 0);
	signal arithmetic_to_comparator: std_logic_vector(4 downto 0);
	signal unity: std_logic_Vector(3 downto 0);
	signal ten: std_logic_vector(3 downto 0);
	signal reset_s: std_logic;
	signal comparating_s: std_logic_vector(4 downto 0);
	signal and_comparating_s: std_logic;
	signal dff_control_s: std_logic;
	signal timer_controller: std_logic;
	signal points: std_logic_vector(3 downto 0);
	signal timer_clock: std_logic;
	signal timing_ref_to_debouncing: std_logic;
	signal real_clk: std_logic;
	
	begin
		counter_00_to_FF_a: counter_00_to_FF port map(
			real_clk,
			'1',
			counter_to_rom);
		
		rom_a: rom port map(
			counter_to_rom,
			real_clk,
			rom_to_arithmetic);
			
		arithmetic_block_a: arithmetic_block port map(
			rom_to_arithmetic,
			operator_mach_to_arithmetic,
			real_clk,
			arithmetic_to_comparator);
		
		operator_machine_a: operator_machine port map(
			real_clk,
			operator_mach_to_arithmetic
		); 
		
		comparating_s(0)<=not(u(0) xor arithmetic_to_comparator(0)); 
		
		comparating_s(1)<=not(u(1) xor arithmetic_to_comparator(1)); 

		comparating_s(2)<=not(u(2) xor arithmetic_to_comparator(2)); 

		comparating_s(3)<=not(u(3) xor arithmetic_to_comparator(3)); 

		comparating_s(4)<=not(u(4) xor arithmetic_to_comparator(4)); 
		
		and_comparating_s<=comparating_s(0) and comparating_s(1) and comparating_s(2) and 
			comparating_s(3) and comparating_s(4);
		
		d_ff_f: d_ff port map(
			and_comparating_s,
			real_clk,
			dff_control_s,
			'1',
			dff_control_s);
		
		reset_s<=timer_controller and dff_control_s;

		counter_0_to_F_a: counter_0_to_F port map(
			real_clk, 
			reset_s,
			points
		); 

		Timing_Reference_a: Timing_Reference port map(
			CLK_50_MHZ,
			timer_clock
		);

		counter_9_to_0_a: counter_9_to_0 port map(
			timer_clock, 
			unity
		);

		counter_9_to_0_b: counter_9_to_0 port map(
			unity(3), 
			ten
		);

		timer_controller<=not(not(ten(3)) and not(ten(2)) and not(ten(1)) and not(ten(0)) and 
			not(unity(3)) and not(unity(2)) and not(unity(1)) and not(unity(0))); 
		
		Timing_Reference_b: Timing_Reference_2 port map(
			CLK_50_MHZ,
			timing_ref_to_debouncing
		);

		debouncing_block_a: debouncing_block port map(
			PB,
			timing_ref_to_debouncing,
			real_clk
		);

		hex10_to_7seg_dec_5: hex10_to_7seg_dec port map(
			'0',
			rom_to_arithmetic(7 downto 4),
			HEX5(0), HEX5(1), HEX5(2), HEX5(3), HEX5(4), HEX5(5), HEX5(6), HEX5(7)
		);

		hex10_to_7seg_dec_3: hex10_to_7seg_dec port map(
			'1',
			rom_to_arithmetic(3 downto 0),
			HEX3(0), HEX3(1), HEX3(2), HEX3(3), HEX3(4), HEX3(5), HEX3(6), HEX3(7)
		);

		operator_decoder_a: operator_decoder port map(
			operator_mach_to_arithmetic,
			HEX4(0), HEX4(1), HEX4(2), HEX4(3), HEX4(4), HEX4(5), HEX4(6), HEX4(7)
		);

		hex10_to_7seg_dec_0: hex10_to_7seg_dec port map(
			'0',
			points,
			HEX0(0), HEX0(1), HEX0(2), HEX0(3), HEX0(4), HEX0(5), HEX0(6), HEX0(7)
		);

		hex10_to_7seg_dec_1: hex10_to_7seg_dec port map(
			'1',
			unity,
			HEX1(0), HEX1(1), HEX1(2), HEX1(3), HEX1(4), HEX1(5), HEX1(6), HEX1(7)
		);

		hex10_to_7seg_dec_2: hex10_to_7seg_dec port map(
			'0',
			ten,
			HEX2(0), HEX2(1), HEX2(2), HEX2(3), HEX2(4), HEX2(5), HEX2(6), HEX2(7)
		);
	end gate_level;
