
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity contador_tempo is
	port(d_segundo, reset : in std_logic;
		c1, c2, c3, c4 : buffer integer range 0 to 15;
		ponto : buffer std_logic;
		reset_debounce : out std_logic; -- para dar borda de descida e fazer com que ele pare de add valores
		ajuste : in std_logic_vector(3 downto 0);
		set : in std_logic
		); --ateh 15 pra conta d 0-9,
	
end contador_tempo;

architecture logica of contador_tempo is
	
	shared variable m_u, m_d, h_u, h_d: integer range 0 to 15 ;

begin
	process(d_segundo,reset,set,ajuste)
		variable p : std_logic;
		variable segundo : integer range 0 to 59999 := 0 ;
		variable mili : integer range 0 to 1000;
	begin
		if(reset = '1') then
			m_u := 0;
			m_d := 0;
			h_u := 0;
			h_d := 0 ;
			p := '0';
			segundo := 0;

		elsif(d_segundo'EVENT and d_segundo = '1' ) then
			
			
			if(set = '1')then
				if(mili = 5)then
					mili := 0 ;		
					case ajuste is
						when "0001" =>
							if(m_u = 9) then
								m_u := 0;
							else
								m_u := m_u + 1 ;
							end if;	
							reset_debounce <= '1';
						when "0010" =>
							if(m_d = 5) then
								m_d := 0;
							else
								m_d := m_d + 1 ;
							end if;
							reset_debounce <= '1';
						when "0100" =>
							if(h_u = 9 or (h_d = 2 and h_u = 3)) then
								h_u := 0;
							else
								h_u := h_u + 1 ;
							end if;
							reset_debounce <= '1';
						when "1000" =>
							if(h_d = 2) then
								h_d := 0;
							else
								h_d := h_d + 1 ;
							end if;
							reset_debounce <= '1';
						when others => reset_debounce <= '0';	
					end case;
				else mili := mili + 1;
				end if;
				
			else	
					
					mili := mili + 1;
					if(mili = 999)then
						p := ponto xor '1';
						segundo := segundo + 1;
					elsif(segundo = 60   ) then
						
						segundo := 0;
						m_u := m_u + 1;
					elsif(m_u = 10  ) then
						m_u := 0;
						m_d := m_d + 1;
					elsif(m_d = 6  ) then
							m_d := 0;
							h_u := h_u + 1;
					elsif(h_u = 10 ) then
						h_u := 0;
						h_d := h_d + 1;
					elsif(h_d = 2 and  h_u = 4 ) then
						m_u := 0;
						m_d := 0;
						h_u := 0 ;
						h_d := 0 ;
						p := '0';
						segundo := 0;
					 
					end if;
				end if;
			end if;
		c1 <= m_u;
		c2 <= m_d;
		c3 <= h_u;
		c4 <= h_d;
		ponto <= p;
	end process;

end logica;