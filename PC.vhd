library IEEE;
use IEEE.std_logic_1164.all;

entity ProgramCounter is
    port (
        clk, EnablePC : in std_logic;
        input  : in std_logic_vector (15 downto 0);
        output : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
end ProgramCounter;

architecture dataflow of ProgramCounter is
begin
    process (clk)
    begin
        if (clk'Event and clk = '1') then
            if (EnablePC = '1') then
                output <= input;
            end if;
        end if;
    end process;
end dataflow;