library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;
library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity counter_16 is  --interfaccia contatore
	port 
	(
		clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic
	);

end entity;

architecture rtl of counter_16 is

signal number: unsigned(4 DOWNTO 0);


begin
count: process(clk, rst_n)
		 begin
		 if(rst_n='0') then
				number<= (others=> '0');
		 elsif(clk'event and clk='1') then
			
		 if(enable='1') then
				if number="10000" then -- rimettere a 18 "10010"
					number<=(others=>'0');
				else
					number<= number+1;
				end if;
			end if;
		end if;
	end process;
	
tc<=number(4) and not(number(3)) and not(number(2)) and not(number(1)) and not(number(0)); -- tc 18 tc<=number(4) and not(number(3)) and not(number(2)) and number(1) and not(number(0));

end rtl;