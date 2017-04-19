library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        B15downto0, AandB, AorB, notB, AaddB, AsubB, AcmpB, shlB, shrB : in std_logic := '0'; -- Operation
        Zin, Cin : in std_logic := '0'; -- Inputs from flags register
        destinationOperand, sourceOperand : in std_logic_vector (15 downto 0) := "0000000000000000"; -- Operands
        output : out std_logic_vector (15 downto 0) := "0000000000000000";  -- Output
        Cout, Zout : out std_logic := '0' -- Outputs to flags register
    );
end ALU;

architecture RTL of ALU is
    signal temp : std_logic_vector (16 downto 0); -- signals won't refresh until next clock?
begin
    ALUProcess : process( destinationOperand, sourceOperand )
    begin
        Cout <= '0';

        -- B
        if B15downto0 = '1':
            output  <= sourceOperand;

        -- and
        if AandB = '1' then
            output  <= (destinationOperand and sourceOperand);

        -- or
        elsif AorB = '1' then
                output  <= (destinationOperand or sourceOperand);

        -- shift left
        elsif shlB = '1' then
            output  <= std_logic_vector(unsigned(sourceOperand) sll to_integer(unsigned(destinationOperand)));

        -- shift right
        elsif shrB = '1' then
                output  <= std_logic_vector(unsigned(sourceOperand) srl to_integer(unsigned(destinationOperand)));

        -- addition
        elsif AaddB = '1' then
            temp   <= std_logic_vector(signed('0' & destinationOperand) + signed('0' & sourceOperand)); -- add an extra bit to use 17 bits vector
            if (temp(16) = '1') then
                Cout <= '1';
                output <= std_logic_vector(signed(destinationOperand) + signed(sourceOperand) + 1);
            else
                Cout <= '0';
                output <= std_logic_vector(signed(destinationOperand) + signed(sourceOperand));
            end if;

        -- subtraction
        elsif AsubB = '1' then
        if (signed(destinationOperand) < signed(sourceOperand)) then
                Cout  <= '1';
                output <= std_logic_vector(signed(destinationOperand) - signed(sourceOperand) - 1);
            else
                Cout  <= '0';
                output <= std_logic_vector(signed(destinationOperand) - signed(sourceOperand));
            end if;
        -- comparison
        elsif AcmpB = '1' then 
            output <= std_logic_vector(signed(destinationOperand) - signed(sourceOperand));
            if (std_logic_vector(signed(destinationOperand) - signed(sourceOperand)) = "0000000000000000") then
                Zout <= '1';
            else
                Zout <= '0';
            end if;
            if (signed(destinationOperand) < signed(sourceOperand)) then
                Cout <= '1';
            else
                Cout <= '0';
            end if;
        
        -- others
        else output   <= "0000000000000000";
        
        end if;


    end process ; -- ALU

end RTL ; -- RTL