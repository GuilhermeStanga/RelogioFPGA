
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.meu_pacote.all;

entity Main is
	port( input : in std_logic_vector(3 downto 0); --passar unidade | + | - | start
		mclk : in std_logic;
		pause : in std_logic;
		reset : in std_logic;
		ponto : out std_logic;
		display : out std_logic_vector(6 downto 0);
		disp_enable : out std_logic_vector(3 downto 0)
	  	
		);

end Main;
    
 
architecture logica of Main is
----------COMPONENTES-------------------

component display_sel is --responsavel por fazer a varredura dos displays
	
	port(clk_in , reset: in std_logic;
			disp_sel_out : buffer integer range 0 to 3);
end component;
----------------------------------------
component bebounce is 
	generic(count_max: integer := 250000 
				); 
	port( mclk : in std_logic; -- o clock d alta freq
			entrada : in std_logic_vector(3 downto 0)  ;
			zerar_pinos : in std_logic;
		--	pause : buffer std_logic
			output : buffer std_logic_vector(3 downto 0)
			);   
end component;
----------------------------------------
component clock_gen IS
   GENERIC(n: INTEGER := 75000);
   PORT(clk_in,enable: IN STD_LOGIC;
		  clk_out: BUFFER STD_LOGIC  );
END component;
----------------------------------------

component contador_tempo is
	port(d_segundo, reset : in std_logic;
			c1, c2, c3, c4 : out integer range 0 to 15;
			ponto : buffer std_logic;
			reset_debounce : out std_logic;
			ajuste : in std_logic_vector(3 downto 0) ;
			set : in std_logic); --ateh 15 pra conta d 0-9,
	
end component;

-----------------------------------------
component mux_4x1 is
	port(in_0, in_1, in_2, in_3 : in integer range 0 to 15;
		saida : out integer range 0 to 15;
		sel : in integer range 0 to 3 );


end component;
-----------SINAIS-------------------------------
 
signal saida_debounce : std_logic_vector(3 downto 0);
signal clock_segundo, clock_varredura : std_logic; -- 1 segndo , ainda tem q calcular
signal disp_out : integer range 0 to 15;
signal disp_select : integer range 0 to 3;
signal cO1, cO2, cO3, cO4 : integer range 0 to 15 := 0;
signal SEGUNDO : std_logic;
signal rest_deb : std_logic  ; 
  
begin   
	 
	U1: clock_gen GENERIC MAP (75000) port map (mclk,'0',clock_varredura); --0 habilita o contador
	U2 : display_sel port map(clock_varredura,'0' , disp_select );
	U3 : mux_4x1 port map(cO1, cO2, cO3, cO4,disp_out,disp_select);
	
	U4: clock_gen GENERIC MAP (25000) port map (mclk,'0',clock_segundo);--agora eh 1ms
	U5 : bebounce port map (mclk, input,rest_deb,saida_debounce ); --quando Main ajustado, setar novos valores para o contador do Main
	U6 : contador_tempo port map(clock_segundo, reset, cO1, cO2, cO3, cO4,SEGUNDO,rest_deb,saida_debounce,pause);
	
	disp_decoder(disp_out,disp_select,SEGUNDO,display,disp_enable, ponto);

end logica;