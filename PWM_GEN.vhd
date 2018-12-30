-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"
-- CREATED		"Thu Nov 22 11:58:45 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY PWM_GEN IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		avail :  IN  STD_LOGIC;
		init :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		D_IN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		valid :  OUT  STD_LOGIC;
		rdy :  OUT  STD_LOGIC;
		PWM :  OUT  STD_LOGIC
	);
END PWM_GEN;

ARCHITECTURE bdf_type OF PWM_GEN IS 

COMPONENT controller_entity
	PORT(clk : IN STD_LOGIC;
		 avail : IN STD_LOGIC;
		 init : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 equal : IN STD_LOGIC;
		 rdy : OUT STD_LOGIC;
		 valid : OUT STD_LOGIC;
		 load_fnl : OUT STD_LOGIC;
		 load_sw : OUT STD_LOGIC;
		 rst_cntr : OUT STD_LOGIC;
		 en_tri : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT counter_8_entity
	PORT(clk : IN STD_LOGIC;
		 rst_cntr : IN STD_LOGIC;
		 D_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg_entity
	PORT(clk : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 D_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comparator_entity
	PORT(D_IN1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D_IN2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 equal : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	counter_value :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	enable_try :  STD_LOGIC;
SIGNAL	equal :  STD_LOGIC;
SIGNAL	final_reg_value :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	load_fnl :  STD_LOGIC;
SIGNAL	load_sw :  STD_LOGIC;
SIGNAL	reset_counter :  STD_LOGIC;
SIGNAL	switch_point_value :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;


BEGIN 



b2v_inst : controller_entity
PORT MAP(clk => clk,
		 avail => avail,
		 init => init,
		 nrst => nrst,
		 equal => equal,
		 rdy => rdy,
		 valid => valid,
		 load_fnl => load_fnl,
		 load_sw => load_sw,
		 rst_cntr => reset_counter,
		 en_tri => enable_try);


b2v_inst1 : counter_8_entity
PORT MAP(clk => clk,
		 rst_cntr => reset_counter,
		 D_OUT => counter_value);


b2v_inst2 : reg_entity
PORT MAP(clk => clk,
		 load => load_sw,
		 D_IN => D_IN,
		 D_OUT => switch_point_value);


b2v_inst3 : comparator_entity
PORT MAP(D_IN1 => counter_value,
		 D_IN2 => switch_point_value,
		 equal => SYNTHESIZED_WIRE_0);


b2v_inst4 : comparator_entity
PORT MAP(D_IN1 => final_reg_value,
		 D_IN2 => counter_value,
		 equal => equal);


b2v_inst5 : reg_entity
PORT MAP(clk => clk,
		 load => load_fnl,
		 D_IN => D_IN,
		 D_OUT => final_reg_value);


PROCESS(SYNTHESIZED_WIRE_0,enable_try)
BEGIN
if (enable_try = '1') THEN
	PWM <= SYNTHESIZED_WIRE_0;
ELSE
	PWM <= 'Z';
END IF;
END PROCESS;


END bdf_type;