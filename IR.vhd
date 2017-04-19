library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IR is
    port (
        clk     : in std_logic;
        IRload  : in std_logic;
        dataBus : in std_logic_vector (15 downto 0);
        IRout   : out std_logic_vector (15 downto 0)
    );
end IR;

architecture behavioral of IR is 
    signal data : std_logic_vector (15 downto 0);
begin
    process (clk)
    begin
        if clk'Event and clk = '1' then
            if IRload = '1' then
                data <= databus;
            else
                Rout <= data;
            end if;
        end if;
 end process; -- IR

end behavioral; -- behavioral