library ieee;
use ieee.std_logic_1164.all;

entity BI is
port (
		clk            : in std_logic;
		rst_n          : in std_logic;
		din            : in std_logic_vector(7 downto 0);
		r_w_n          : in std_logic;
		address        : in std_logic_vector(2 downto 0);
		atn_ack        : in std_logic;
		cs             : in std_logic;
		reg_rx_full    : in std_logic;
		reg_err        : in std_logic;
		reg_tx_empty   : in std_logic;
      en_reg_rx_full : in std_logic;
		en_reg_tx_empty: in std_logic;
		reg_rx_data    : in std_logic_vector(7 downto 0);
		reg_tx_data    : out std_logic_vector(7 downto 0);
		reg_ctrl_data  : out std_logic_vector(1 downto 0);
		atn            : out std_logic; 
		dout           : out std_logic_vector(7 downto 0);
		rst_n_regs     : out std_logic;
		rst_n_rx       : out std_logic;
		enable_tx_data_reg : out std_logic;
		enable_ctrl_reg    : out std_logic
     );
end entity;

architecture rtl of BI is

COMPONENT datapath_bi IS PORT
		(
		clk              : in std_logic;
		rst_n            : in std_logic;
		sel				  : in std_logic;
		din				  : in std_logic_vector(7 downto 0);
		rx_full          : in std_logic;
		err 				  : in std_logic;
		tx_empty         : in std_logic;
		rx_data			  : in std_logic_vector(7 downto 0);
		dout				  : out std_logic_vector(7 downto 0);
		data_out			  : out std_logic_vector(7 downto 0)		
     );
END COMPONENT;

COMPONENT fsm_bi IS PORT
		( 
			clk        : in std_logic;
			rst_n      : in std_logic;
			cs         : in std_logic;
			address    : in std_logic_vector(2 downto 0);
			r_w_n      : in std_logic;
			atn_ack    : in std_logic;
			rx_full    : in std_logic;
			tx_empty   : in std_logic;
			en_rx_full : in std_logic;
			en_tx_empty: in std_logic;
			atn		  : out std_logic;
			rst_n_regs : buffer std_logic;
			rst_n_rx   : out std_logic;
			enable_tx_data_reg : out std_logic;
			enable_ctrl_reg    : out std_logic;
			sel		          : out std_logic
			);
END COMPONENT;

--SIGNAL parallel_load, enable_137, enable_9, sh, TC_137, TC_9, reset_n_datapath: std_logic;  --segnali interni che collegano datapath a fsm
SIGNAL sel, rx_full, err, tx_empty  : std_logic;
SIGNAL data_out: std_logic_vector(7 downto 0);

begin

reg_ctrl_data <= data_out(1 downto 0);

reg_tx_data<= data_out(7 downto 0);

label_datapath_bi : datapath_bi PORT MAP(clk=>clk, rst_n=>rst_n_regs, sel=>sel, din=>din, rx_full=>reg_rx_full, err=>reg_err, tx_empty=>reg_tx_empty,
														rx_data=>reg_rx_data, dout=>dout, data_out=>data_out);

label_fsm_bi : fsm_bi PORT MAP(clk=>clk, rst_n=>rst_n, cs=>cs, address=>address, r_w_n=>r_w_n, atn_ack=>atn_ack, rx_full=>reg_rx_full,
											tx_empty=>reg_tx_empty, en_rx_full=>en_reg_rx_full, en_tx_empty=>en_reg_tx_empty, atn=>atn,
											rst_n_regs=> rst_n_regs, rst_n_rx=> rst_n_rx, enable_tx_data_reg=>enable_tx_data_reg,
											enable_ctrl_reg=>enable_ctrl_reg, sel=>sel);

--label_datapath: datapath PORT MAP(clk=>clk, rst_n=>reset_n_datapath, p_in=>dato_tx, parallel_load=>parallel_load, sh=>sh, TxD=>TxD, enable_137=>enable_137, enable_9=>enable_9, tc_137=>tc_137, tc_9=>tc_9);

--label_fsm: fsm PORT MAP(tc_137=>tc_137, tc_9=>tc_9, RST_N=>rst_n, CLK=>clk, load=>load, enable_tx=>enable_tx, sh=>sh, parallel_load=>parallel_load, enable_137=>enable_137, enable_9=>enable_9, reset_n_datapath=>reset_n_datapath,TX_EMPTY=>TX_EMPTY, en_tx_empty=>en_tx_empty);


END rtl;