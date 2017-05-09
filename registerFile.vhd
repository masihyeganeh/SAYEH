library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registerFile is
    port (
        clk      : in std_logic;  
        input    : in std_logic_vector (15 downto 0) := "0000000000000000";
        RFLWrite : in std_logic := '0';
        RFHWrite : in std_logic := '0';
        WP       : in std_logic_vector (5 downto 0) := "000000";
        addr     : in std_logic_vector (3 downto 0) := "0000";
        RS       : out std_logic_vector (15 downto 0) := "0000000000000000";
        RD       : out std_logic_vector (15 downto 0) := "0000000000000000"
    );
end registerFile;

architecture behavioral of registerFile is

    type registerType is array (63 downto 0) of std_logic_vector(15 downto 0);

    signal registers : registerType;

begin
    registerFile : process (clk)
        variable Daddress  : integer;
        variable Saddress  : integer;
    begin
        if (clk'Event and clk = '1') then
            Daddress := to_integer(unsigned(WP) + unsigned(addr (3 downto 2)));
            Saddress := to_integer(unsigned(WP) + unsigned(addr (1 downto 0)));
            RS <= registers(Saddress);
            RD <= registers(Daddress);

            if (RFLWrite = '1') then
                registers(Daddress) <= registers(Daddress) (15 downto 8) &  input (7 downto 0);
            end if;

            if (RFHWrite = '1') then
                registers(Daddress) <= input (15 downto 8) & registers(Daddress) (7 downto 0);
            end if;

        end if;
        -- maybe there should be 2 processes one for clk one for the rest of ifs
    end process; -- registerFile
end behavioral; -- behavioral