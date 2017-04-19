library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerFile is
  port (
    dataBus : in std_logic_vector(15 downto 0);
    clk : in std_logic;  
    input : in std_logic_vector(15 downto 0);
    RFLWrite :in std_logic;
    RFHWrite : in std_logic;
    WP : in std_logic_vector(5 downto 0);
    Daddr : in std_logic_vector(1 downto 0);
    Saddr : in std_logic_vector(1 downto 0);
    RS : out std_logic_vector(15 downto 0);
    RD : out std_logic_vector(15 downto 0)
 ) ;
end registerFile;

architecture behavioral of registerFile is

    type registerType is array (63 downto 0) of std_logic_vector(15 downto 0);

    signal Daddress  : std_logic_vector(5 downto 0);
    signal Saddress  : std_logic_vector(5 downto 0);
    signal registers : registerType;
    signal tempReg   : std_logic_vector(15 downto 0);


    
begin
    

     
    registerFile : process(clk)
    begin
        if (clk'Event and clk = '1') then
        Daddress <= std_logic_vector(unsigned(WP) + unsigned(Daddr));
        Saddress <= std_logic_vector(unsigned(WP) + unsigned(Saddr));
        RS <= registers(to_integer(unsigned(Saddress)));
        RD <= registers(to_integer(unsigned(Daddress)));

        tempReg <= registers(to_integer(unsigned(Daddress)));
        if (RFLWrite = '1') then tempReg (7 downto 0) <= input (7 downto 0); end if ;
        if (RFHWrite = '1') then tempReg (15 downto 8) <= input (15 downto 8); end if ;
        registers(to_integer(unsigned(Daddress))) <= tempReg; 
        end if;
        -- maybe there should be 2 processes one for clk one for the rest of ifs
    end process ; -- registerFile
        
   


end behavioral ; -- behavioral