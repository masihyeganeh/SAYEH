library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testmemory is
end testmemory;

architecture behavioral of testmemory is

    component memory
        port (
            address : in std_logic_vector (15 downto 0);
            data_in : in std_logic_vector (15 downto 0);
            clk, ReadMem, WriteMem : in std_logic;
            MemDataReady : out std_logic;
            data_out : out std_logic_vector (15 downto 0)
        );
    end component;

    signal address : std_logic_vector (15 downto 0);
    signal data_in : std_logic_vector (15 downto 0);
    signal clk, ReadMem, WriteMem : std_logic;
    signal MemDataReady : std_logic;
    signal data_out : std_logic_vector (15 downto 0);

begin
    myMemory : memory port map (
        address      => address,
        data_in      => data_in,
        clk          => clk,
        ReadMem      => ReadMem,
        WriteMem     => WriteMem,
        MemDataReady => MemDataReady,
        data_out     => data_out
    );
end behavioral; -- behavioral