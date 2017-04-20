library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity WP is
    port (
        clk     : in std_logic;
        WPadd   : in std_logic;
        WPreset : in std_logic;
        WPin    : in std_logic_vector(5 downto 0);
        WPout   : out std_logic_vector(5 downto 0)
    );
end WP;

architecture behavioral of WP is
    signal pointTo : std_logic_vector(5 downto 0);
begin
    process (clk)
    begin
        if clk'Event and clk ='1' then
            if WPreset = '1' then
                pointTo <= "000000";
            elsif WPadd = '1' then
                pointTo <= std_logic_vector(unsigned(pointTo) + unsigned(WPin));
            end if ;
            WPout <= pointTo;
        end if;
    end process;

end behavioral; -- behavioral