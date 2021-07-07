library ieee;
use ieee.std_logic_1164.all;

entity UART is
port (
		clk: in std_logic;
		rst_n: in std_logic;
		CS, R_W_N, ATN_ACK : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		address : in std_logic_vector(2 downto 0);
		ATN : out std_logic;
		data_out : out std_logic_vector(7 downto 0);
		rxd: in std_logic;
		txd: out std_logic
     );
end entity;

architecture behaviour of UART is

component TX is
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
end component;

component RX is
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
end component;

component BI is
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
		load           : out std_logic;
		reg_tx_data    : out std_logic_vector(7 downto 0);
		reg_ctrl_data  : out std_logic_vector(1 downto 0);
		atn            : out std_logic; 
		dout           : out std_logic_vector(7 downto 0);
		rst_n_regs     : buffer std_logic;
		rst_n_rx       : out std_logic;
		enable_tx_data_reg : out std_logic;
		enable_ctrl_reg    : out std_logic
     );
end component;

component Memory is
	port 
	(
		clk, rst_n : in std_logic;
		rst_rx : in std_logic;
		en_rx_full, en_err, en_tx_empty : in std_logic;
		en_rx_data, en_tx_data, en_ctrl_data : in std_logic;
		rx_data_in, tx_data_in : in std_logic_vector(7 downto 0);
		ctrl_data_in : in std_logic_vector(1 downto 0);
		rx_full_in, tx_empty_in, err_in, load: in std_logic;
		rx_data_out, tx_data_out : out std_logic_vector(7 downto 0);
		ctrl_data_out_rx, ctrl_data_out_tx : out std_logic;
		rx_full_out, tx_empty_out, err_out : out std_logic;
		load_tx : out std_logic
	);
end component;

--Rx signals
signal enable_rx, err, rx_full, en_err, en_rx_full : std_logic;
signal dato_rx : std_logic_vector(7 downto 0);

--Tx signals
signal enable_tx, tx_empty, en_tx_empty : std_logic;
signal dato_tx : std_logic_vector(7 downto 0);

--BI signals
signal reg_rx_full, reg_err, reg_tx_empty, rst_n_rx, enable_tx_data_reg, enable_ctrl_reg, rst_n_regs, load_tx, load : std_logic;
signal reg_rx_data, reg_tx_data : std_logic_vector(7 downto 0);
signal reg_ctrl_data : std_logic_vector(1 downto 0);

begin

RX_definition : RX port map (clk=>clk, rst_n=>rst_n, enable_rx=>enable_rx, err=>err, rx_full=>rx_full, en_err=>en_err, en_rx_full=>en_rx_full, dato_rx=>dato_rx, RxD=>rxd);

TX_definition : TX port map (clk=>clk, rst_n=>rst_n, enable_tx=>enable_tx, load=>load_tx, tx_empty=>tx_empty, en_tx_empty=>en_tx_empty, dato_tx=>dato_tx, TxD=>txd);

BI_definition : BI port map (clk=>clk, rst_n=>rst_n, din=>data_in, r_w_n=>R_W_N, address=>address, atn_ack=>ATN_ACK, cs=>CS, reg_rx_full=>reg_rx_full, reg_err=>reg_err, reg_tx_empty=>reg_tx_empty, en_reg_rx_full=>en_rx_full, en_reg_tx_empty=>en_tx_empty, reg_rx_data=>reg_rx_data, load=>load, reg_tx_data=>reg_tx_data, reg_ctrl_data=>reg_ctrl_data, atn=>ATN, dout=>data_out, rst_n_regs=>rst_n_regs, rst_n_rx=>rst_n_rx, enable_tx_data_reg=>enable_tx_data_reg, enable_ctrl_reg=>enable_ctrl_reg);

Memory_definition : Memory port map (clk=>clk, rst_n=>rst_n_regs, rst_rx=>rst_n_rx, en_rx_full=>en_rx_full, en_err=>en_err, en_tx_empty=>en_tx_empty, en_rx_data=>en_rx_full, en_tx_data=>enable_tx_data_reg, en_ctrl_data=>enable_ctrl_reg, rx_data_in=>dato_rx, tx_data_in=>reg_tx_data, ctrl_data_in=>reg_ctrl_data, rx_full_in=>rx_full, tx_empty_in=>tx_empty, err_in=>err, load=>load, rx_data_out=>reg_rx_data, tx_data_out=>dato_tx, ctrl_data_out_rx=>enable_rx, ctrl_data_out_tx=>enable_tx, rx_full_out=>reg_rx_full, tx_empty_out=>reg_tx_empty, err_out=>reg_err, load_tx=>load_tx);

END behaviour;