----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2020 01:30:19 AM
-- Design Name: 
-- Module Name: DATAPATH - Behavioral
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

entity DATAPATH is
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
end DATAPATH;

architecture Behavioral of DATAPATH is


signal muxhexdisp, sumreg1, b1 : std_logic_vector(hex_size-1 downto 0);
signal W_addr1, R_addr1, mux_rreg : std_logic_vector(addr_size-1 downto 0);
signal w_data_out, r_data_out : std_logic_vector(input_size-1 downto 0);

component Reg is
    generic (reg_size: integer := 8);
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_vector(reg_size-1 downto 0);
           load : in std_logic;
           clear : in std_logic;
           q : out STD_LOGIC_vector(reg_size-1 downto 0)           
           );
    end component Reg;

component RegFile is
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
    end component RegFile;

component SumReg is
    generic(sum_size : integer := 16);
    Port ( clk : in std_logic;
           a : in STD_LOGIC_vector(sum_size-1 downto 0);
           b : in STD_LOGIC_vector(sum_size-1 downto 0);
           load : in STD_LOGIC;
           clear : in STD_LOGIC;
           sum : out STD_LOGIC_vector(sum_size-1 downto 0)
           );
    end component SumReg;        
        

begin

W_Addr <= W_addr1;
R_Addr <= R_addr1;

loading_wreg: Reg
    generic map (reg_size => addr_size)
    port map ( 
        clk => clk,
        d => Switch(7 downto 4),
        load => load_wreg,
        clear => clear_wreg,
        q => W_addr1           
        );

loading_rreg: Reg
    generic map (reg_size => addr_size)
    port map ( 
        clk => clk,
        d => mux_rreg,
        load => load_rreg,
        clear => clear_rreg,
        q => R_addr1           
        );
        
writing_data: RegFile
    generic map (word_size => input_size, address_size => addr_size)
    port map (
        clk => clk,
        W_en => W_en,
        W_Addr => W_addr1,
        R_Addr => R_addr1,
        W_data => Switch(7 downto 0),
        W_data_out => w_data_out,
        R_data_out => r_data_out        
        );

muxhexdisp <= w_data_out & r_data_out when concat_hexdisp = '1' else sumreg1;

loading_hexdisp: Reg
    generic map (reg_size => hex_size)
    port map ( 
        clk => clk,
        d => muxhexdisp,
        load => load_hexdisp,
        clear => clear_hexdisp,
        q => Hexdisp
        );

mux_rreg <= std_logic_vector(unsigned(R_addr1) + 1)  when increment_rreg = '1' else Switch(3 downto 0);      
rar_eq15 <= '1' when unsigned(R_addr1) = 15 else '0';
rar_lt15 <= '1' when unsigned(R_addr1) < 15 else '0';


b1 <= std_logic_vector(resize(unsigned(r_data_out), 16));

loading_sumreg: SumReg
    generic map (sum_size => hex_size)
    Port map ( 
            clk => clk,
            a => sumreg1,
            b => b1,
            load => load_sumreg,
            clear => clear_sumreg,
            sum => sumreg1
            );


end Behavioral;
