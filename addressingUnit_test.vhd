library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testaddressingUnit is
end testaddressingUnit;

architecture behavioral of testaddressingUnit is

    component addressingUnit
        port (
            clk, ResetPC, PCplusI, R0plusI, R0plus0, address_on_databus : in std_logic := '0';
            PCplus1 : in std_logic := '1';
            Rside   : in std_logic_vector (15 downto 0) := "0000000000000000";
            Iside   : in std_logic_vector (7 downto 0) := "00000000";
            Address : out std_logic_vector (15 downto 0) := "0000000000000000";
            Databus : out std_logic_vector (15 downto 0) := "0000000000000000"
        );
    end component;

    signal clk, ResetPC, PCplusI, R0plusI, R0plus0, address_on_databus : std_logic := '0';
    signal PCplus1 : std_logic := '1';
    signal Rside   : std_logic_vector (15 downto 0) := "0000000000000000";
    signal Iside   : std_logic_vector (7 downto 0) := "00000000";
    signal Address, Databus : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    myAddressingUnit : addressingUnit port map (
        clk      => clk,
        ResetPC  => ResetPC,
        PCplusI  => PCplusI,
        PCplus1  => PCplus1,
        R0plusI  => R0plusI,
        R0plus0  => R0plus0,
        address_on_databus => address_on_databus,
        Rside    => Rside,
        Iside    => Iside,
        Address  => Address,
        Databus  => Databus
    );

    process
    begin
    clk <= '0';
    wait for 10 NS;
    clk <= '1';
    wait for 10 NS;
end process;

end behavioral; -- behavioral