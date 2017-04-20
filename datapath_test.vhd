library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testDatapath is
end testDatapath;

architecture behavioral of testDatapath is

    component Datapath
        port (
      clk : in std_logic;
		ResetPC, PCplusI, PCplus1, R0plusI, R0plus0,
		Rs_on_AddressUnit, Rd_on_AddressUnit,
 		RFLwrite, RFHwrite, WPreset, WPadd, IRload, SRIoad,
		Address_on_Databus, ALU_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
		Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : in std_logic;
	 	Addressbus : out std_logic_vector (15 downto 0);
        Databus : inout std_logic_vector (15 downto 0)
        );
    end component;


        signal clk : std_logic := '0';
        signal ResetPC, PCplusI, PCplus1, R0plusI, R0plus0,
        Rs_on_AddressUnit, Rd_on_AddressUnit,
        RFLwrite, RFHwrite, WPreset, WPadd, IRload, SRIoad,
        Address_on_Databus, ALU_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
        Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : std_logic := '0';
        signal	Addressbus, Databus: std_logic_vector (15 downto 0) := "0000000000000000";
        
    

begin
    myDatapath : Datapath port map (
        
        clk => clk,
        ResetPC => ResetPC,
        PCplusI => PCplusI,
        PCplus1 => PCplus1,
        R0plusI => R0plusI,
        R0plus0 => R0plus0,
        Rs_on_AddressUnit => Rs_on_AddressUnit,
        Rd_on_AddressUnit => Rd_on_AddressUnit,
        RFLwrite => RFLwrite,
        RFHwrite => RFHwrite,
        WPreset => WPreset,
        WPadd => WPadd,
        IRload => IRload,
        SRIoad => SRIoad,
        Address_on_Databus => Address_on_Databus,
        ALU_on_Databus => ALU_on_Databus,
        IR_on_LOpndBus => IR_on_LOpndBus,
        IR_on_HOpndBus => IR_on_HOpndBus,
        RFright_on_OpndBus => RFright_on_OpndBus,
        Cset => Cset,
        Creset => Creset,
        Zset => Zset,
        Zreset => Zreset,
        Zin => Zin,
        Cin => Cin,
        Shadow => Shadow,
        Addressbus => Addressbus,
        Databus => Databus
    );

 

end behavioral;