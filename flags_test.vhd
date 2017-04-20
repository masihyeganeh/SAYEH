library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testflags is
end testflags;

architecture behavioral of testflags is

    component flags
        port (
            clk    : in  std_logic;
            Cset   : in  std_logic;
            Creset : in  std_logic;
            Zset   : in  std_logic;
            Zreset : in  std_logic;
            Zin    : in  std_logic;
            Cin    : in  std_logic;
            Zout   : out std_logic;
            Cout   : out std_logic
        );
    end component;

    signal clk, Cset, Creset, Zset, Zreset, Zin, Cin, Zout, Cout : std_logic;
begin
    myFlags : flags port map (
        clk    => clk,
        Cset   => Cset,
        Creset => Creset,
        Zset   => Zset,
        Zreset => Zreset,
        Zin    => Zin,
        Cin    => Cin,
        Zout   => Zout,
        Cout   => Cout
    );
end behavioral; -- behavioral