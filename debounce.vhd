library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bebounce is
	generic(count_max: integer := 250000 
				); 
	port( mclk : in std_logic; -- o clock d alta freq
		entrada : in std_logic_vector(3 downto 0)  ;
		zerar_pinos : in std_logic;
		output : buffer std_logic_vector(3 downto 0) 
		); 
end bebounce;

architecture logica of bebounce is

signal y : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;
signal  counter_clear , counter_out: std_logic := '0' ;

begin
		--contador
	process(mclk,counter_clear)
		variable counter : integer range 0 to 12500 :=0;
	begin
		if(counter_clear = '1' )then
			counter := 0 ;
		elsif(mclk'EVENT AND  mclk = '1') then
			if(counter = 12500) then
				counter :=0;
				counter_out <= '1';
			else
				counter := counter +1;
				counter_out <= '0';
			end if;
			
		end if;
	end process;
	
	-------------------------------------------------
	--deteccao de mudanca nos pinos
	process(mclk)
	
	begin
		if(mclk'event and mclk = '1') then
			if(entrada(0) /= y(0)) then
				if(counter_out = '1' ) then
					counter_clear <= '1';
					y(0) <= entrada(0);
				else counter_clear <= '0';
				end if;
			elsif(entrada(1) /= y(1)) then
				if(counter_out = '1' ) then
					counter_clear <= '1';
					y(1) <= entrada(1);
				else counter_clear <= '0';
				end if;
			elsif(entrada(2) /= y(2)) then
				if(counter_out = '1' ) then
					counter_clear <= '1';
					y(2) <= entrada(2);
				else counter_clear <= '0';
				end if;
			elsif(entrada(3) /= y(3)) then
				if(counter_out = '1' ) then
					counter_clear <= '1';
					y(3) <= entrada(3);
				else counter_clear <= '0';
				end if;
			end if;
		end if;
	end process;
		
	--------------------------
	--ff tipo T, detecta borda de descida
		 
	process(y(0),zerar_pinos) --passar display- desisti desse jeito
		variable qual_display : integer range 0 to 3;
	BEGIN
		if(zerar_pinos = '1')then
			output(0) <= '0';
		
		elsIF (y(0)'EVENT AND y(0)='0') THEN
			output(0) <= output(0) xor '1';
		end if;
	end process;
		
	-----------------------------------------
	process(y(1),zerar_pinos)	-- + 
	BEGIN
		if(zerar_pinos = '1')then
			output(1) <= '0';
		elsIF (y(1)'EVENT AND y(1)='0') THEN
			output(1) <= output(1) xor '1';
		
		end if;
	end process;
	-------------------------------------------		process(y(3))
	process(y(2),zerar_pinos) -- - 
	BEGIN
		if(zerar_pinos = '1')then
			output(2) <= '0';
		elsIF (y(2)'EVENT AND y(2)='0') THEN
				output(2) <= output(2) xor '1';	
		end if;
	end process;		
	--------------------------------------------
	process(y(3),zerar_pinos)
	BEGIN
	if(zerar_pinos = '1')then
			output(3) <= '0';
	elsIF (y(3)'EVENT AND y(3)='0') THEN
			output(3) <= output(3) xor '1';	
		end if;
	end process;
	--primeira tentativa com botoes para setar e diminui, mas dav erro para diminuir e erro de default nos contadores

end logica;