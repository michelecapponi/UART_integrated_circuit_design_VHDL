library ieee;
use ieee.std_logic_1164.all;

entity datapath_bi is
port (
		clk              : in std_logic;
		rst_n            : in std_logic;
		sel				  : in std_logic;
		din				  : in std_logic_vector(7 downto 0);
		rx_full          : in std_logic;
		err 				  : in std_logic;
		tx_empty         : in std_logic;
		rx_data			  : in std_logic_vector(7 downto 0);
		dout				  : out std_logic_vector(7 downto 0);
		data_out			  : buffer std_logic_vector(7 downto 0)		
     );
end entity;

architecture rtl of datapath_bi is

COMPONENT mux_2_to_1_8_bits IS
  PORT(
      sel    : in std_logic;
		IN_1   : in std_logic_vector(7 downto 0);
		IN_2   : in std_logic_vector(7 downto 0);
      OUTPUT : out std_logic_vector(7 downto 0)
	);
END COMPONENT;

COMPONENT pipeline_reg_8_bits IS
  PORT(
			clk     : in std_logic;
         enable  : in std_logic;
         rst_n   : in std_logic;
		   reg_in  : in std_logic_vector(7 downto 0);
         reg_out : out std_logic_vector(7 downto 0)		
        );
END COMPONENT;

SIGNAL status: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin

status <= "00000" & rx_full & err & tx_empty;

pipe_reg: pipeline_reg_8_bits PORT MAP(clk=>clk, rst_n=>rst_n, enable=>'1', reg_in=>din, reg_out=>data_out);

out_mux: mux_2_to_1_8_bits PORT MAP(sel=>sel, IN_1=>status, IN_2=>rx_data, OUTPUT=>dout);

end rtl;