
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY UART_TB IS
END ENTITY;

ARCHITECTURE BEHAVIOUR OF UART_TB IS 

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
TRASMISSION_PROCESS : PROCESS
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
--trasmission
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 500 NS;
CS<='1';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="010";
DATA_IN<="10101010";
WAIT FOR 62.5 NS;
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 87150 NS;
CS<='1';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="010";
DATA_IN<="11110000";
WAIT FOR 62.5 NS;
CS<='0';
R_W_N<='0';
ATN_ACK<='0';
ADDRESS<="000";
DATA_IN<="00000000";
WAIT FOR 2 SEC;
END PROCESS TRASMISSION_PROCESS;

------------------------------------------------

ETICHETTA: UART PORT MAP (CLK=>CLK, RST_N=>RST_N, CS=>CS, R_W_N=>R_W_N, ATN_ACK=>ATN_ACK, DATA_IN=>DATA_IN, ADDRESS=>ADDRESS, ATN=>ATN, DATA_OUT=>DATA_OUT, RXD=>RXD, TXD=>TXD);

END BEHAVIOUR;