library ieee;
use ieee.std_logic_1164.all;

entity PIPO_8 is
	port 
	(
		p_out : out std_logic_vector(7 downto 0);
		sr_in	: in std_logic_vector(7 downto 0);
		load	: in std_logic;
		clk, rst_n : in std_logic
	);

end entity;

architecture rtl of PIPO_8 is

	-- Build an array type for the shift register
	--type sr_length is array (7 downto 0) of std_logic;
	
	-- Declare the shift register signal
	--signal sr: sr_length;
	
	signal sr: std_logic_vector(7 downto 0);

begin

	process (clk,rst_n)
	begin
	if (rst_n='0') then
		sr(7 downto 0)<=(others=>'1');
	elsif (rising_edge(clk)) then
		if (load = '1') then			
			
			sr(7 downto 0) <= sr_in;
			
			end if;
		end if;
	end process;
	
	-- Capture the data from the last stage, before it is lost
			p_out<=sr;
end rtl;