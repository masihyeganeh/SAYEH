library ieee;
use ieee.std_logic_1164.all;

entity WP is
  port (
      IRout : in std_logic_vector(4 downto 0);
      WPadd : in std_logic;
      WPreset : in std_logic;
      clk : in std_logic;
      WPout : out std_logic_vector(5 downto 0)
  ) ;
end WP;

architecture behavioral of WP is

    begin
        process(clk)
        begin
            if clk'Event and clk ='1' then
                
            end if ;
        end process;

end behavioral ; -- behavioral