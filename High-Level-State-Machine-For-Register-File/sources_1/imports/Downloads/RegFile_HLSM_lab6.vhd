----------------------------------------------------------------------------------
-- Company: 		Binghamton University
-- Engineer:		
-- 
-- Create Date:     10/11/2014 
-- Design Name:     HLSM for Register File
-- Module Name:     RegFile_HLSM - Behavioral 
-- Project Name:    Lab6
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegFile_HLSM is
	PORT( clk : STD_LOGIC;
		  btn0 : STD_LOGIC;
		  btn1 : STD_LOGIC;
		  btn2 : STD_LOGIC;
		  Switch : in  STD_LOGIC_VECTOR (7 downto 0);
		  HexDisp : out  STD_LOGIC_VECTOR (15 downto 0);
		  W_Addr : out STD_LOGIC_VECTOR (3 downto 0); 
		  R_Addr : out STD_LOGIC_VECTOR (3 downto 0));
end RegFile_HLSM;

architecture Behavioral of RegFile_HLSM is

	-- Declare datapath component
    component DATAPATH is 
        generic (hex_size : integer := 16;
                input_size : integer := 8;
                addr_size : integer := 4
                );
        Port ( 
            clk : in std_logic;
            Switch : in STD_LOGIC_vector(input_size-1 downto 0);
            W_en: in std_logic;
            clear_regfile: in std_logic;
            load_wreg: in std_logic;
            clear_wreg: in std_logic;
            load_rreg: in std_logic;
            increment_rreg: in std_logic;
            clear_rreg: in std_logic;
            rar_eq15: out std_logic;
            rar_lt15: out std_logic;
            load_sumreg: in std_logic;
            clear_sumreg: in std_logic;
            load_hexdisp: in std_logic;
            clear_hexdisp: in std_logic;
            concat_hexdisp: in std_logic;
            HexDisp : out STD_LOGIC_vector(hex_size-1 downto 0);
            W_Addr : out STD_LOGIC_vector(addr_size-1 downto 0);
            R_Addr : out STD_LOGIC_vector(addr_size-1 downto 0)           
            );
    end component DATAPATH;

	-- Declare controller component
    component CONTROLLER is
        Port (
            btn0: in std_logic; 
            btn1: in std_logic;
            btn2: in std_logic;
            clk: in std_logic;
            W_en: out std_logic;
            clear_regfile: out std_logic;
            load_wreg: out std_logic;
            clear_wreg: out std_logic;
            load_rreg: out std_logic;
            increment_rreg: out std_logic;
            clear_rreg: out std_logic;
            rar_eq15: in std_logic;
            rar_lt15: in std_logic;
            load_sumreg: out std_logic;
            clear_sumreg: out std_logic;
            load_hexdisp: out std_logic;
            clear_hexdisp: out std_logic;
            concat_hexdisp: out std_logic
            );
    end component CONTROLLER;

	-- Signals for interconnections between datapath and controller
    signal W_en, clear_regfile, load_wreg, clear_wreg, load_rreg, increment_rreg: std_logic; 
	signal clear_rreg, rar_eq15, rar_lt15, load_sumreg, clear_sumreg, load_hexdisp, clear_hexdisp, concat_hexdisp: std_logic;
begin

	-- Instantiate Datapath Module
    datapath1: DATAPATH
        generic map(hex_size => 16,
                input_size => 8,
                addr_size => 4
                )
        Port map( 
            clk => clk,
            Switch => Switch(7 downto 0),
            W_en => W_en,
            clear_regfile => clear_regfile,
            load_wreg => load_wreg,
            clear_wreg => clear_wreg,
            load_rreg => load_rreg,
            increment_rreg => increment_rreg,
            clear_rreg => clear_rreg,
            rar_eq15 => rar_eq15,
            rar_lt15 => rar_lt15,
            load_sumreg => load_sumreg,
            clear_sumreg => clear_sumreg,
            load_hexdisp => load_hexdisp,
            clear_hexdisp => clear_hexdisp,
            concat_hexdisp => concat_hexdisp,
            HexDisp => HexDisp,
            W_Addr => W_Addr,
            R_Addr => R_Addr         
            );

	-- Instantiate Controller Module
    controller1: CONTROLLER
        port map (
            btn0 => btn0,
            btn1 => btn1,
            btn2 => btn2,
            clk => clk,
            W_en => W_en,
            clear_regfile => clear_regfile,
            load_wreg => load_wreg,
            clear_wreg => clear_wreg,
            load_rreg => load_rreg,
            increment_rreg => increment_rreg,
            clear_rreg => clear_rreg,
            rar_eq15 => rar_eq15,
            rar_lt15 => rar_lt15,
            load_sumreg => load_sumreg,
            clear_sumreg => clear_sumreg,
            load_hexdisp => load_hexdisp,
            clear_hexdisp => clear_hexdisp,
            concat_hexdisp => concat_hexdisp        
        );

end Behavioral;
