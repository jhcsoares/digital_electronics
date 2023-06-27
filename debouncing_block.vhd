library ieee;
use ieee.std_logic_1164.all;

entity debouncing_block is  
    port(
        data: in std_logic;
        clk: in std_logic;
        output_data: out std_logic
    );
end debouncing_block;

architecture gate_level of debouncing_block is
    component d_ff 
        port(
            d, clk, preset, clear: in std_logic;
            q: out std_logic);
    end component;

    signal op_s: std_logic_vector(9 downto 0);

    begin
        d_ff_0: d_ff port map(
            data, 
            clk,
            '1',
            '1',
            op_s(0)
        );
        
        d_ff_1: d_ff port map(
            op_s(0), 
            clk,
            '1',
            '1',
            op_s(1)
        );

        d_ff_2: d_ff port map(
            op_s(1), 
            clk,
            '1',
            '1',
            op_s(2)
        );

        d_ff_3: d_ff port map(
            op_s(2), 
            clk,
            '1',
            '1',
            op_s(3)
        );

        d_ff_4: d_ff port map(
            op_s(3), 
            clk,
            '1',
            '1',
            op_s(4)
        );

        d_ff_5: d_ff port map(
            op_s(4), 
            clk,
            '1',
            '1',
            op_s(5)
        );

        d_ff_6: d_ff port map(
            op_s(5), 
            clk,
            '1',
            '1',
            op_s(6)
        );

        d_ff_7: d_ff port map(
            op_s(6), 
            clk,
            '1',
            '1',
            op_s(7)
        );

        d_ff_8: d_ff port map(
            op_s(7), 
            clk,
            '1',
            '1',
            op_s(8)
        );

        d_ff_9: d_ff port map(
            op_s(8), 
            clk,
            '1',
            '1',
            op_s(9)
        );

        output_data<=op_s(0) or op_s(1) or op_s(2) or op_s(3) or op_s(4) or op_s(5) or 
            op_s(6) or op_s(7) or op_s(8) or op_s(9);
             
    end gate_level;
