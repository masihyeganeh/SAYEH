library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY AddressLogic IS
    PORT (
        PCside, Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        ALout : OUT std_logic_vector (15 DOWNTO 0);
        ResetPC, PCplusI, PCplus1, RplusI : IN std_logic := '0';
        Rplus0 : IN std_logic := '1'
    );
END AddressLogic;
ARCHITECTURE dataflow of AddressLogic IS
BEGIN
    PROCESS (PCside, Rside, Iside, ResetPC,
            PCplusI, PCplus1, RplusI, Rplus0)
        VARIABLE temp : std_logic_vector (4 DOWNTO 0);
BEGIN
        temp := (ResetPC & PCplusI & PCplus1 & RplusI & Rplus0);
        CASE temp IS
            WHEN "10000" => ALout <= (OTHERS => '0');
            WHEN "01000" => ALout <= std_logic_vector(unsigned(PCside) + unsigned(Iside));
            WHEN "00100" => ALout <= std_logic_vector(unsigned(PCside) + 1);
            WHEN "00010" => ALout <= std_logic_vector(unsigned(Rside) + unsigned(Iside));
            WHEN "00001" => ALout <= Rside;
            WHEN OTHERS => ALout <= PCside;
        END CASE;
    END PROCESS;
END dataflow;