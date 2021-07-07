library ieee;
use ieee.std_logic_1164.all;

entity datapath_rx is
port (
		clk: in std_logic;
		rst_n: in std_logic;
		dato_rx : out std_logic_vector(7 downto 0);
		sh_sample : in std_logic;
		sh_dato	: in std_logic;
		voter : buffer std_logic;
		RxD	: in std_logic;
		enable_8, enable_10, enable_16, enable_wait: in std_logic;
		tc_8, tc_10, tc_16, tc_wait, tc_1: out std_logic
     );
end entity;

architecture rtl of datapath_rx is

COMPONENT counter_8 IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic);
END COMPONENT;

COMPONENT counter_10 IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc, tc_1: out std_logic);
END COMPONENT;

COMPONENT counter_16 IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic);
END COMPONENT;

COMPONENT counter_wait IS
  PORT(clk: in std_logic;
		rst_n: in std_logic;
		enable: in std_logic;
		tc: out std_logic);
END COMPONENT;

COMPONENT sipo_8 IS
	PORT(p_out : out std_logic_vector(7 downto 0);
		  sr_in	: in std_logic;
		  sh	: in std_logic;
		  clk, rst_n : in std_logic);
END COMPONENT;

COMPONENT sipo_10 IS
	PORT(p_out : out std_logic_vector(9 downto 0);
		  sr_in	: in std_logic;
		  sh	: in std_logic;
		  clk, rst_n : in std_logic);
END COMPONENT;

SIGNAL samples: std_logic_vector(7 DOWNTO 0);
SIGNAL dato: std_logic_vector(9 DOWNTO 0);

BEGIN

samples_reg: sipo_8 PORT MAP(p_out=>samples, sr_in=>RxD, sh=>sh_sample, clk=>clk, rst_n=>rst_n);

data_reg: sipo_10 PORT MAP(p_out=>dato, sr_in=>voter, sh=>sh_dato, clk=>clk, rst_n=>rst_n);

cnt0: counter_10 PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_10, tc=>tc_10, tc_1=>tc_1);

cnt1: counter_16 PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_16, tc=>tc_16);

cnt2: counter_wait PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_wait, tc=>tc_wait);

cnt3: counter_8 PORT MAP(clk=>clk, rst_n=>rst_n, enable=>enable_8, tc=>tc_8);

voter<= (samples(2) and samples(6)) or (samples(4) and samples(6)) or (samples(2) and samples(4));

dato_rx<= dato(8 downto 1);

END rtl;



