library IEEE;
use IEEE.std_logic_1164.all;

entity controller is
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
end entity;

architecture rtl of controller is
	type state is (reset, fetch, decode, effectiveAddress, execute, writeBack, halt);
	signal current_state : state := reset;
	signal next_state : state;
	signal no_operation : std_logic := '0';
	signal shadow_select : std_logic := '0'; -- 0 : left most 8 bits instruction, 1 : : right most 8 bits instruction
begin
	-- next to current
	process (clk, External_Reset)
	begin
		if External_Reset = '1' then
			current_state <= reset;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	-- next based on state
	process (current_state)
		variable operation : std_logic_vector (3 downto 0);
	begin
		case current_state is
			when reset =>
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
				next_state <= fetch;

			when fetch =>
				next_state <= decode;
				ReadMem <= '1';
				WriteMem <= '0';
				IRload <= '1';
				PCPlus1 <= '1';   

			when decode =>
				next_state <= effectiveAddress;
				if shadow_select = '1' then
					operation := IR (8 downto 5);
				else
					operation := IR (15 downto 12);
				end if ;
				case ( operation ) is
					when "0001" =>
						B15to0 <= '1';
						ALUout_on_Databus <= '1';
						RFLwrite <= '1';
						RFHwrite <= '1';
					when "0010" =>
						RS_on_AddresetUnitRSide <= '1';
						R0plus0 <= '1';
						RFLwrite <= '1';
						RFHwrite <= '1';
						ReadMem <= '1';
					when "0011" =>
						B15to0 <= '1';
						ALUout_on_Databus <= '1';
						RD_on_AddresetUnitRSide <= '1';
						R0plus0 <= '1';
						WriteMem <= '1';
					when "0110" => AandB <= '1'; -- and
					when "0111" => AorB  <= '1'; -- or
					when "1001" => shlB  <= '1'; -- shift left
					when "1010" => shrB  <= '1'; -- shift right
					when "1011" => AaddB <= '1'; -- addition
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

							when "0111" => PCplusI <= '1';
							when "1000" =>
								if Zin = '1' then
									PCplusI <= '1';
								end if ;
							when "1001" =>
								if Cin = '1' then
									PCplusI <= '1';
								end if ;
							when "1010" => WPadd <= '1';
							when others =>
						end case ;
					when "1111" => 
						case ( IR (9 downto 8) ) is
							when "00" => RFLwrite <= '1'; -- I should be on Databus
							when "01" => RFHwrite <= '1'; -- I should be on Databus
							when "10" =>
								PCplusI <= '1';
								address_on_databus <= '1';
								RFLwrite <= '1';
								RFHwrite <= '1';
							when "11" =>
								RD_on_AddresetUnitRSide <= '1';
								PCplusI <= '1'; -- I should be on Databus
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
					ALUout_on_Databus <= '1';
					-- TODO: Implement execute here
					-- pass operation to alu and let it do the calculation
				end if ;
				next_state <= writeBack;

			when writeBack =>
				if no_operation = '0' then
					-- TODO: Implement writeBack here
					-- write data back to memory address if destination is refering to memory or do nothing
				end if ;
				next_state <= fetch;

				if shadow_select = '0' then
					next_state <= execute; -- TODO: if instruction is not 16 bits
					shadow_select <= '1';
				else
					shadow_select <= '0';
				end if ;

			when halt =>
				-- do nothing
		end case;
	end process;
end architecture;