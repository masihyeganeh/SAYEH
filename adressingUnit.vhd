library IEEE;
use IEEE.std_logic_1164.all;

entity AddressUnit is
    port (
        Rside   : in std_logic_vector (15 downto 0);
        Iside   : in std_logic_vector (7 downto 0);
        Address : out std_logic_vector (15 downto 0);
        clk, EnablePC, ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : in std_logic
    );
end AddressUnit;

architecture dataflow of AddressUnit is
    component PC port (
        EnablePC : in std_logic;
        input: in std_logic_vector (15 downto 0);
        clk : in std_logic;
        output: out std_logic_vector (15 downto 0)
    );
   end component;

   component AL port (
        PCside, Rside : in std_logic_vector (15 downto 0);
        Iside  : in std_logic_vector (7 downto 0);
        ResetPC, PCplusI, PCplus1, RplusI : in std_logic := '0';
        Rplus0 : in std_logic := '1';
        ALout  : out std_logic_vector (15 downto 0)
    );
    end component;

    signal PCout, AddressSignal : std_logic_vector (15 downto 0);

begin
    Address <= AddressSignal;

    l1 : PC port map (
        EnablePC, AddressSignal, clk, PCout
    );

    l2 : AL port map (
        PCside  => PCout,
        Rside   => Rside,
        ResetPC => ResetPC,
        PCplusI => PCplusI,
        PCplus1 => PCplus1,
        RplusI  => RplusI,
        Rplus0  => Rplus0,
        ALout   => AddressSignal
    );
end dataflow;