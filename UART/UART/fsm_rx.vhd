LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm_rx IS
   PORT( TC_1, TC_WAIT, TC_8, TC_16, TC_10, voter, RxD, RST_N, CLK, enable_rx : IN STD_LOGIC;
			sh_sample, sh_dato, enable_wait, enable_8, enable_10, enable_16, reset_n_datapath, rx_full, en_rx_full, en_err, err: OUT STD_LOGIC
			);
END ENTITY;

ARCHITECTURE BEHAVIOUR OF fsm_rx IS

TYPE TYPE_STATE IS (RESET, IDLE, SHIFT_SAMPLE, WAIT_16, CHECK_AND_WAIT, SHIFT_DATA, CHECK, ERROR);
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

PROCESS_STATE_UPDATE: PROCESS(PRESENT_STATE, RxD, TC_1, TC_WAIT, TC_8, TC_10, TC_16, enable_rx, VOTER)

BEGIN 

CASE PRESENT_STATE IS
   WHEN RESET => NEXT_STATE<=IDLE;
	
	WHEN IDLE => IF (RxD='0' and enable_rx='1')  THEN NEXT_STATE<=SHIFT_SAMPLE;
	  ELSE NEXT_STATE<=IDLE;
	  END IF;
	  
	WHEN SHIFT_SAMPLE => NEXT_STATE<=WAIT_16;
	 
	WHEN WAIT_16 => IF (TC_8='1' and TC_16='1') THEN NEXT_STATE<=CHECK_AND_WAIT;
	  ELSIF (TC_16='1') THEN NEXT_STATE<=SHIFT_SAMPLE;
	  ELSE NEXT_STATE<=WAIT_16;
	END IF;
	      
	WHEN CHECK_AND_WAIT => IF (TC_1='1' AND VOTER='1') THEN NEXT_STATE<=IDLE;
	ELSIF (TC_WAIT='0') THEN NEXT_STATE<=CHECK_AND_WAIT;
	  ELSE NEXT_STATE<=SHIFT_DATA;
	END IF;
	  
	WHEN SHIFT_DATA => IF (TC_10='0') THEN NEXT_STATE<=SHIFT_SAMPLE;
	  ELSE NEXT_STATE<=CHECK;
	END IF;
	  
	WHEN CHECK => IF(VOTER='1') THEN NEXT_STATE <= IDLE;
		ELSE NEXT_STATE <= ERROR;
	END IF;
		
	WHEN ERROR => NEXT_STATE <= IDLE;
	
	WHEN OTHERS => NEXT_STATE<=IDLE;
	 
END CASE;
END PROCESS PROCESS_STATE_UPDATE;

PROCESS_OUTPUT_UPDATE: PROCESS(PRESENT_STATE)

BEGIN

sh_sample<='0';
sh_dato<='0';
enable_wait<='0';
enable_8<='0';
enable_10<='0';
enable_16<='0';
reset_n_datapath<='1';
rx_full<='0';
err<='0';
en_rx_full<='0';
en_err<='0';

CASE present_state IS

WHEN RESET =>  reset_n_datapath<='0';
					 
WHEN IDLE =>	sh_sample<='0';
					sh_dato<='0';
					enable_wait<='0';
					enable_8<='0';
					enable_10<='0';
					enable_16<='0';
					reset_n_datapath<='1';
					rx_full<='0';
					err<='0';
					en_rx_full<='0';
					en_err<='0';


WHEN SHIFT_SAMPLE => sh_sample<='1';
							enable_16<='1';
							enable_8<='1';

WHEN WAIT_16 => enable_16<='1';

WHEN CHECK_AND_WAIT => enable_wait<='1';

WHEN SHIFT_DATA => sh_dato<='1';
						 enable_10<='1';
						 enable_8<='1';

WHEN CHECK =>  rx_full<='1';
					en_rx_full<='1';
					
					
WHEN ERROR =>  err<='1';
					en_err<='1';

WHEN OTHERS =>    sh_sample<='0';
						sh_dato<='0';
						enable_wait<='0';
						enable_8<='0';
						enable_10<='0';
						enable_16<='0';
						reset_n_datapath<='1';
						rx_full<='0';
						err<='0';
						en_rx_full<='0';
						en_err<='0';


END CASE;
END PROCESS PROCESS_OUTPUT_UPDATE;
END BEHAVIOUR;