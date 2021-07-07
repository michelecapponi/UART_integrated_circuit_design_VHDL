library ieee;
use ieee.std_logic_1164.all;

entity Memory is
	port 
	(
		clk, rst_n : in std_logic;
		rst_rx, rst_tx_data, rst_rx_data, rst_ctrl_data : in std_logic;
		en_rx_full, en_err, en_tx_empty : in std_logic;
		en_rx_data, en_tx_data, en_ctrl_data : in std_logic;
		rx_data_in, tx_data_in : in std_logic_vector(7 downto 0);
		ctrl_data_in : in std_logic_vector(1 downto 0);
		rx_full_in, tx_empty_in, err_in : in std_logic;
		rx_data_out, tx_data_out : out std_logic_vector(7 downto 0);
		ctrl_data_out : out std_logic_vector(1 downto 0);
		rx_full_out, tx_empty_out, err_out : out std_logic
	);

end entity;

architecture behaviour of Memory is

component PIPO_8 is
	port 
		(
			p_out : out std_logic_vector(7 downto 0);
			sr_in	: in std_logic_vector(7 downto 0);
			load	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

component PIPO_2 is
	port 
		(
			p_out : out std_logic_vector(1 downto 0);
			sr_in	: in std_logic_vector(1 downto 0);
			load	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

component FF is
	port 
		(
			p_out : out std_logic;
			sr_in	: in std_logic;
			load	: in std_logic;
			clk, rst_n : in std_logic
		);
end component;

begin

TX_REG : PIPO_8 port map (sr_in=>tx_data_in, load=>en_tx_data, clk=>clk, rst_n=>rst_n, p_out=>tx_data_out);

RX_REG : PIPO_8 port map (sr_in=>rx_data_in, load=>en_rx_data, clk=>clk, rst_n=>rst_n, p_out=>rx_data_out);

CTRL_REG : PIPO_2 port map (sr_in=>ctrl_data_in, load=>en_rx_data, clk=>clk, rst_n=>rst_n, p_out=>ctrl_data_out);

FF_RX_FULL : FF port map (sr_in=>rx_full_in, load=>en_rx_full, clk=>clk, rst_n=>rst_n, p_out=>rx_full_out);

FF_TX_FULL : FF port map (sr_in=>tx_empty_in, load=>en_tx_empty, clk=>clk, rst_n=>rst_n, p_out=>tx_empty_out);

FF_ERR : FF port map (sr_in=>err_in, load=>en_err, clk=>clk, rst_n=>rst_n, p_out=>err_out);

end behaviour;