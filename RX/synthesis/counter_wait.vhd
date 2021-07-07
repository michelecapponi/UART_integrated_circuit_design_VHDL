library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;


entity counter_wait is  --interfaccia contatore
	port 
	(
		clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic
	);

end entity;

architecture rtl of counter_wait is

signal number: unsigned(0 DOWNTO 0);


begin
count: process(clk, rst_n)
		 begin
		 if(rst_n='0') then
				number<= (others=> '0');
		 elsif(clk'event and clk='1') then
			
		 if(enable='1') then
				if number="1" then
					number<=(others=>'0');
				else
					number<= number+1;
				end if;
			end if;
		end if;
	end process;
	
tc<=number(0);   --number(1) and number(0);

end rtl;