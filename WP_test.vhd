library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testWP is
end testWP;

architecture behavioral of testWP is

    component WP
        port (
            clk     : in std_logic;
            WPadd   : in std_logic;
            WPreset : in std_logic;
            WPin    : in std_logic_vector(4 downto 0);
            WPout   : out std_logic_vector(5 downto 0)
        );
    end component;

    signal clk     : std_logic;
    signal WPadd   : std_logic;
    signal WPreset : std_logic;
    signal WPin    : std_logic_vector(4 downto 0);
    signal WPout   : std_logic_vector(5 downto 0);

begin
    myWP : WP port map (
        clk     => clk,
        WPadd   => WPadd,
        WPreset => WPreset,
        WPin    => WPin,
        WPout   => WPout
    );
end behavioral; -- behavioral