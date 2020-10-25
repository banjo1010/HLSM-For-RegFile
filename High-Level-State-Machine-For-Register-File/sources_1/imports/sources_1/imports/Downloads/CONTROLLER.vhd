----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2020 01:51:24 PM
-- Design Name: 
-- Module Name: CONTROLLER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROLLER is
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
end CONTROLLER;

architecture Behavioral of CONTROLLER is
    type state_type is (idle, ld_addr_reg, write_data, disp_regfile, disp_sum, sum, wait1, init_sum);
    signal state, next_state: state_type:= idle;
begin
    -- register component 
    process(clk)
    begin 
        if rising_edge(clk) then 
            state <= next_state;
        end if;
    end process;
    -- hlsm
    process(state, btn0, btn1, btn2)
    begin
        W_en <= '0';
        clear_regfile <= '0';
        load_wreg <= '0';
        clear_wreg <= '0';
        load_rreg <= '0';
        increment_rreg <= '0';
        clear_rreg <= '0';
        load_sumreg <= '0';
        clear_sumreg <= '0';
        load_hexdisp <= '0';
        clear_hexdisp <= '0';
        concat_hexdisp<= '0';
        
        case state is 
            when idle=>
                if btn0 = '1' then
                    next_state <= ld_addr_reg;
                elsif btn1 = '1' then 
                    next_state <= write_data;
                elsif btn2 = '1' then
                    next_state <= init_sum;
                else
                    next_state <= idle;
                end if;
           
            when ld_addr_reg =>
                load_wreg <= '1';
                load_rreg <= '1';
                increment_rreg <= '0';
                next_state <= disp_regfile;
            
            when write_data =>
                W_en <= '1';
                next_state <= disp_regfile;
            
            when disp_regfile =>
                load_hexdisp <= '1';
                concat_hexdisp <= '1';
                next_state <= idle;
            
            when disp_sum =>
                load_hexdisp <= '1';
                concat_hexdisp <= '0';
                if btn2 = '0' then
                    next_state <= disp_sum;
                    elsif btn2 = '1' then
                        next_state <= idle;
                end if;
            
            when sum => 
                load_sumreg <= '1';
                load_rreg <= '1';
                increment_rreg <= '1';
                if rar_eq15 = '1' then
                    next_state <= disp_sum;
                    else 
                        next_state <= wait1;
                        
                end if;
            
            when wait1 =>
                next_state <= sum;
            
            when init_sum =>
                clear_rreg <= '1';
                clear_sumreg <= '1';
                next_state <= wait1;    
                
         end case;
    end process;
end Behavioral;
