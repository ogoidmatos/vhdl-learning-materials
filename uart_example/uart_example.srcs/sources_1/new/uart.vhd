----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2025 22:49:52
-- Design Name: 
-- Module Name: uart - Behavioral
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

entity uart is
    Port (
        clk, rst: in std_logic;
        ld, en: in std_logic;
        data: in std_logic_vector (7 downto 0)
    );
end uart;

architecture Behavioral of uart is
    signal rserial: std_logic_vector(7 downto 0);
begin

serializer: process (clk)
begin
    if rising_edge(clk) then
        if rst then
            rserial <= (others => '0');
        elsif ld then
            rserial <= data;
        elsif en then
            rserial <= rserial(6 downto 0) & '0';
        end if;
    end if;    
end process;

end Behavioral;
