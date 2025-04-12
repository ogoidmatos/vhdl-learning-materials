----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2025 23:09:26
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component serializer
    port(
        clk, rst: in std_logic;
        ld, en: in std_logic;
        data: in std_logic_vector (7 downto 0);
        output: out std_logic
        );
    end component;
    
    component deserializer
    port (
        clk, rst: in std_logic;
        en: in std_logic;
        done: out std_logic;
        input: in std_logic;
        data: out std_logic_vector(7 downto 0)
        );
    end component;
        
    
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ld: std_logic := '0';
   signal en: std_logic := '0';
   
   signal connection: std_logic;
   
   signal data: std_logic_vector(7 downto 0);
   signal output: std_logic_vector(7 downto 0);
   signal done: std_logic;
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
    uut: serializer port map(
        clk => clk,
        rst => rst,
        ld => ld,
        en => en,
        data => data,
        output => connection
        );
   
    uut_de: deserializer port map(
        clk => clk,
        rst => rst,
        en => en,
        input => connection,
        data => output,
        done => done
        );
    
    -- Clock definition
    clk <= not clk after clk_period/2;
   
    stim: process
    begin
        wait for 100ns;
        
        wait for clk_period*10;
        
        rst <= '1' after 20ns, '0' after 40ns;
        data <= "10101010" after 40ns, "10000001" after 240ns;
        ld <= '1' after 40ns, '0' after 50ns, '1' after 240ns, '0' after 250ns;
        
        en <= '1' after 40ns, '0' after 120ns, '1' after 240ns, '0' after 320ns;
        
        wait;
        
    end process;

end Behavioral;
