
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package meu_pacote is

procedure disp_decoder(signal inp_BCD: in integer range 0 to 15 ;
									signal disp_sel : in integer range 0 to 3;
									signal SEGUNDO : in STD_LOGIC;
									signal disp_out : out std_logic_vector(6 downto 0);
									signal disp_en_out : out std_logic_vector (3 downto 0 );
									signal ponto : out std_logic );



end meu_pacote;

package body meu_pacote is

	
	procedure disp_decoder(signal inp_BCD: in integer range 0 to 15 ;
									signal disp_sel : in integer range 0 to 3;
									signal SEGUNDO : in STD_LOGIC;
									signal disp_out : out std_logic_vector(6 downto 0);
									signal disp_en_out : out std_logic_vector (3 downto 0 ) ;
									signal ponto : out std_logic) is
									
	BEGIN
	
		CASE inp_BCD IS 
				WHEN 0 => disp_out <= "1000000";
				WHEN 1 => disp_out <= "1111001";
				WHEN 2 => disp_out <= "0100100";
				WHEN 3 => disp_out <= "0110000";
				WHEN 4 => disp_out <= "0011001";
				WHEN 5 => disp_out <= "0010010";
				WHEN 6 => disp_out <= "0000010";
				WHEN 7 => disp_out <= "1111000";
				WHEN 8 => disp_out <= "0000000";
				WHEN 9 => disp_out <= "0010000";
				WHEN 10 => disp_out <= "0001000";
				WHEN 11 => disp_out <= "0000011";
				WHEN 12 => disp_out <= "1000110";
				WHEN 13 => disp_out <= "0100001";
				WHEN 14 => disp_out <= "0000110";
				WHEN OTHERS => disp_out <= "0001110";
		END CASE;
	
		case disp_sel is
				when 0 => disp_en_out <= "1110";
				when 1 => disp_en_out <= "1101";
				when 2 => disp_en_out <= "1011";
				when others => disp_en_out <= "0111";
	
		end case;
		
		if (disp_sel = 0 ) then
			ponto <= SEGUNDO;
		else ponto <= '1';
		end if;
	
	end disp_decoder;
	
end meu_pacote;
