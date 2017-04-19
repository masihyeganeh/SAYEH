library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testalu is
end testalu;

architecture behavioral of testalu is

    component alu
        port (
            AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB : in std_logic;
            operand1   : in  std_logic_vector (15 downto 0);
            operand2   : in  std_logic_vector (15 downto 0);
            output     : out std_logic_vector (15 downto 0);
            carry      : out std_logic;
            zero       : out std_logic
        );
    end component;

    signal AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB : std_logic := '0';
    signal operand1   :  std_logic_vector (15 downto 0) := "0000100000100010";
    signal operand2   :  std_logic_vector (15 downto 0) := "1110011111111111";
    signal output     :  std_logic_vector (15 downto 0) := "0000000000000000";
    signal carry      :  std_logic := '0';
    signal zero       :  std_logic := '0';

begin
    myAlu : alu port map (
        AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB,
        operand1   => operand1,
        operand2   => operand2,
        output     => output,
        carry      => carry,
        zero       => zero
    );
end behavioral ; -- behavioral