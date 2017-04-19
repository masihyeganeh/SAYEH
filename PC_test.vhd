library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testpc is
end testpc;

architecture behavioral of testpc is

    component pc
        port (
            clk, EnablePC : in std_logic;
            input  : in std_logic_vector (15 downto 0);
            output : out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk, EnablePC : std_logic;
    signal input  : std_logic_vector (15 downto 0);
    signal output : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    myPc : pc port map (
        clk      => clk,
        EnablePC => EnablePC,
        input    => input,
        output   => output
    );
end behavioral; -- behavioral