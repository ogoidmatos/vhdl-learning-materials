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
    done: out std_logic;
    input: in std_logic;
    data: out std_logic_vector(7 downto 0)
    );
end deserializer;

architecture Behavioral of deserializer is
    type fsm_states is (s_idle, s_start, s_count, s_finish);
    signal currstate, nextstate: fsm_states;

    signal counter: std_logic_vector(2 downto 0);
    signal rdeserial: std_logic_vector(7 downto 0);
begin

    state_reg: process (clk, rst)
    begin 
        if rising_edge(clk) then
          if rst = '1' then
            currstate <= s_idle ;
          else
            currstate <= nextstate ;
          end if ;
        end if ;
    end process;
    
    state_comb: process (currstate, counter)
    begin
        nextstate <= currstate;
        
        case currstate is
            when s_idle =>
                if input='1' then
                    nextstate <= s_idle;
                else
                    nextstate <= s_start;
                end if;
                done <= '0';
            
            when s_start =>
                nextstate <= s_count;
                counter <= (others => '0');
                done <= '0';
            
            when s_count =>
                if counter = "111" then
                    nextstate <= s_finish;
                else
                    nextstate <= s_count;
                end if;
                done <= '0';
            
            when s_finish =>
                nextstate <= s_idle;
                done <= '1';
        end case;
    end process;

    count_reg: process (clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;
    
    shift_reg: process (clk)
    begin
        if rising_edge(clk) then
            if rst then
                rdeserial <= (others => '0');
            else
                rdeserial <= rdeserial(6 downto 0) & input;
            end if;
        end if;
    end process;

    data <= rdeserial when done else (others => '0');

end Behavioral;
