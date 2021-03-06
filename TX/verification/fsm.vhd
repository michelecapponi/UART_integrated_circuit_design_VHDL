LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm IS
   PORT( TC_137, TC_9, RST_N, CLK, load, enable_tx : IN STD_LOGIC;
			sh, parallel_load, enable_137, enable_9, reset_n_datapath, TX_EMPTY, en_tx_empty: OUT STD_LOGIC
			);
END ENTITY;

ARCHITECTURE BEHAVIOUR OF fsm IS

TYPE TYPE_STATE IS (RESET, IDLE, DATA_LOAD, HOLD, SHIFT, SET);
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

PROCESS_STATE_UPDATE: PROCESS(PRESENT_STATE, TC_137, TC_9, load, enable_tx)

BEGIN 

CASE PRESENT_STATE IS
   WHEN RESET => NEXT_STATE<=IDLE;
	
	WHEN IDLE => IF (LOAD='1' and enable_tx='1')  THEN NEXT_STATE<=DATA_LOAD;
	  ELSE NEXT_STATE<=IDLE;
	  END IF;
	  
	WHEN DATA_LOAD => NEXT_STATE<=HOLD;
	 
	WHEN HOLD => IF TC_137='0' THEN NEXT_STATE<=HOLD;
		ELSIF TC_9='1' THEN NEXT_STATE<=SET;
			ELSE NEXT_STATE<=SHIFT;
		--END IF;  FORSE VA TOLTO
	END IF;
	
	WHEN SET => NEXT_STATE<=IDLE;
	      
	WHEN SHIFT => NEXT_STATE<=HOLD;
	
	WHEN OTHERS => NEXT_STATE<=IDLE;
	 
END CASE;
END PROCESS PROCESS_STATE_UPDATE;

PROCESS_OUTPUT_UPDATE: PROCESS(PRESENT_STATE)

BEGIN

sh<='0';
parallel_load<='0';
enable_137<='0';
ENABLE_9<='0';
reset_n_datapath<='1';
tx_empty<='0';
en_tx_empty<='0';

CASE present_state IS

WHEN RESET =>  reset_n_datapath<='0';
					 
WHEN IDLE => 	sh<='0';
					parallel_load<='0';
					enable_137<='0';
					ENABLE_9<='0';
					tx_empty<='1';

WHEN DATA_LOAD => parallel_load<='1';
						en_tx_empty<='1';
     
WHEN HOLD=> 	enable_137<='1';

				
WHEN SET =>    en_tx_empty<='1';
					tx_empty<='1';
			ENABLE_9<='1';
			enable_137<='1';
	  
WHEN SHIFT=>  sh<='1';
			     ENABLE_9<='1';
				  

WHEN OTHERS => sh<='0';
					parallel_load<='0';
					enable_137<='0';
					ENABLE_9<='0';
					en_tx_empty<='0';

END CASE;
END PROCESS PROCESS_OUTPUT_UPDATE;
END BEHAVIOUR;  
 
 
 