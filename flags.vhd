library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flags is
    port (
        clk    : in  std_logic := '0';
        Cset   : in  std_logic := '0';
        Creset : in  std_logic := '0';
        Zset   : in  std_logic := '0';
        Zreset : in  std_logic := '0';
        -- SRload : in  std_logic; -- kys
        Zin    : in  std_logic := '0';
        Cin    : in  std_logic := '0';
        Zout   : out std_logic := '0';
        Cout   : out std_logic := '0'
    );
end flags;

architecture behavioral of flags is
begin
 flagsProcess : process (clk)
    begin
        if clk'Event and clk = '1' then
            if Cset = '1' then
                Cout <= '1';
            elsif Creset = '1' then
                Cout <= '0';
            else
                Cout <= Cin;
            end if;

            if Zset = '1' then
                Zout <= '1';
            elsif Zreset = '1' then
                Zout <= '0';
            else
                Zout <= Zin;
            end if;
        end if;   
    end process; -- flagsProcess
end behavioral; -- behavioral