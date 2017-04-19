library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testregisterFile is
end testregisterFile;

architecture behavioral of testregisterFile is

    component registerFile
        port (
            clk      : in std_logic;  
            input    : in std_logic_vector (15 downto 0);
            RFLWrite : in std_logic;
            RFHWrite : in std_logic;
            WP       : in std_logic_vector (5 downto 0);
            addr     : in std_logic_vector (3 downto 0);
            RS       : out std_logic_vector (15 downto 0);
            RD       : out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk      : std_logic;  
    signal input    : std_logic_vector (15 downto 0);
    signal RFLWrite : std_logic;
    signal RFHWrite : std_logic;
    signal WP       : std_logic_vector (5 downto 0);
    signal addr     : std_logic_vector (3 downto 0);
    signal RS       : std_logic_vector (15 downto 0);
    signal RD       : std_logic_vector (15 downto 0);

begin
    myRegisterFile : registerFile port map (
        clk      => clk,
        input    => input,
        RFLWrite => RFLWrite,
        RFHWrite => RFHWrite,
        WP       => WP,
        addr     => addr,
        RS       => RS,
        RD       => RD
    );
end behavioral; -- behavioral