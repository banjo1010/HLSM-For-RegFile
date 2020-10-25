----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2020 06:31:19 AM
-- Design Name: 
-- Module Name: SumReg - Behavioral
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

entity SumReg is
    generic(sum_size : integer := 16);
    Port ( clk : in std_logic;
           a : in STD_LOGIC_vector(sum_size-1 downto 0);
           b : in STD_LOGIC_vector(sum_size-1 downto 0);
           load : in STD_LOGIC;
           clear : in STD_LOGIC;
           sum : out STD_LOGIC_vector(sum_size-1 downto 0)
           );
end SumReg;

architecture Behavioral of SumReg is

begin

process(clk)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                sum <= std_logic_vector(to_unsigned(0, sum_size));     
                elsif load = '1' then
                    sum <= std_logic_vector(unsigned(a) + unsigned(b));
            end if;
        end if;
    end process;
              

end Behavioral;
