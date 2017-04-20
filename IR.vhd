library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IR is
    port (
        clk     : in std_logic;
        IRload  : in std_logic := '0';
        Databus : in std_logic_vector (15 downto 0) := "0000000000000000";
        IRout   : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
end IR;

architecture behavioral of IR is 
    signal data : std_logic_vector (15 downto 0);
begin
    process (clk)
    begin
        if clk'Event and clk = '1' then
            if IRload = '1' then
                data <= Databus;
            end if;
        end if;
        IRout <= data;
 end process; -- IR

end behavioral; -- behavioral