LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY comparator_entity IS 

port(
	D_IN1 : in std_logic_vector(7 downto 0);
	
	D_IN2 : in std_logic_vector(7 downto 0);
	
	equal : out std_logic
	);
	
END comparator_entity;

ARCHITECTURE comparator_architecture OF comparator_entity IS 
BEGIN 
	process(D_IN1, D_IN2) is
	begin
	
		if D_IN1 <= D_IN2 then 
			equal <= '1';
		else
			equal <= '0';
		end if;
	
	end process; 
END ARCHITECTURE comparator_architecture; 