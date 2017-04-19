library IEEE;
use IEEE.std_logic_1164.all;

entity controller is
	port (
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
end entity;

architecture rtl of controller is
	type state is (fetch, decode, effectiveAddress, execute, writeBack, halt);
	signal current_state : state;
	signal next_state : state;
	signal no_operation : std_logic := '0';
begin
	-- next to current
	process (clk, rst)
	begin
		if rst = '1' then
			current_state <= fetch;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	-- next based on state
	process (current_state)
	begin
		case current_state is
			when fetch =>
				next_state <= decode;
				ReadMem <= '1';
				WriteMem <= '0';
				IRload <= '1';
				PCPlus1 <= '1';   

			when decode =>
				next_state <= effectiveAddress;
				-- TODO: these bits should be cleared here or what?
		        B15to0       <= '0';
				AandB        <= '0';
				AorB         <= '0';
				NotB         <= '0';
				AaddB        <= '0';
				AsubB        <= '0';
				AcmpB        <= '0';
				shrB         <= '0';
				shlB         <= '0';
				no_operation <= '0';

				case ( IR (15 downto 12) ) is
					when "0110" => AandB <= '1'; -- and
					when "0111" => AorB  <= '1'; -- or
					when "1001" => shlB  <= '1'; -- shift left
					when "1010" => shrB  <= '1'; -- shift right
					when "1011" => AandB <= '1'; -- addition
					when "1100" => AsubB <= '1'; -- subtraction
					when "1110" => AcmpB <= '1'; -- comparison
					when "0000" =>
						case( IR (11 downto 8) ) is
							when "0000" => no_operation <= '1';  -- No Operation
							when "0001" => next_state   <= halt; -- Halt
							when "0010" => Zset         <= '1';  -- Set zero flag
							when "0011" => ZReset       <= '1';  -- Clear zero flag
							when "0100" => Cset         <= '1';  -- Set carry flag
							when "0101" => Creset       <= '1';  -- Clear carry flag
							when "0110" => WPreset      <= '1';  -- Clear window pointer
							when others =>
						end case ;
					when others =>
				end case ;

			when effectiveAddress =>
				if no_operation = '0' then
					-- TODO: Implement effectiveAddress here
					-- fetch data from memory address if source is refering to memory or do nothing
				end if ;
				next_state <= execute;

			when execute =>
				if no_operation = '0' then
					-- TODO: Implement execute here
					-- pass operands to alu and let it do the calculation
				end if ;
				next_state <= writeBack;

			when writeBack =>
				if no_operation = '0' then
					-- TODO: Implement writeBack here
					-- write data back to memory address if destination is refering to memory or do nothing
				end if ;
				next_state <= fetch;

			when halt =>
				-- do nothing
		end case;
	end process;
end architecture;