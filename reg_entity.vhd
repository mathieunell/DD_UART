LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY reg_entity IS
-- Declarations
port(
	D_IN : in std_logic_vector(7 downto 0);
   clk : in std_logic;
	load : in std_logic;
	
	D_OUT : out std_logic_vector(7 downto 0)
);
  
  
END reg_entity ;

--
ARCHITECTURE reg_architecture OF reg_entity IS
BEGIN
  process(clk) is

    begin
	 if (rising_edge(clk)) then
		if load = '1' then
		 D_OUT <= D_IN;
		end if;
    end if;
    end process;
END ARCHITECTURE reg_architecture;

