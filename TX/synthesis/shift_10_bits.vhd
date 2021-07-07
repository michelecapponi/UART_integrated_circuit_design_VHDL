library ieee;
use ieee.std_logic_1164.all;

entity shift_10_bits is
	port 
	(
		p_in : in std_logic_vector(9 downto 0);
		load : in std_logic;
		sr_in	: in std_logic;
		sh	: in std_logic;
		clk, rst_n		: in std_logic;
		sr_out	: out std_logic
	);

end entity;

architecture rtl of shift_10_bits is

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
		if(load='1') then
			sr(9)<=p_in(9);
			sr(8)<=p_in(8);
			sr(7)<=p_in(7);
			sr(6)<=p_in(6);
			sr(5)<=p_in(5);
			sr(4)<=p_in(4);
			sr(3)<=p_in(3);
			sr(2)<=p_in(2);
			sr(1)<=p_in(1);
			sr(0)<=p_in(0);
		elsif (sh = '1') then
			
				-- Shift data by one stage; data from last stage is lost
			sr(9 downto 1) <= sr(8 downto 0);
				
				-- Load new data into the first stage
			sr(0) <= sr_in;
			
			end if;
		end if;
	end process;
	
	-- Capture the data from the last stage, before it is lost
	sr_out <= sr(9);
	
end rtl;