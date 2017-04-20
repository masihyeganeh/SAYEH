library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testsayeh is
end testsayeh;

architecture behavioral of testsayeh is

    component sayeh
        port (
         clk : in std_logic;
         ExternalReset, MemDataReady : in std_logic;
         ReadMem, WriteMem, ReadIO, WriteIO : out std_logic;
         Addressbus : out std_logic_vector (15 downto 0);
         Databus : inout std_logic_vector (15 downto 0)
        );
    end component;

    component memory
        port (
            address : in std_logic_vector (15 downto 0) := "0000000000000000";
            data_in : in std_logic_vector (15 downto 0) := "0000000000000000";
            clk, ReadMem, WriteMem : in std_logic := '0';
            MemDataReady : out std_logic := '0';
            data_out : out std_logic_vector (15 downto 0) := "0000000000000000"
        );
    end component;


        signal   clk :  std_logic;
        signal   ExternalReset :  std_logic;
        signal   ReadMem, WriteMem, ReadIO, WriteIO, MemDataReady :  std_logic;
        signal   Addressbus :  std_logic_vector (15 downto 0);
        signal   Databus :  std_logic_vector (15 downto 0);
    

begin
    mysayeh : sayeh port map (
         clk => clk,
         ExternalReset => ExternalReset,
         ReadMem => ReadMem,
         WriteMem => WriteMem,
         ReadIO => ReadIO,
         WriteIO => WriteIO,
         MemDataReady => MemDataReady,
         Addressbus => Addressbus,
         Databus => Databus
    );
    mymemory : memory port map (
        address => Addressbus,
        data_in => Databus,
        clk => clk,
        ReadMem => ReadMem,
        WriteMem => WriteMem,
        MemDataReady => MemDataReady,
        data_out => Databus
    );
    MemDataReady <= '1';

process
    begin
    clk <= '0';
    wait for 10 NS;
    clk <= '1';
    wait for 10 NS;
end process;

end behavioral;