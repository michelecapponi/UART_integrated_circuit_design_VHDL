library ieee;
use ieee.std_logic_1164.all;

entity datapath is
port (
		clk: in std_logic;
		rst_n: in std_logic;
		p_in : in std_logic_vector(7 downto 0);
		parallel_load : in std_logic;
		sh	: in std_logic;
		TxD	: out std_logic;
		enable_137, enable_9: in std_logic;
		tc_137, tc_9: out std_logic
     );
end entity;

architecture rtl of datapath is

COMPONENT shift_10_bits IS
  PORT(p_in : in std_logic_vector(9 downto 0);
		load : in std_logic;
		sr_in	: in std_logic;
		sh	: in std_logic;
		clk, rst_n : in std_logic;
		sr_out	: out std_logic);
END COMPONENT;

COMPONENT counter IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic);
END COMPONENT;

COMPONENT counter_fsm IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic);
END COMPONENT;
SIGNAL PARALLEL_PORT: STD_LOGIC_VECTOR(9 DOWNTO 0);

begin

PARALLEL_PORT<='0' & p_in(7 downto 0) & '1';

shift_register: shift_10_bits PORT MAP(p_in=>PARALLEL_PORT, load=>parallel_load, sr_in=>'1', sh=>sh, clk=>clk, rst_n=>rst_n, sr_out=>TxD);

count: counter PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_137, tc=>tc_137);

count_fsm: counter_fsm PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_9, tc=>tc_9);

end rtl;