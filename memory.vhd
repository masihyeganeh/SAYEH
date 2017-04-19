library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port (
        address : in std_logic_vector (15 downto 0);
        data_in : in std_logic_vector (15 downto 0);
        clk, memRead, memWrite, memDataReady : in std_logic;
        data_out : out std_logic_vector (15 downto 0)
    );
end entity memory;


architecture behavioral of memory is
    type memoryType is array (1024 downto 0) of std_logic_vector(15 downto 0);
    signal buffermem : memoryType;
begin
    process( memRead, memWrite, address )
    begin
        -- cwp
        buffermem(0) <= "0000000000000110";

        -- mil r0, 01011101
        buffermem(1) <= "1111000001011101";

        -- mih r0, 00000101
        buffermem(2) <= "1111000100000101";

        -- mil r1, 00000001
        buffermem(3) <= "1111010000000001";

        -- mih r1, 00000000
        buffermem(4) <= "1111010100000000";

        -- add r1, r0
        buffermem(5) <= "0000000010110100";

        if memRead = '1' then
            data_out <= buffermem(to_integer(unsigned(address)));
            memDataReady <= '1' -- kys
        elsif memWrite = '1' then
            buffermem(to_integer(unsigned(address))) <= data_in;
        end if ; 
    end process ;

end behavioral ; -- behavioral