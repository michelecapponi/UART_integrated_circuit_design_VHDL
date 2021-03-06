LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TESTBENCH_RX IS
END ENTITY;

ARCHITECTURE BEHAVIOUR OF TESTBENCH_RX IS 

COMPONENT RX IS 
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
END COMPONENT;

SIGNAL CLK, RST_N, ENABLE_RX, RXD, RX_FULL, ERR, EN_ERR, EN_RX_FULL: STD_LOGIC;
SIGNAL DATO_RX: STD_LOGIC_VECTOR(7 DOWNTO 0);

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

ENABLE_RX_PROCESS: PROCESS
BEGIN 
ENABLE_RX<='0';
WAIT FOR 100 NS;
ENABLE_RX<='1';
WAIT FOR 2 SEC;
END PROCESS ENABLE_RX_PROCESS;

------------------------------------------------

RXD_PROCESS: PROCESS
BEGIN 
RXD<='1';
WAIT FOR 1000 NS;   --TEMPO DI IDLE

RXD<='0';          --START BIT
WAIT FOR 8680 NS;

--SEQUENZA "10101010"  (prima sequenza)
RXD<='1';          --LSB
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';          --MSB
WAIT FOR 8680 NS;


RXD<='1';          --STOP BIT
WAIT FOR 8680 NS;


RXD<='1';          --IDLE
WAIT FOR 50000 NS;
--NUOVA SEQUENZA

RXD<='0';          --START BIT
WAIT FOR 8680 NS;

--SEQUENZA "11001100"    (seconda sequenza)
RXD<='1';          --LSB
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='0';          --MSB
WAIT FOR 8680 NS;


RXD<='1';          --STOP BIT
WAIT FOR 8680 NS;

RXD<='1';          --IDLE
WAIT FOR 50000 NS;
--NUOVA SEQUENZA

RXD<='0';          --START BIT
WAIT FOR 8680 NS;

--SEQUENZA "10010011"     (terza sequenza)
RXD<='1';          --LSB
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='0';
WAIT FOR 8680 NS;
RXD<='1';
WAIT FOR 8680 NS;
RXD<='1';          --MSB
WAIT FOR 8680 NS;


RXD<='0';          --STOP BIT
WAIT FOR 8680 NS;

RXD<='1';          --IDLE
WAIT FOR 50000 NS;

--prova rumore sullo start

RXD<='0';          --STOP BIT
WAIT FOR 500 NS;


RXD<='1';          --IDLE
WAIT FOR 1 SEC;
END PROCESS RXD_PROCESS;

------------------------------------------------

ETICHETTA: RX PORT MAP (CLK=>CLK, RST_N=>RST_N, ENABLE_RX=>ENABLE_RX, RX_FULL=>RX_FULL, RXD=>RXD, DATO_RX=>DATO_RX, ERR=>ERR);

END BEHAVIOUR;