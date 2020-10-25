----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2020 02:28:13 PM
-- Design Name: 
-- Module Name: RegFile - Behavioral
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

entity RegFile is
    generic (word_size : natural := 8;
        address_size : natural := 4 );
    port (clk : in std_logic;
        W_en : in std_logic;
        W_addr : in std_logic_vector(address_size-1 downto 0);
        R_addr : in std_logic_vector(address_size-1 downto 0);
        W_data : in std_logic_vector(word_size-1 downto 0);
        W_data_out : out std_logic_vector(word_size-1 downto 0);
        R_data_out : out std_logic_vector(word_size-1 downto 0)
        );
end RegFile;

architecture Behavior of RegFile is
    type RegFile_type is array (0 to 2**address_size-1) of
    std_logic_vector (word_size-1 downto 0);
    signal RegFile : RegFile_type;
begin

process (clk)
    begin
        if rising_edge(clk) then
            if (W_en = '1') then
                RegFile(to_integer(unsigned(W_addr))) <= W_data;
            end if;
        end if;
end process;

W_data_out <= RegFile(to_integer(unsigned(W_addr)));
R_data_out <= RegFile(to_integer(unsigned(R_addr)));
end Behavior;

