LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY register_entity IS
-- Declarations
port(
	D_OUT : out std_logic_vector(7 downto 0);
	D_IN : in std_logic_vector(7 downto 0);
   load : in std_logic;
   clk : in std_logic
);
  
  
END register_entity ;

--
ARCHITECTURE register_architecture OF register_entity IS
BEGIN
  process(clk) is

    begin
	 if (rising_edge(clk)) then
		if load = '1' then
		 D_OUT <= D_IN;
		end if;
    end if;
    end process;
END ARCHITECTURE register_architecture;

