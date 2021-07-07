library ieee;
use ieee.std_logic_1164.all;

entity pipeline_reg_8_bits is
	port(
			clk     : in std_logic;
         enable  : in std_logic;
         rst_n   : in std_logic;
		   reg_in  : in std_logic_vector(7 downto 0);
         reg_out : out std_logic_vector(7 downto 0)		
        );
end pipeline_reg_8_bits;

architecture behaviour of pipeline_reg_8_bits is
begin

	reg: process (clk, rst_n)
	begin
	if rst_n = '0' then
	
		reg_out <= (others => '0');
		
	elsif (clk'event and clk='1') then
	
    		if enable='1' then
			
    				reg_out <= reg_in;
					
			end if;
	end if;
	
	end process;

end behaviour;
