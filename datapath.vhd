library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
	port (
		clk : in std_logic;
		ResetPC, PCplusI, PCplus1, R0plusI, R0plus0,
		Rs_on_AddressUnit, Rd_on_AddressUnit,
 		RFLwrite, RFHwrite, WPreset, WPadd, IRload,
		Address_on_Databus, ALUout_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
		Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : in std_logic :='0';
	 	Addressbus : out std_logic_vector (15 downto 0) := "0000000000000000";
		Databus : out std_logic_vector (15 downto 0) := "0000000000000000"
	
	);
end datapath;

architecture rtl of datapath is

	component addressingUnit is
	PORT (
        Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        Address : OUT std_logic_vector (15 DOWNTO 0);
		Databus : OUT std_logic_vector (15 DOWNTO 0);
        clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
        R0plusI, R0plus0 : IN std_logic
    );
	end component;

	component alu is
	Port(
		B15downto0, AandB, AorB, notB, AaddB, AsubB, AcmpB, shlB, shrB : in std_logic;
        Zin, Cin : in std_logic;
        destinationOperand, sourceOperand : in std_logic_vector (15 downto 0);
        output : out std_logic_vector (15 downto 0);
        Cout, Zout : out std_logic
    );
	end component;

	component registerFile is
	port(
		input : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		addr : in std_logic_vector(3 downto 0);
		WP : in std_logic_vector(5 downto 0);
		RFLWrite :in std_logic;
		RFHWrite : in std_logic;
		RS : out std_logic_vector(15 downto 0);
		RD : out std_logic_vector(15 downto 0)
 	);
	end component;

	component IR is
	port (
		clk : in std_logic;
		IRload : in std_logic;
		Databus : in std_logic_vector(15 downto 0);
		IRout : out std_logic_vector (15 downto 0)
 	);
	end component;

	component flags is
	port(
		clk    : in  std_logic;  
		Cset   : in  std_logic;
		Creset : in  std_logic;
		Zset   : in  std_logic;
		Zreset : in  std_logic;
		Zin    : in  std_logic;
		Cin    : in  std_logic;
		Zout   : out std_logic;
		Cout   : out std_logic
  	);
	end component;

	component WP is
	port (
      WPin : in std_logic_vector(5 downto 0);
	  clk : in std_logic;
	  WPreset : in std_logic;      
      WPadd : in std_logic;
      WPout : out std_logic_vector(5 downto 0)
  	);
	end component;

	signal B15downto0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB, Cout, Zout : std_logic := '0';
	signal Right, Left, OpndBus, ALUout, Address, AddressUnitRSideBus : std_logic_vector(15 downto 0) := "0000000000000000";
	signal IRout : std_logic_vector(15 downto 0) := "0000000000000000";
	signal WPout, WPin : std_logic_vector(5 downto 0) := "000000";
	signal RSide : std_logic_vector (15 downto 0) := "0000000000000000";
	signal ISide : std_logic_vector (7 DOWNTO 0) := "00000000";
	signal registeraddr : std_logic_vector(3 downto 0) := "0000";
	signal AddressSignal, DatabusSignal : std_logic_vector (15 downto 0) := "0000000000000000";


begin
	process( IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus )
	begin
		if IR_on_LOpndBus = '1' then
			OpndBus <= ("00000000" & IRout (7 downto 0));
		elsif IR_on_HOpndBus = '1' then
			OpndBus <= (IRout (15 downto 8) & "00000000");
		end if ;

		if RFright_on_OpndBus = '1' then
			Right <= OpndBus;
		end if ; 
	end process ;

    AU  : addressingUnit port map (
	Rside => Rside,
	Iside => Iside,
	Address => AddressSignal,
	Databus => DatabusSignal,
	clk => clk,
	ResetPC => ResetPC,
	PCplusI => PCplusI,
	PCplus1 => PCplus1,
	R0plusI => R0plusI,
	R0plus0 => R0plus0
	);

	AL  : alu port map (
		B15downto0         => B15downto0,
        AandB              => AandB,
        AorB               => AorB,
        notB               => notB,
        AaddB              => AaddB,
        AsubB              => AsubB,
        AcmpB              => AcmpB,
        shlB               => shlB,
        shrB               => shrB,
        Zin                => Zin,
        Cin                => Cin,
        destinationOperand => Left,
        sourceOperand      => Right,
        output             => ALUout,
        Cout               => Cout,
        Zout               => Zout
	);

	process( IRout )
	begin
		if Shadow = '0' then
			registeraddr <= IRout (11 downto 8);
		else
			registeraddr <= IRout (3 downto 0);
		end if;
	end process ;

	process( Address_on_Databus, ALUout_on_Databus, ALUout, AddressSignal, DatabusSignal )
	begin
		if Address_on_Databus = '1' then
            DatabusSignal <= AddressSignal;
        elsif ALUout_on_Databus = '1' then
			DatabusSignal <= ALUout;
		end if;
		Databus <= DatabusSignal;
		AddressBus <= AddressSignal;
	end process ;

	RF  : registerFile port map (DatabusSignal, clk, registeraddr, WPout, RFLwrite, RFHwrite, Right, Left); 
	instrunctionreg : IR port map (clk, IRload, DatabusSignal, IRout);
	SR  : flags port map(clk, Cset, Creset, Zset, Zreset, Zin, Cin, Zout, Cout);
	WindowPointer : WP port map (WPin, clk, WPreset, WPadd, WPout);
end architecture;