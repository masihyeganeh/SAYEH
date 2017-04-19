library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testaddressLogic is
end testaddressLogic;

architecture behavioral of testaddressLogic is

    component addressLogic
        port (
            PCside, Rside : in std_logic_vector (15 downto 0);
            Iside  : in std_logic_vector (7 downto 0);
            ResetPC, PCplusI, PCplus1, R0plusI : in std_logic;
            R0plus0 : in std_logic;
            ALout  : out std_logic_vector (15 downto 0)
        );
    end component;

    signal PCside, Rside : std_logic_vector (15 downto 0);
    signal Iside  : std_logic_vector (7 downto 0);
    signal ResetPC, PCplusI, PCplus1, R0plusI : std_logic := '0';
    signal R0plus0 : std_logic := '1';
    signal ALout  : std_logic_vector (15 downto 0);

begin
    myAddressLogic : addressLogic port map (
        PCside  => PCside,
        Rside   => Rside,
        Iside   => Iside ,
        ResetPC => ResetPC,
        PCplusI => PCplusI,
        PCplus1 => PCplus1,
        R0plusI => R0plusI,
        R0plus0 => R0plus0,
        ALout   => ALout
    );
end behavioral; -- behavioral