library ieee;
use ieee.std_logic_1164.all;

entity mux_2_to_1_8_bits is
	port(
    	-- Selector
      sel : in std_logic;
    	-- Inputs
		IN_1 : in std_logic_vector(7 downto 0);
		IN_2 : in std_logic_vector(7 downto 0);
        -- Output
      OUTPUT : out std_logic_vector(7 downto 0)
	);
end mux_2_to_1_8_bits;

architecture behaviour of mux_2_to_1_8_bits is
begin

    MUX : process(sel, IN_1, IN_2)
    begin
      case sel is
        when '0' =>
        	OUTPUT <= IN_1;
        when '1' =>
        	OUTPUT <= IN_2;
        when others =>
        	OUTPUT <= IN_1;
      end case;
    end process MUX;

end behaviour;