library ieee;
use ieee.std_logic_1164.all;

entity RX is
port (
		clk: in std_logic;
		rst_n: in std_logic;
		enable_rx: in std_logic;
		err: out std_logic;
		rx_full: out std_logic;
		en_err, en_rx_full: out std_logic;
		dato_rx: out std_logic_vector(7 downto 0);
		RxD: in std_logic
     );
end entity;

architecture rtl of RX is

COMPONENT datapath_rx IS PORT(
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
END COMPONENT;

COMPONENT fsm_rx IS PORT( tc_1, tc_wait, tc_8, tc_16, tc_10, voter, RxD, RST_N, CLK, enable_rx : IN STD_LOGIC;
			sh_sample, sh_dato, enable_wait, enable_8, enable_10, enable_16, reset_n_datapath, rx_full, en_rx_full, en_err, err: OUT STD_LOGIC
			);
END COMPONENT;

SIGNAL sh_sample, sh_dato, voter, enable_wait, enable_8, enable_10, enable_16, tc_wait, tc_8, tc_10, tc_16, tc_1, reset_n_datapath: STD_LOGIC;

BEGIN

label_datapath_rx: datapath_rx PORT MAP(clk=>clk, rst_n=>reset_n_datapath, dato_rx=>dato_rx, sh_sample=>sh_sample, sh_dato=>sh_dato, voter=>voter, 
				RxD=>RxD, enable_wait=>enable_wait, enable_8=>enable_8, enable_10=>enable_10, enable_16=>enable_16, tc_wait=>tc_wait, tc_8=>tc_8, tc_10=>tc_10, tc_16=>tc_16, tc_1=>tc_1);

label_fsm_rx: fsm_rx PORT MAP(tc_wait=>tc_wait, tc_8=>tc_8, tc_10=>tc_10, tc_16=>tc_16, voter=>voter, enable_wait=>enable_wait, enable_8=>enable_8, enable_10=>enable_10, enable_16=>enable_16,
										reset_n_datapath=>reset_n_datapath, rx_full=>rx_full, err=>err, RxD=>RxD, rst_n=>rst_n, clk=>clk, enable_rx=>enable_rx, sh_sample=>sh_sample,
										sh_dato=>sh_dato, tc_1=>tc_1, en_err=>en_err, en_rx_full=>en_rx_full);  -- MANCA PORT MAP FSM

END rtl;
