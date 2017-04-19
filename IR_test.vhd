library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testalu is
end testalu;

architecture behavioral of testalu is

    component alu
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
    myAlu : alu port map (
        clk     => clk,
        IRload  => IRload,
        dataBus => dataBus,
        IRout   => IRout
    );
end behavioral; -- behavioral