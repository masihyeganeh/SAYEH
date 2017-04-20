library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
    port (
        clk : in std_logic;
        PCinput  : in std_logic_vector (15 downto 0) := "0000000000000000";
        PCoutput : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
end pc;

architecture behavioral of pc is
    signal value : std_logic_vector (15 downto 0) := "0000000000000000";
begin
    PCoutput <= value;
    process (clk, PCinput)
    begin
        if (clk'Event and clk = '1') then
            value <= PCinput;
        end if;
    end process;
end behavioral;