library IEEE;
use IEEE.std_logic_1164.all;

entity addressingUnit is
    port (
        clk, ResetPC, PCplusI, PCplus1, R0plusI, R0plus0, address_on_databus : in std_logic := '0';
        EnablePC : in std_logic := '1';
        Rside   : in std_logic_vector (15 downto 0) := "0000000000000000";
        Iside   : in std_logic_vector (7 downto 0) := "00000000";
        Address : out std_logic_vector (15 downto 0)  := "0000000000000000";
        Databus : out std_logic_vector (15 downto 0)  := "0000000000000000"
    );
end addressingUnit;

architecture dataflow of addressingUnit is
    component PC port (
        clk, EnablePC : in std_logic;
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

    signal PCout , addressSignal : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    process( address_on_databus, AddressSignal )
    begin
        if address_on_databus = '1' then
            Databus <= AddressSignal;
        else
            Address <= AddressSignal;
        end if ;
    end process;

    l1 : PC port map (
        clk      => clk,
        EnablePC => EnablePC,
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