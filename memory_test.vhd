library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testmemory is
end testmemory;

architecture behavioral of testmemory is

    component memory
        port (
            address : in std_logic_vector (15 downto 0);
            databus : inout std_logic_vector (15 downto 0);
            clk, ReadMem, WriteMem : in std_logic;
            MemDataReady : out std_logic
        );
    end component;

    signal address : std_logic_vector (15 downto 0);
    signal clk, ReadMem, WriteMem : std_logic;
    signal MemDataReady : std_logic;
    signal databus : std_logic_vector (15 downto 0);

begin
    myMemory : memory port map (
        address      => address,
        databus      => databus,
        clk          => clk,
        ReadMem      => ReadMem,
        WriteMem     => WriteMem,
        MemDataReady => MemDataReady
    );
end behavioral; -- behavioral