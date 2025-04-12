----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2025 23:38:04
-- Design Name: 
-- Module Name: deserializer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deserializer is
    Port (
    clk, rst: in std_logic;
    en: in std_logic;
    done: out std_logic;
    input: in std_logic;
    data: out std_logic_vector(7 downto 0)
    );
end deserializer;

architecture Behavioral of deserializer is
    signal counter: std_logic_vector(2 downto 0);
    signal rdeserial: std_logic_vector(7 downto 0);
begin

    count_reg: process (clk)
    begin
        if rising_edge(clk) then
            if rst then
                counter <= (others => '0');
            elsif en then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    shift_reg: process (clk)
    begin
        if rising_edge(clk) then
            if rst then
                rdeserial <= (others => '0');
            elsif en then
                rdeserial <= rdeserial(6 downto 0) & input;
            end if;
        end if;
    end process;

    done <= and counter;
    data <= rdeserial when done else (others => '0');

end Behavioral;
