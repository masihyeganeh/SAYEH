library IEEE;
use IEEE.std_logic_1164.all;
 
 entity sayeh is
   port (
     clk : in std_logic;
     ExternalReset : in std_logic;
     ReadMem, WriteMem, ReadIO, WriteIO, MemDataReady : out std_logic;
     addressbus : out std_logic_vector (15 downto 0);
     databus : inout std_logic_vector (15 downto 0) --not sure if inout
   ) ;
 end sayeh;

 architecture behavioral of sayeh is

      component DP port (
        register_load, register_shift : in std_logic;
		clk : in std_logic;
		ResetPC, PCplusI, PCplus1, R0plus1, R0plus0,
		Rs_on_AddressUnit, Rd_on_AddressUnit, EnablePC,
 		RFLwrite, RFHwrite, WPreset, WPadd, IRload, SRIoad,
		Address_on_Databus, ALU_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
		Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : in std_logic;
		register_in : in std_logic_vector (3 downto 0);
	 	RSide : in std_logic_vector (15 downto 0);
		ISide : in std_logic_vector (7 DOWNTO 0);
		Addressbus, Instruction : out std_logic_vector (15 downto 0);
		register_out, Cout, Zout : out std_logic
    );
   end component;

   component ctrl port (
       	ReadMem, WriteMem, MemDataReady, -- memory 
		address_on_databus, -- databus
		resetPc, PCplus1, PCplus0, R0plus1, R0plus0, -- pc
		RFLwrite, RFHwrite, -- registerfile
		WPadd, WPreset, -- wp
		RS_on_AddresetUnitRSide, RD_on_AddresetUnitRSide, -- addressLogic
		IRload, Shadow, -- IR
		IR_on_LOdBus, RFright_on_OpndBus, IR_on_HOpndBus, -- OPndBus
		B15to0, AandB, AorB, NotB, AaddB, AsubB, AcmpB, shrB, shlB, -- alu
		Cset, Creset, Zset, ZReset, SRload : out std_logic;  --flags
		IR : in std_logic_vector (15 downto 0);
		clk, rst : in std_logic
    );
    end component;

 
    signal instruction : std_logic_vector (15 downto 0);
    signal register_load,register_shift, ResetPC, PCplusI, PCplus1, R0plus1, R0plus0,
    Rs_on_AddressUnit, Rd_on_AddressUnit, EnablePC,
    RFLwrite, RFHwrite, WPreset, WPadd, IRload, SRIoad, rst, RD_on_AddresetUnitRSide, RS_on_AddresetUnitRSide, IR_on_LOdBus,
    Address_on_Databus, ALU_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
    B15to0, AandB, AorB, NotB, AaddB, AsubB, AcmpB, shrB, shlB,
    Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : std_logic;
    signal	register_in :  std_logic_vector (3 downto 0);
    signal	RSide :  std_logic_vector (15 downto 0);
    signal  ISide :  std_logic_vector (7 DOWNTO 0);
    signal	register_out, Cout, Zout : std_logic;
    signal  IR : std_logic_vector (15 downto 0);

 begin

     DataPath  : DP port map (
        register_load => register_load, -- do we need? 
        register_shift => register_shift, -- still?
        clk => clk ,
        ResetPC => ResetPC,
        PCplusI => PCplusI,
        PCplus1 => PCplus1,
        R0plus1 => R0plus1,
        R0plus0 => R0plus0,
        Rs_on_AddressUnit => Rs_on_AddressUnit,
        Rd_on_AddressUnit => Rd_on_AddressUnit,
        EnablePC => EnablePC,
 	    RFLwrite => RFLwrite,
        RFHwrite => RFHwrite,
        WPreset => WPreset,
        WPadd   => WPadd,
        IRload  => IRload,
        SRIoad  => SRIoad,
        Address_on_Databus=> Address_on_Databus,
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
        RSide => RSide,
		ISide => ISide, 
		Addressbus => Addressbus,
        Instruction => Instruction, 
        register_in => register_in,  
		register_out => register_out,
        Cout => Cout, 
        Zout => Zout
    );

    ctrller : ctrl port map (
        ReadMem => ReadMem,
        WriteMem => WriteMem,
        MemDataReady => MemDataReady,
        -- memory 
        address_on_databus => address_on_databus,
        -- databus
        resetPc => resetPc,
        PCplus1 => PCplus1,
        PCplus0 => PCplusI,
        R0plus1 => R0plus1,
        R0plus0 => R0plus0,
        -- pc
        RFLwrite => RFLwrite,
        RFHwrite => RFHwrite,
        -- registerfile
        WPadd => WPadd,
        WPreset => WPreset,
        -- wp
        RS_on_AddresetUnitRSide => RS_on_AddresetUnitRSide,
        RD_on_AddresetUnitRSide => RD_on_AddresetUnitRSide,
        -- addressLogic
        IRload => IRload,
        Shadow => Shadow,
        -- IR
        IR_on_LOdBus => IR_on_LOdBus,
        RFright_on_OpndBus => RFright_on_OpndBus,
        IR_on_HOpndBus => IR_on_HOpndBus,
        -- OPndBus
        B15to0 => B15to0,
        AandB => AandB,
        AorB => AorB,
        NotB => NotB,
        AaddB => AaddB,
        AsubB => AsubB,
        AcmpB => AcmpB,
        shrB => shrB,
        shlB => shlB,
        -- alu
        Cset => Cset,
        Creset => Creset,
        Zset => Zset,
        ZReset => ZReset,
        -- SRload => SRload, 
        IR => IR,
        clk => clk,
        rst => rst
    );
 
 end behavioral ; -- behavioral