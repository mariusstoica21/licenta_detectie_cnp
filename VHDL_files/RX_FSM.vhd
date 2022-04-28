library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RX_FSM is
    Port(
    clk : in std_logic;
    rx : in std_logic;
    rst : in std_logic;
    baudEn : in std_logic;
    rxData : out std_logic_vector(7 downto 0);
    rxRdy : out std_logic
    );
end RX_FSM;


architecture Behavioral of RX_FSM is

type state_type is (idle, start,bitt,stop,waitt);
signal state : state_type;
signal baudCnt : std_logic_vector (3 downto 0);
signal bitCnt : std_logic_vector (2 downto 0);
signal rx_stored_data : std_logic_vector(7 downto 0) := (others => '0');

begin

process (rst,state,clk,baudEn)
begin
    if clk = '1' and clk'event then
        if rst = '1' then
            state <= idle;
            rxRdy <= '0';
            rx_stored_data <= (others => '0');
            baudCnt <= "0000";
            bitCnt <= "000";
        elsif baudEn = '1' then
            case state is
                when idle => 
                    rxRdy <= '0';
                    baudCnt <= "0000";
                    bitCnt <= "000";
                    rx_stored_data <= (others => '0');
                    --rxData <= (others => '0');
                    if rx = '0' then
                        state <= start;
                    end if;
                when start =>
                    if rx = '1' then
                        state <= idle;
                    else
                        if baudCnt = "0111" then
                            state <= bitt;
                            baudCnt <= "0000";
                        else
                            baudCnt <= baudCnt + 1;
                        end if;
                    end if;
                    rxRdy <= '0';
                when bitt =>
                    rxRdy <= '0';
                    if baudCnt = "1111" then
                        rx_stored_data(conv_integer(bitCnt)) <= rx;
                        baudCnt <= "0000";
                        if bitCnt = "111" then
                            --rxData(conv_integer(bitCnt)) <= rx;
                            state <= stop;    
                            baudCnt <= "0000";
                        else      
                            --rxData(conv_integer(bitCnt)) <= rx;
                            bitCnt <= bitCnt + 1;
                        end if;
                    else
                        baudCnt <= baudCnt + 1;
                    end if;      
                when stop =>
                    rxRdy <= '0';
                    if baudCnt = "1111" then
                        state <= waitt;
                        baudCnt <= "0000";
                        rxData <= rx_stored_data;
                        rxRdy <= '1';
                    else
                        baudCnt <= baudCnt + 1;
                    end if;    
--                when waitt => 
--                    rxRdy <= '1';
--                    if baudCnt = "0111" then
--                        state <= idle;
--                    else
--                        baudCnt <= baudCnt + 1;
--                    end if; 
                when others =>
                    state <= idle;
            end case;
        end if;
    end if;
end process;


end Behavioral;
