library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testaddressingUnit is
end testaddressingUnit;

architecture behavioral of testaddressingUnit is

    component addressingUnit
        port (
            clk, EnablePC, ResetPC, PCplusI, PCplus1, R0plusI, R0plus0 : in std_logic;
            Rside   : in std_logic_vector (15 downto 0);
            Iside   : in std_logic_vector (7 downto 0);
            Address : out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk, EnablePC, ResetPC, PCplusI, PCplus1, R0plusI, R0plus0 : std_logic;
    signal Rside   : std_logic_vector (15 downto 0);
    signal Iside   : std_logic_vector (7 downto 0);
    signal Address : std_logic_vector (15 downto 0);

begin
    myAddressingUnit : addressingUnit port map (
        clk      => clk,
        EnablePC => EnablePC,
        ResetPC  => ResetPC,
        PCplusI  => PCplusI,
        PCplus1  => PCplus1,
        R0plusI  => R0plusI,
        R0plus0  => R0plus0,
        Rside    => Rside,
        Iside    => Iside,
        Address  => Address  
    );
end behavioral; -- behavioral