LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TESTBENCH IS
END ENTITY;

ARCHITECTURE BEHAVIOUR OF TESTBENCH IS 

COMPONENT TX IS 
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
END COMPONENT;

SIGNAL CLK, RST_N, ENABLE_TX, LOAD, TX_EMPTY, EN_TX_EMPTY, TXD: STD_LOGIC;
SIGNAL DATO_TX: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
----------------------------------------------

CLOCK_PROCESS : PROCESS 
BEGIN
CLK <= '1';
WAIT FOR 31.25 NS;
CLK <= '0';
WAIT FOR 31.25 NS;
END PROCESS CLOCK_PROCESS;

----------------------------------------------

RST_PROCESS : PROCESS 
BEGIN
RST_N <= '0';
WAIT FOR 100 NS;
RST_N <= '1';
WAIT FOR 2 SEC;
END PROCESS RST_PROCESS;

------------------------------------------------

ENABLE_TX_PROCESS: PROCESS
BEGIN 
ENABLE_TX<='0';
WAIT FOR 100 NS;
ENABLE_TX<='1';
WAIT FOR 2 SEC;
END PROCESS ENABLE_TX_PROCESS;

------------------------------------------------

LOAD_PROCESS: PROCESS
BEGIN 
LOAD<='0';
WAIT FOR 140 NS;
LOAD<='1'; 		 --PRIMA TRASMISSIONE
WAIT FOR 62.5 NS;
LOAD<='0';
WAIT FOR 100062.5 NS;
LOAD<='1'; 		 --SECONDA TRASMISSIONE 10265
WAIT FOR 62.5 NS;
LOAD<='0';
WAIT FOR 2 SEC;
END PROCESS LOAD_PROCESS;

------------------------------------------------

DATO_TX_PROCESS: PROCESS
BEGIN 
DATO_TX<="00000000";
WAIT FOR 140 NS;
DATO_TX<="10101010";  --PRIMA TRASMISSIONE
WAIT FOR 125 NS;
DATO_TX<="00000000";
WAIT FOR 100000 NS;
DATO_TX<="10101010";  --SECONDA TRASMISSIONE  10265
WAIT FOR 125 NS;
DATO_TX<="00000000";
WAIT FOR 2 SEC;
END PROCESS DATO_TX_PROCESS;

------------------------------------------------

ETICHETTA: TX PORT MAP (CLK=>CLK, RST_N=>RST_N, ENABLE_TX=>ENABLE_TX, LOAD=>LOAD, TX_EMPTY=>TX_EMPTY, DATO_TX=>DATO_TX, TXD=>TXD);

END BEHAVIOUR;