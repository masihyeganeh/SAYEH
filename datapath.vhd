library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
	port (register_load, register_shift : in std_logic;
		clk : in std_logic;
		ResetPC, PCplusI, PCplus1, R0plus1, R0plus0,
		Rs_on_AddressUnit, Rd_on_AddressUnit, EnablePC,
 		RFLwrite, RFHwrite, WPreset, WPadd, IRload, SRIoad, B15to0,
		Address_on_Databus, ALU_on_Databus, IR_on_LOpndBus, IR_on_HOpndBus, RFright_on_OpndBus,
		Cset, Creset, Zset, Zreset, Zin, Cin, Shadow : in std_logic;
		register_in : in std_logic_vector (3 downto 0);
	 	RSide : in std_logic_vector (15 downto 0);
		ISide : in std_logic_vector (7 DOWNTO 0);
		Addressbus, Instruction : out std_logic_vector (15 downto 0);
		register_out, Cout, Zout : out std_logic);
end datapath;

architecture rtl of datapath is
	component fourRegister is
		port (d : in std_logic_vector(3 downto 0);
			clk, load, shift : in std_logic;
			qout : out std_logic);
	end component;

	component addressingUnit is
	PORT (
        Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        Address : OUT std_logic_vector (15 DOWNTO 0);
        clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
        R0plus1, R0plus0, EnablePC : IN std_logic
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
		Daddr : in std_logic_vector(1 downto 0);
		Saddr : in std_logic_vector(1 downto 0);
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
		dataBus : in std_logic_vector(15 downto 0);
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
		--SRload : in  std_logic; -- kill yourself
		Zin    : in  std_logic;
		Cin    : in  std_logic;
		Zout   : out std_logic;
		Cout   : out std_logic
  	);
	end component;

	component WP is
	port (
      IRout : in std_logic_vector(4 downto 0);
	  clk : in std_logic;
	  WPreset : in std_logic;      
      WPadd : in std_logic;
      WPout : out std_logic_vector(5 downto 0)
  	);
	end component;

	signal B15downto0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB : std_logic;
	signal SRCin, SRZin, SRZout, SRCout : std_logic;
	signal Right, Left, OpndBus, ALUout, Address, AddressUnitRSideBus, Databus, IRout : std_logic_vector(15 downto 0);
	signal WPout : std_logic_vector(5 downto 0);
	signal Laddr, Raddr : std_logic_vector(1 downto 0);

begin
	GPR : fourRegister port map (register_in, clk, register_load, register_shift, register_out);
    AU  : addressingUnit port map (Rside, Iside, Address, clk, ResetPC, PCplusI, PCplus1, R0plus1, R0plus0, EnablePC);
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
	RF  : registerFile port map (Databus, clk, Laddr, Raddr, WPout, RFLwrite, RFHwrite, Left, Right); 
	instrunctionreg : IR port map (clk, IRload, Databus, IRout);
	SR  : flags  port map(clk, Cset, Creset, Zset, Zreset, Zin, Cin, Zout, Cout);
	WindowPointer : WP port map (IRout(4 downto 0), clk, WPreset, WPadd, WPout);
end architecture;
