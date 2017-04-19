library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AcmpB : in std_logic := '0';
        SRCout, SRZin, SRCin : out std_logic := '0';
        ALUout, OpndBus    : in  std_logic_vector (15 downto 0) := "0000000000000000";
        operand1   : in  std_logic_vector (15 downto 0) := "0000000000000000";
        operand2   : in  std_logic_vector (15 downto 0) := "0000000000000000";
        output     : out std_logic_vector (15 downto 0) := "0000000000000000";
        carry      : out std_logic := '0';
        zero       : out std_logic := '0'
    );
end ALU;

architecture RTL of ALU is
    signal temp : std_logic_vector (16 downto 0); -- signals won't refresh until next clock?
begin
    ALUProcess : process( operand1, operand2 )
    begin
        carry <= '0';

        -- and
        if AandB = '1' then
            output  <= (operand1 and operand2);

        -- or
        elsif AorB = '1' then
                output  <= (operand1 or operand2);

        -- shift left
        elsif shlB = '1' then
            output  <= std_logic_vector(unsigned(operand1) sll to_integer(unsigned(operand2)));

        -- shift right
        elsif shrB = '1' then
                output  <= std_logic_vector(unsigned(operand1) srl to_integer(unsigned(operand2)));

        -- addition
        elsif AaddB = '1' then
            temp   <= std_logic_vector(signed('0' & operand1) + signed('0' & operand2)); -- add an extra bit to use 17 bits vector
            if (temp(16) = '1') then
                carry <= '1';
                output <= std_logic_vector(signed(operand1) + signed(operand2) + 1);
            else
                carry <= '0';
                output <= std_logic_vector(signed(operand1) + signed(operand2));
            end if;

        -- subtraction
        elsif AsubB = '1' then
        if (signed(operand1) < signed(operand2)) then
                carry  <= '1';
                output <= std_logic_vector(signed(operand1) - signed(operand2) - 1);
            else
                carry  <= '0';
                output <= std_logic_vector(signed(operand1) - signed(operand2));
            end if;
        -- comparison
        elsif AcmpB = '1' then 
            output <= std_logic_vector(signed(operand1) - signed(operand2));
            if (std_logic_vector(signed(operand1) - signed(operand2)) = "0000000000000000") then
                zero <= '1';
            else
                zero <= '0';
            end if;
            if (signed(operand1) < signed(operand2)) then
                carry <= '1';
            else
                carry <= '0';
            end if;
        
        -- others
        else output   <= "0000000000000000";
        
        end if;


    end process ; -- ALU

end RTL ; -- RTL