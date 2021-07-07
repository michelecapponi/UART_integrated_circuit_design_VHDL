library ieee;
use ieee.std_logic_1164.all;

entity TX is
port (
		clk: in std_logic;
		rst_n: in std_logic;
		enable_tx: in std_logic;
		load: in std_logic;
		tx_empty: out std_logic;
		dato_tx: in std_logic_vector(7 downto 0);
		en_tx_empty: out std_logic;
		TxD: out std_logic
     );
end entity;

architecture rtl of TX is

COMPONENT datapath IS PORT(
		clk: in std_logic;
		rst_n: in std_logic;
		p_in : in std_logic_vector(7 downto 0);
		parallel_load : in std_logic;
		sh	: in std_logic;
		TxD	: out std_logic;
		enable_137, enable_9: in std_logic;
		tc_137, tc_9: out std_logic
		);
END COMPONENT;

COMPONENT fsm IS PORT(
			TC_137, TC_9, RST_N, CLK, load, enable_tx : IN STD_LOGIC;
			sh, parallel_load, enable_137, enable_9, reset_n_datapath, TX_EMPTY, en_tx_empty: OUT STD_LOGIC
			);
END COMPONENT;

SIGNAL parallel_load, enable_137, enable_9, sh, TC_137, TC_9, reset_n_datapath: std_logic;  --segnali interni che collegano datapath a fsm

begin

label_datapath: datapath PORT MAP(clk=>clk, rst_n=>reset_n_datapath, p_in=>dato_tx, parallel_load=>parallel_load, sh=>sh, TxD=>TxD, enable_137=>enable_137, enable_9=>enable_9, tc_137=>tc_137, tc_9=>tc_9);

label_fsm: fsm PORT MAP(tc_137=>tc_137, tc_9=>tc_9, RST_N=>rst_n, CLK=>clk, load=>load, enable_tx=>enable_tx, sh=>sh, parallel_load=>parallel_load, enable_137=>enable_137, enable_9=>enable_9, reset_n_datapath=>reset_n_datapath,TX_EMPTY=>TX_EMPTY, en_tx_empty=>en_tx_empty);


END rtl;