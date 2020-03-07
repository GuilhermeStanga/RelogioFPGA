--mux 4x1 pro bebounce, nao dah pra chama ele dentro de um process

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_4x1 is
	port(in_0, in_1, in_2, in_3 : in integer range 0 to 15;
		saida : out integer range 0 to 15;
		sel : in integer range 0 to 3 
		);
end mux_4x1;

architecture logica of mux_4x1 is

begin

	with sel select
		saida <= in_0 when 0,
					in_1 when 1,
					in_2 when 2,
					in_3 when others;

end logica;



