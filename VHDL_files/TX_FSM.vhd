library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_lOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TX_FSM is
    Port(
        clk : in std_logic;
        tx_data : in std_logic_vector (7 downto 0);
        txEn : in std_logic;
        rst : in std_logic;
        baudEn : in std_logic;
        tx : out std_logic;
        txRdy : out std_logic
    );
end TX_FSM;

architecture Behavioral of TX_FSM is

type state_type is (idle,start,bitt,stop);
signal state : state_type;

--iesirea din flip flop cu set txEn si reset baudEn
signal txEnOut : std_logic;
signal count : std_logic_vector (2 downto 0);

begin

--flip flop pentru txEn cu set txEn si reset baudEn

process(clk,txEn,baudEn)
begin
    if clk = '1' and clk'event then
        if txEn = '0' and baudEn = '0' then
            txEnOut <= txEnOut;
        elsif txEn = '1' and baudEn = '0' then
            txEnOut <= '1';
        elsif txEn = '0' and baudEn = '1' then
            txEnOut <= '0';
        end if;       
    end if;
end process;

process (clk,rst)
begin
    if rst = '1' then
        state <= idle;
        tx <= '1';
        txRdy <= '1';
    else
        if clk = '1' and clk'event and baudEn = '1' then
            case state is
                when idle => 
                    if txEnOut = '1' then
                        state <= start;   
                    end if;
                    tx <= '1';
                    txRdy <= '1';
                    count <= "000";
                when start =>
                    tx <= '0';
                    txRdy <= '0';
                    state <= bitt;
                when bitt => 
                    if count = "111" then
                        state <= stop;
                    else
                        count <= count + 1;  
                    end if;
                    tx <= tx_data(conv_integer(count));
                    txRdy <= '0';
                when stop =>
                    tx <= '1';
                    txRdy <= '0'; 
                    state <= idle;
            end case;   
        end if;
    end if; 
end process;

end Behavioral;
