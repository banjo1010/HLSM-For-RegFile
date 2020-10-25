----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2020 02:25:48 AM
-- Design Name: 
-- Module Name: REGISTER - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Reg is
    generic(reg_size: integer := 8);
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_vector(reg_size-1 downto 0);
           load : in std_logic;
           clear : in std_logic;
           q : out STD_LOGIC_vector(reg_size-1 downto 0)           
           );
end Reg;

architecture Behavioral of Reg is

begin

process(clk)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                q <= std_logic_vector(to_unsigned(0, reg_size)); 
            elsif load = '1' then 
                q <= d;
            end if;
        end if;
    end process;        
end Behavioral;
