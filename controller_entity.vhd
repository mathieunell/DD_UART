--
-- VHDL Architecture PWM_GENERATOR_lib.controller_entity.controller_architecture
--
-- Created:
--          by - mathi.UNKNOWN (DESKTOP-8VPDLJ7)
--          at - 13:09:18 16-11-2018
--
-- using Mentor Graphics HDL Designer(TM) 2010.2a (Build 7)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY controller_entity IS
-- Declarations
port(
  rdy : out std_logic;
  valid : out std_logic;
  load_fnl : out std_logic;
  load_sw : out std_logic;
  rst_cntr : out std_logic;
  en_tri : out std_logic;
  
  clk : in std_logic;
  avail : in std_logic;
  init : in std_logic;
  nrst : in std_logic;
  equal : in std_logic
);
  
  
END controller_entity ;

--
ARCHITECTURE controller_architecture OF controller_entity IS
BEGIN
  process(clk, nrst, avail, init, equal) is
    variable next_state : integer RANGE 0 to 11 := 0;
    variable state : integer RANGE 0 to 11 := 0;
    begin
      
      if nrst = '1' then
        next_state := 0;
        state := 0;
        
        rdy <= '0';
        valid <= '0';
        rst_cntr <= '0';
        en_tri <= '0';
        load_sw <= '0';
        load_fnl <= '0';
		
        
        
      elsif (rising_edge(clk)) then
      state := next_state;
      end if;
      
        -- switch case of the controller 
        case state is
        
        -- State after reset
        when 0 =>
          if init = '1' then
            if avail = '1' then
              next_state := 1;
            end if;
          else
            if avail = '1' then
              next_state := 6;
            end if;  
          end if;

        when 1 =>
          load_fnl <= '1';
          next_state := 2;
            
        when 2 =>
          load_fnl <= '0';
          rdy <= '1';
          if avail = '0' AND init = '0' then
            next_state := 3;
          end if;
          
        when 3 =>
          rdy <= '0';
          
          if init = '1' then
            if avail = '1' then
              next_state := 1;
            else
              next_state := 0;
            end if; 
              
          else
            if avail = '1' then
            next_state := 4;
            end if;
          end if;
          
        when 4 =>
          load_sw <= '1';
          next_state := 5;
          
        when 5 =>
          load_sw <= '0';
          rdy <= '1';
          rst_cntr <= '1';
          
          if avail = '0' AND init = '0' then
              next_state := 11;
          end if;
          
        when 6 =>
          load_sw <= '1';
          next_state := 7;
          
        when 7 =>
          load_sw <= '0';
          rdy <= '1';
          if avail = '0' AND init = '0' then
            next_state := 8;
          end if;
          
        when 8 =>
			-- later erbij gezet
				rdy <= '0';
			
          if init = '1' then
            if avail = '1' then
              next_state := 9;           
            end if;
            
          else
            if avail = '1' then
              next_state := 6;
            else
              next_state := 0;
            end if;
          end if;
        when 9 =>
          load_fnl <= '1';
          next_state := 10;
          
        when 10 =>
          load_fnl <= '0';
          rdy <= '1';
          rst_cntr <= '1';
          
          if avail = '0' AND init = '0' then
            next_state := 11;
          end if;
        
        when 11 =>
          rdy <= '0';
          rst_cntr <= '0';
          en_tri <= '1';
          valid <= '1';
          
          if avail = '1' then
            en_tri <= '0';
            valid <= '0';
            
            if init = '1' then
              if avail = '1' then
                next_state := 9;
              else 
                next_state := 8;
              end if;
                
            else
              if avail = '1' then
                next_state := 4;
              else
                next_state := 3;
              end if;
            end if; 
          else
            if equal = '1' then
              rst_cntr <= '1';
            end if;
          end if;
          
      end case;
    
      
    end process;
END ARCHITECTURE controller_architecture;

