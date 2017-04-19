library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flags is
  port (
    clk    : in  std_logic;  
    Cset   : in  std_logic;
    Creset : in  std_logic;
    Zset   : in  std_logic;
    Zreset : in  std_logic;
    --SRload : in  std_logic; -- kill yourself
    Zin    : in  std_logic;
    Cin    : in  std_logic;
    Zout   : out std_logic;
    Cout   : out std_logic
  );
end flags;

architecture behavioral of flags is

     

begin

 flagsProcess : process(clk)
    begin
        if clk'Event and clk = '1' then
         if Cset = '1' then
               Cout <= '1';
         elsif Creset = '1' then
                Cout <= '0';
            else
                Cout <= Cin;           
            end if ;   
          if Zset = '1' then
                Zout <= '1';
            elsif Zreset = '1' then
                Zout <= '0';
            else
                Zout <= Zin;           
            end if ;
         end if;   
    end process ; -- flagsProcess

end behavioral ; -- behavioral