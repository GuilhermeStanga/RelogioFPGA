
--bebounce da varredura display, gerador d clock para varredura

--Tvar = 3ms

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity display_sel is
	
	port(clk_in , reset: in std_logic;
		disp_sel_out : buffer integer range 0 to 3
		);

end display_sel;

architecture logica of display_sel is

begin

	process(clk_in,reset)
		variable count : integer range 0 to 3 := 0;
	begin
		if(reset = '1')then
			count := 0;
		elsif(clk_in'EVENT and clk_in = '1') then
			if(count >= 3) then
				count :=0;
				
			else
				count := count +1;
			end if;
		end if;
		disp_sel_out <= count;
		
	end process;
end logica;