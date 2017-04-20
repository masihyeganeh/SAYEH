library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testpc is
end testpc;

architecture behavioral of testpc is

    component pc
        port (
            clk, EnablePC : in std_logic;
            PCinput  : in std_logic_vector (15 downto 0);
            PCoutput : out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk : std_logic;
    signal EnablePC : std_logic := '1';
    signal PCinput  : std_logic_vector (15 downto 0) := "0000000000000000";
    signal PCoutput : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    myPc : pc port map (
        clk      => clk,
        EnablePC => EnablePC,
        PCinput    => PCinput,
        PCoutput   => PCoutput
    );

       process
    begin
    clk <= '0';
    wait for 10 NS;
    clk <= '1';
    wait for 10 NS;
end process;

end behavioral; -- behavioral