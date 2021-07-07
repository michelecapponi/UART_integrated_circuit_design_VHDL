LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm_bi IS
   PORT( clk        : in std_logic;
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
			rst_n_regs : out std_logic;
			rst_n_rx   : out std_logic;
			enable_tx_data_reg : out std_logic;
			enable_ctrl_reg    : out std_logic;
			sel		          : out std_logic
			);
END ENTITY;

ARCHITECTURE BEHAVIOUR OF fsm_bi IS

TYPE TYPE_STATE IS (RESET, IDLE, READ_DATA, READ_STATUS, WRITE_DATA, WRITE_CTRL, ATTENTION, CHECK_VAR_STATUS);
SIGNAL PRESENT_STATE, NEXT_STATE: TYPE_STATE;

BEGIN

PROCESS_CLOCK : PROCESS(CLK, RST_N)
BEGIN
   IF (RST_N='0') THEN
     	PRESENT_STATE<=RESET;
   ELSIF (CLK'EVENT AND CLK='1') THEN 	    
	    PRESENT_STATE<=NEXT_STATE;
	END IF;
 END PROCESS PROCESS_CLOCK;

PROCESS_STATE_UPDATE: PROCESS(PRESENT_STATE, CS, ADDRESS, R_W_N, ATN_ACK, EN_RX_FULL, EN_TX_EMPTY, TX_EMPTY, RX_FULL)

BEGIN 

CASE PRESENT_STATE IS
   WHEN RESET => NEXT_STATE<=IDLE;
	
	WHEN IDLE => 
		IF    (CS='1' AND R_W_N='1' AND ADDRESS="000") THEN NEXT_STATE<=READ_DATA;
		ELSIF (CS='1' AND R_W_N='1' AND ADDRESS="001") THEN NEXT_STATE<=READ_STATUS;
		ELSIF (CS='1' AND R_W_N='0' AND ADDRESS="010") THEN NEXT_STATE<=WRITE_DATA;
		ELSIF (CS='1' AND R_W_N='0' AND ADDRESS="011") THEN NEXT_STATE<=WRITE_CTRL;
		ELSIF (EN_RX_FULL='1' OR EN_TX_EMPTY='1') THEN NEXT_STATE<=CHECK_VAR_STATUS;
		ELSE NEXT_STATE<=IDLE;
	END IF;
	  
	WHEN READ_DATA => NEXT_STATE <= IDLE;
	
	WHEN READ_STATUS => NEXT_STATE <= IDLE;
	
	WHEN WRITE_DATA => NEXT_STATE <= IDLE;
	
	WHEN WRITE_CTRL => NEXT_STATE <= IDLE;
	
	WHEN CHECK_VAR_STATUS =>
	IF(TX_EMPTY='1' OR RX_FULL='1') THEN NEXT_STATE <= ATTENTION;
	ELSE NEXT_STATE <= IDLE;
	END IF;
	
	WHEN ATTENTION =>
	IF(ATN_ACK='1') THEN NEXT_STATE <= IDLE;
	   ELSIF (CS='1' AND R_W_N='1' AND ADDRESS="000") THEN NEXT_STATE<=READ_DATA;
		ELSIF (CS='1' AND R_W_N='1' AND ADDRESS="001") THEN NEXT_STATE<=READ_STATUS;
		ELSIF (CS='1' AND R_W_N='0' AND ADDRESS="010") THEN NEXT_STATE<=WRITE_DATA;
		ELSIF (CS='1' AND R_W_N='0' AND ADDRESS="011") THEN NEXT_STATE<=WRITE_CTRL;
		ELSE NEXT_STATE <= ATTENTION;
	END IF;
	
	WHEN OTHERS => NEXT_STATE<=IDLE;
	 
END CASE;
END PROCESS PROCESS_STATE_UPDATE;

PROCESS_OUTPUT_UPDATE: PROCESS(PRESENT_STATE)

BEGIN

atn<='0';	  
rst_n_regs<='1';
rst_n_rx<='1';
enable_tx_data_reg<='0';
enable_ctrl_reg<='0';
sel<='0';

CASE present_state IS

WHEN RESET =>  rst_n_regs<='0';
					rst_n_rx<='0';
					 
WHEN IDLE => 	atn<='0';	  
					rst_n_regs<='1';
					rst_n_rx<='1';
					enable_tx_data_reg<='0';
					enable_ctrl_reg<='0';
					sel<='0';

WHEN READ_DATA => sel<='1';
						rst_n_rx<='0';
     
WHEN READ_STATUS => sel<='0';
	
WHEN WRITE_DATA => enable_tx_data_reg<='1';
					
WHEN WRITE_CTRL => enable_ctrl_reg<='1';

WHEN ATTENTION => atn<='1';

WHEN CHECK_VAR_STATUS => 	atn<='0';	  
									rst_n_regs<='1';
									rst_n_rx<='1';
									enable_tx_data_reg<='0';
									enable_ctrl_reg<='0';
									sel<='0';

WHEN OTHERS => atn<='0';	  
					rst_n_regs<='1';
					rst_n_rx<='1';
					enable_tx_data_reg<='0';
					enable_ctrl_reg<='0';
					sel<='0';

END CASE;
END PROCESS PROCESS_OUTPUT_UPDATE;
END BEHAVIOUR;