library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testcontroller is
end testcontroller;

architecture behavioral of testcontroller is

    component controller
        port (
        ReadMem, WriteMem, -- memory 
		address_on_databus, ALUout_on_Databus, -- databus
		ResetPc, PCplus1, PCplusI, R0plusI, R0plus0, -- pc
		RFLwrite, RFHwrite, -- registerfile
		WPadd, WPreset, -- wp
		RS_on_AddresetUnitRSide, RD_on_AddresetUnitRSide, -- addressLogic
		IRload, Shadow, -- IR
		IR_on_LOpndBus, RFright_on_OpndBus, IR_on_HOpndBus, -- OPndBus
		B15to0, AandB, AorB, NotB, AaddB, AsubB, AcmpB, shrB, shlB, -- alu
		Cset, Creset, Zset, ZReset, SRload : out std_logic;  --flags
		IR : in std_logic_vector (15 downto 0);
		clk, External_Reset, MemDataReady, Zin, Cin : in std_logic
        );
    end component;

    signal ReadMem, WriteMem, address_on_databus, ALUout_on_Databus, ResetPc,
    PCplus1, PCplusI, R0plusI, R0plus0, RFLwrite, RFHwrite, WPadd, WPreset,
    RS_on_AddresetUnitRSide, RD_on_AddresetUnitRSide, IRload, Shadow,
    IR_on_LOpndBus, RFright_on_OpndBus, IR_on_HOpndBus, B15to0, AandB, AorB,
    NotB, AaddB, AsubB, AcmpB, shrB, shlB, Cset, Creset, Zset, ZReset, SRload,
    External_Reset, MemDataReady, Zin, Cin, clk : std_logic := '0';
    signal IR : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    myController : controller port map (
        
        ReadMem => ReadMem,
        WriteMem => WriteMem,
        address_on_databus => address_on_databus,
        ALUout_on_Databus => ALUout_on_Databus,
        ResetPc => ResetPc,
        PCplus1 => PCplus1,
        PCplusI => PCplusI,
        R0plusI => R0plusI,
        R0plus0 => R0plus0,
        RFLwrite => RFLwrite,
        RFHwrite => RFHwrite,
        WPadd => WPadd,
        WPreset => WPreset,
        RS_on_AddresetUnitRSide => RS_on_AddresetUnitRSide,
        RD_on_AddresetUnitRSide => RD_on_AddresetUnitRSide,
        IRload => IRload,
        Shadow => Shadow,
        IR_on_LOpndBus => IR_on_LOpndBus,
        RFright_on_OpndBus => RFright_on_OpndBus,
        IR_on_HOpndBus => IR_on_HOpndBus,
        B15to0 => B15to0,
        AandB => AandB,
        AorB => AorB,
        NotB => NotB,
        AaddB => AaddB,
        AsubB => AsubB,
        AcmpB => AcmpB,
        shrB => shrB,
        shlB => shlB,
        Cset => Cset,
        Creset => Creset,
        Zset => Zset,
        ZReset => ZReset,
        SRload => SRload,
        IR => IR,
        clk => clk,
        External_Reset => External_Reset,
        MemDataReady => MemDataReady,
        Zin => Zin,
        Cin => Cin
    );

 

end behavioral;