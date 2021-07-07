library ieee;
use ieee.std_logic_1164.all;

entity PIPO_2 is
	port 
	(
		data_out : out std_logic_vector(1 downto 0);
		data_in	: in std_logic_vector(1 downto 0);
		load	: in std_logic;
		clk, rst_n : in std_logic
	);

end entity;

architecture rtl of PIPO_2 is

begin

	process (clk,rst_n)
	begin
	if (rst_n='0') then
		data_out <= (others=>'0');
	elsif (rising_edge(clk)) then
		if (load = '1') then			
			
			data_out <= data_in;
			
			end if;
		end if;
	end process;

end rtl;
