LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter_8_entity IS 
port (
	clk : in std_logic;
	rst_cntr : in std_logic;
	D_OUT : out std_logic_vector(7 downto 0)
);
END counter_8_entity;

ARCHITECTURE counter_8_architecture OF counter_8_entity IS	
	signal count : std_logic_vector(7 downto 0);
BEGIN
	process(clk, rst_cntr)is
	begin
		--HOUD ER REKENING MEE DAT SIGNAL COUNT OOK TIJD NODIG
		--HEEFT OM ZIJN WAARDE OVER TE NEMEN!!
		--het volgende voorbeeld heeft bijvoorbeeld een klokslag vertraging!!!
		
		--count <= count + 1;
		--D_OUT <= count;
		
		
		
		if(rising_edge(clk)) then
			
			if count = "11111111" OR rst_cntr = '1' then 
				count <= "00000001";
			else
				--D_OUT <= count;
				count <= count + 1;
			end if;		
			
		end if;
					
	end process;
	D_OUT <= count;


END ARCHITECTURE counter_8_architecture;