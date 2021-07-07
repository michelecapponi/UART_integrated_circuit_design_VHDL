library ieee;
use ieee.std_logic_1164.all;

entity FF is
	port 
	(
		data_out : out std_logic;
		data_in	: in std_logic;
		load,reset_value	: in std_logic;
		clk, rst_n : in std_logic
	);

end entity;

architecture rtl of FF is

begin

	process (clk,rst_n,reset_value)
	begin
	if (rst_n='0') then
		data_out <= reset_value;
	elsif (rising_edge(clk)) then
		if (load = '1') then			
			
			data_out <= data_in;
			
			end if;
		end if;
	end process;

end rtl;