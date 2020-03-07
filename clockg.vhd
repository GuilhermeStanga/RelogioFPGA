
--bebounce da varredura display, gerador d clock para varredura
--Tvar = 3ms

library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY clock_gen IS
   GENERIC(n: INTEGER := 75000);
   PORT(clk_in, enable: IN STD_LOGIC;
		clk_out: BUFFER STD_LOGIC  
		);
END clock_gen;

ARCHITECTURE logica OF clock_gen IS

BEGIN

	PROCESS(clk_in) 
		VARIABLE count: INTEGER RANGE 0 TO n := 0;
	BEGIN
	
		IF(clk_in'EVENT AND clk_in = '1') THEN
			if(enable = '0') then --0 habilita o contador
				IF( count = n ) THEN
					count := 0;
					clk_out <= clk_out XOR '1';
				ELSE
					count := count + 1;
				END IF;
			end if;
		END IF;
	END PROCESS;
	
END logica;