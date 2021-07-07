library ieee;
use ieee.std_logic_1164.all;

entity sipo_10 is
	port 
	(
		p_out : out std_logic_vector(9 downto 0);
		sr_in	: in std_logic;
		sh	: in std_logic;
		clk, rst_n : in std_logic
	);

end entity;

architecture rtl of sipo_10 is

	-- Build an array type for the shift register
	type sr_length is array (9 downto 0) of std_logic;
	
	-- Declare the shift register signal
	signal sr: sr_length;

begin

	process (clk,rst_n)
	begin
	if (rst_n='0') then
		sr(9 downto 0)<=(others=>'1');
	elsif (rising_edge(clk)) then
		if (sh = '1') then
			
				-- Shift data by one stage; data from last stage is lost
			sr(8 downto 0) <= sr(9 downto 1);
				
				-- Load new data into the first stage
			sr(9) <= sr_in;
			

			
			end if;
		end if;
	end process;
	
	-- Capture the data from the last stage, before it is lost
	--sr_out <= sr(0);
			p_out(9)<=sr(9);
			p_out(8)<=sr(8);			
			p_out(7)<=sr(7);
			p_out(6)<=sr(6);
			p_out(5)<=sr(5);
			p_out(4)<=sr(4);
			p_out(3)<=sr(3);
			p_out(2)<=sr(2);
			p_out(1)<=sr(1);
			p_out(0)<=sr(0);


end rtl;