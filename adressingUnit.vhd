library IEEE;
use IEEE.std_logic_1164.all;

ENTITY AddressUnit IS
    PORT (
        Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        Address : OUT std_logic_vector (15 DOWNTO 0);
        clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
        R0plus1, R0plus0, EnablePC : IN std_logic
    );
END AddressUnit;
ARCHITECTURE dataflow OF AddressUnit IS
    COMPONENT PC  PORT (
        EnablePC : IN std_logic;
        input: IN std_logic_vector (15 DOWNTO 0);
        clk : IN std_logic;
        output: OUT std_logic_vector (15 DOWNTO 0)
    );
   END COMPONENT;

    COMPONENT AL port (
        PCside, Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        ALout : OUT std_logic_vector (15 DOWNTO 0);
        ResetPC, PCplusI, PCplus1, R0plus1, R0plus0 : IN std_logic
        ); END COMPONENT;


    SIGNAL pcout : std_logic_vector (15 DOWNTO 0);
    SIGNAL AddressSignal : std_logic_vector (15 DOWNTO 0);
BEGIN
    Address <= AddressSignal;
    l1 : PC PORT MAP (EnablePC, AddressSignal, clk, pcout);
    l2 : AL PORT MAP
        (pcout, Rside, Iside, AddressSignal,
        ResetPC, PCplusI, PCplus1, R0plus1, R0plus0);
END dataflow;