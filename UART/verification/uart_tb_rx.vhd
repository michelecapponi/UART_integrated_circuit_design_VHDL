LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY UART_TB_RX IS
END ENTITY;

ARCHITECTURE BEHAVIOUR OF UART_TB_RX IS 

COMPONENT UART IS 
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
END COMPONENT;

SIGNAL CLK, RST_N, CS, R_W_N, ATN_ACK, ATN, RXD, TXD: STD_LOGIC;
SIGNAL DATA_IN, DATA_OUT: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ADDRESS: STD_LOGIC_VECTOR(2 DOWNTO 0);

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

READ_DATA : PROCESS
BEGIN
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 540 NS; 
CS<='1';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="011";
DATA_IN<="00000011";
WAIT FOR 62.5 NS;
--RX
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 87800 NS;
CS<='1';                      
R_W_N<='1';                    --LETTURA DATO
ATN_ACK<='0';
ADDRESS<="000";
WAIT FOR 62.5 NS;
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 152649 NS;
CS<='1';                      
R_W_N<='1';                    --LETTURA DATO
ATN_ACK<='0';
ADDRESS<="000";
WAIT FOR 62.5 NS;
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 212635 NS;
CS<='1';                      
R_W_N<='1';                    --LETTURA DATO
ATN_ACK<='0';
ADDRESS<="000";
WAIT FOR 62.5 NS;
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";

WAIT FOR 2 SEC;
END PROCESS READ_DATA;

------------------------------------------------

ETICHETTA: UART PORT MAP (CLK=>CLK, RST_N=>RST_N, CS=>CS, R_W_N=>R_W_N, ATN_ACK=>ATN_ACK, DATA_IN=>DATA_IN, ADDRESS=>ADDRESS, ATN=>ATN, DATA_OUT=>DATA_OUT, RXD=>RXD, TXD=>TXD);

END BEHAVIOUR;