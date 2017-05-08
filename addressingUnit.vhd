library IEEE;
use IEEE.std_logic_1164.all;

entity addressingUnit is
    port (
        clk, ResetPC, PCplusI, PCplus1, R0plusI, R0plus0 : in std_logic := '0';
        Rside   : in std_logic_vector (15 downto 0) := "0000000000000000";
        Iside   : in std_logic_vector (7 downto 0) := "00000000";
        Address : out std_logic_vector (15 downto 0)  := "0000000000000000";
        Databus : out std_logic_vector (15 downto 0)  := "0000000000000000"
    );
end addressingUnit;

architecture dataflow of addressingUnit is
    component PC port (
        clk : in std_logic;
        PCinput  : in std_logic_vector (15 downto 0);
        PCoutput : out std_logic_vector (15 downto 0):= "0000000000000000"
    );
   end component;

   component AddressLogic port (
        PCside, Rside : in std_logic_vector (15 downto 0) := "0000000000000000";
        Iside  : in std_logic_vector (7 downto 0) := "00000000";
        ResetPC, PCplusI, R0plus0, R0plusI : in std_logic := '0';
        PCplus1 : in std_logic := '1';
        ALout  : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
    end component;

    signal PCout , AddressSignal : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    Address <= AddressSignal;

    l1 : PC port map (
        clk      => clk,
        PCinput    => AddressSignal,
        PCoutput   => PCout
    );

    l2 : AddressLogic port map (
        PCside  => PCout,
        Rside   => Rside,
        Iside   => Iside,
        ResetPC => ResetPC,
        PCplusI => PCplusI,
        PCplus1 => PCplus1,
        R0plusI => R0plusI,
        R0plus0 => R0plus0,
        ALout   => AddressSignal
    );
end dataflow;