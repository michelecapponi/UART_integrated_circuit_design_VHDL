library ieee;
use ieee.std_logic_1164.all;

entity Memory is
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
end entity;

architecture behaviour of Memory is

component PIPO_8 is
	port 
		(
			data_out : out std_logic_vector(7 downto 0);
			data_in	: in std_logic_vector(7 downto 0);
			load	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

component PIPO_2 is
	port 
		(
			data_out : out std_logic_vector(1 downto 0);
			data_in	: in std_logic_vector(1 downto 0);
			load	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

component FF is
	port 
		(
			data_out : out std_logic;
			data_in	: in std_logic;
			load, reset_value	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

signal rst_signal_rx : std_logic;

begin

rst_signal_rx<=rst_n OR rst_rx;

TX_REG : PIPO_8 port map (data_in=>tx_data_in, load=>en_tx_data, clk=>clk, rst_n=>rst_n, data_out=>tx_data_out);

RX_REG : PIPO_8 port map (data_in=>rx_data_in, load=>en_rx_data, clk=>clk, rst_n=>rst_n, data_out=>rx_data_out);

CTRL_REG : PIPO_2 port map (data_in=>ctrl_data_in, load=>en_ctrl_data, clk=>clk, rst_n=>rst_n, data_out(1)=>ctrl_data_out_rx, data_out(0)=>ctrl_data_out_tx);

FF_RX_FULL : FF port map (data_in=>rx_full_in, load=>en_rx_full, reset_value=>'0', clk=>clk, rst_n=>rst_signal_rx, data_out=>rx_full_out);

FF_TX_EMPTY : FF port map (data_in=>tx_empty_in, load=>en_tx_empty,reset_value=>'1', clk=>clk, rst_n=>rst_n, data_out=>tx_empty_out);

FF_ERR : FF port map (data_in=>err_in, load=>en_err, reset_value=>'0', clk=>clk, rst_n=>rst_signal_rx, data_out=>err_out);

FF_LOAD_TX : FF port map (data_in=>load, load=>'1', reset_value=>'0', clk=>clk, rst_n=>rst_n, data_out=>load_tx);

end behaviour;