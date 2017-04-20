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


        signal   clk :  std_logic;
        signal   ExternalReset :  std_logic;
        signal   ReadMem, WriteMem, ReadIO, WriteIO, MemDataReady :  std_logic;
        signal   Addressbus :  std_logic_vector (15 downto 0);
        signal   databus :  std_logic_vector (15 downto 0);
    

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
         databus => databus
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