library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testir is
end testir;

architecture behavioral of testir is

    component ir
        port (
            clk     : in std_logic;
            IRload  : in std_logic;
            dataBus : in std_logic_vector (15 downto 0);
            IRout   : out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk     : std_logic;
    signal IRload  : std_logic;
    signal dataBus : std_logic_vector (15 downto 0);
    signal IRout   : std_logic_vector (15 downto 0);

begin
    myIr : ir port map (
        clk     => clk,
        IRload  => IRload,
        dataBus => dataBus,
        IRout   => IRout
    );
end behavioral; -- behavioral