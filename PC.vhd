library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
    port (
        clk : in std_logic;
        EnablePC : in std_logic := '1';
        PCinput  : in std_logic_vector (15 downto 0) := "0000000000000000";
        PCoutput : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
end pc;

architecture behavioral of pc is
begin
    process (clk, EnablePC, PCinput)
    begin
        if (clk'Event and clk = '1') then
            if (EnablePC = '1') then
                PCoutput <= PCinput;
            end if;
        end if;
    end process;
end behavioral;