library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testalu is
end testalu;

architecture behavioral of testalu is

    component alu
        port (
            B15downto0, AandB, AorB, notB, AaddB, AsubB, AcmpB, shlB, shrB : in std_logic;
            Zin, Cin : in std_logic;
            destinationOperand, sourceOperand : in std_logic_vector (15 downto 0);
            output : out std_logic_vector (15 downto 0);
            Cout, Zout : out std_logic
        );
    end component;

    signal B15downto0, AandB, AorB, notB, AaddB, AsubB, AcmpB, shlB, shrB : std_logic := '0';
    signal Zin, Cin : std_logic := '0';
    signal destinationOperand, sourceOperand : std_logic_vector (15 downto 0) := "0000000000000000";
    signal output : std_logic_vector (15 downto 0) := "0000000000000000"; 
    signal Cout, Zout : std_logic := '0';

begin
    myAlu : alu port map (
        B15downto0         => B15downto0,
        AandB              => AandB,
        AorB               => AorB,
        notB               => notB,
        AaddB              => AaddB,
        AsubB              => AsubB,
        AcmpB              => AcmpB,
        shlB               => shlB,
        shrB               => shrB,
        Zin                => Zin,
        Cin                => Cin,
        destinationOperand => destinationOperand,
        sourceOperand      => sourceOperand,
        output             => output,
        Cout               => Cout,
        Zout               => Zout
    );
end behavioral ; -- behavioral