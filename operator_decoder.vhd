library ieee;
use ieee.std_logic_1164.all;

entity operator_decoder is
    port(
        i: in std_logic_vector(1 downto 0);
        a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s: out std_logic
    );
end operator_decoder;

architecture gate_level of operator_decoder is

    begin
        h_s<=not(not(i(0)) and not(i(1)));
        g_s<=not(not(i(0)) or not(i(1)));
        f_s<=not(i(1));
        e_s<=not(i(1));
        d_s<=not(i(0) and i(1));
        c_s<=not(i(1));
        b_s<=not(i(1));
        a_s<=not(i(1));
    end gate_level;
