library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use work.types_pack.all;
use work.populateBRAM_pack.all;
use work.populateInputArray_pack.all;
use work.incrementCounter_pack.all;
use work.populateWeightArray_pack.all;
use work.sumOfProducts_pack.all;

entity ANN is
Port(
        clk : in std_logic;
        rx : in std_logic;
        sw : in std_logic_vector (15 downto 0);
        btn : in std_logic_vector (4 downto 0);
        tx : out std_logic;
        led : out std_logic_vector (15 downto 0);
        cat : out std_logic_vector (6 downto 0);
        an : out std_logic_vector (3 downto 0)
    );
end ANN;

architecture Behavioral of ANN is

---------------------------Types---------------------------
--type FixedPointArray is ARRAY (NATURAL RANGE <>) of sfixed(7 downto -8);
--type state_type is (idle,receive,show,verifyFiles,verifyDigit,populateInputArray,computeFixedPoint,saveValue,incrementCount,verifyWeightIndex,
--populateWeightArray,computeFixedPointW,saveValueW,compute,incrementCountW,incrementCounterWeight,computeProduct,computeSum,final);
--type ram_array is array (0 to 12) of std_logic_vector(3 downto 0);

---------------------------=Arrays---------------------------
signal inputArray : FixedPointArray (0 to 575) := (others => X"0000");
signal weightsArray : FixedPointArray (0 to 575) := (others => X"0000");
signal outputt : FixedPointArray (0 to 9) := (others => X"0000");
signal allOutputs : FixedPointArray (0 to 129) := (others => X"0000");
signal maxValues : ram_array := (others => "0000");

---------------------------InputsBRAM---------------------------
signal addressInputs : std_logic_vector(12 downto 0);
signal dinInputs: std_logic_vector(15 downto 0);
signal doutInputs: std_logic_vector (15 downto 0);
signal weInputs: std_logic := '0';
signal countInputs : std_logic_vector (12 downto 0) := (others => '0');

---------------------------WeightsBRAM---------------------------
signal addressWeights : std_logic_vector(12 downto 0);
signal dinWeights: std_logic_vector(15 downto 0);
signal doutWeights: std_logic_vector (15 downto 0);
signal weWeights: std_logic := '0';
signal countWeights : std_logic_vector (12 downto 0) := (others => '0');

---------------------------Rx---------------------------
signal baudEnRx : std_logic;
signal value : std_logic_vector (7 downto 0);
signal rxRdy : std_logic;
signal countRx : std_logic_vector (9 downto 0) := "00" & X"00";
signal okRdy : std_logic := '0';

---------------------------Tx---------------------------
signal val : std_logic_vector (7 downto 0) := X"00";
signal okTx : std_logic := '0';
signal baudEnTx : std_logic;
signal txRdy: std_logic;

---------------------------Others---------------------------
signal en0,en1,en2,en3,en4: std_logic;
signal digit: std_logic_vector(15 downto 0);
signal countValuesI,numberInputs : std_logic_vector (12 downto 0) := (others => '0');
signal countValuesW,numberWeights : std_logic_vector (12 downto 0) := (others => '0');
signal fixedPointVal: sfixed(7 downto -8);
signal fixedPointValW: sfixed(7 downto -8);
signal suma : sfixed(7 downto -8) := (others => '0');
signal sumaAux : sfixed(7 downto -8);
signal countFiles : std_logic_vector (1 downto 0) := "00";
signal bramValue : std_logic_vector (15 downto 0);
signal zero : sfixed(7 downto -8) := (others => '0');
signal produs: sfixed(7 downto -8) := (others => '0');

---------------------------Aux---------------------------
signal count1 : std_logic_vector (12 downto 0) := (others => '0');
signal count2 : std_logic_vector (12 downto 0) := (others => '0');
signal count3 : std_logic_vector (9 downto 0) := (others => '0');
signal count4 : std_logic_vector (12 downto 0) := (others => '0');
signal count5 : std_logic_vector (3 downto 0) := (others => '0');
signal count6 : std_logic_vector (7 downto 0) := (others => '0');
signal counter1 : std_logic_vector (3 downto 0) := (others => '0');
signal counter2 : std_logic_vector (3 downto 0) := (others => '0');
signal counter3 : std_logic_vector(7 downto 0) := (others => '0');
signal count : std_logic_vector(12 downto 0) := (others => '0');
signal cntI : std_logic_vector(9 downto 0) := (others => '0');
signal countW : std_logic_vector(12 downto 0) := (others => '0');
signal cntW: std_logic_vector(9 downto 0) := (others => '0');
signal valInput,valInputW: std_logic_vector (15 downto 0);
signal ok : std_logic := '0';
signal countOutput : std_logic_vector(9 downto 0) := (others => '0');
signal maxValue: sfixed(7 downto -8) := "1011111100000000";
signal labelMax : std_logic_vector (3 downto 0) := "0000";

---------------------------FSM---------------------------
signal state : state_type := idle;
signal stateVal : std_logic_vector (4 downto 0) := "00000";

---------------------------SSD_Barrel---------------------------
signal left : std_logic_vector (3 downto 0) := "0000";
signal countBarrel : std_logic_vector (27 downto 0) := (others => '0');



component inputsBRAM is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end component inputsBRAM;

component weightsBRAM is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end component weightsBRAM;

component TX_FSM
    Port(
        clk : in std_logic;
        tx_data : in std_logic_vector (7 downto 0);
        txEn : in std_logic;
        rst : in std_logic;
        baudEn : in std_logic;
        tx : out std_logic;
        txRdy : out std_logic
    );
end component;

component RX_FSM
    Port(
    clk : in std_logic;
    rx : in std_logic;
    rst : in std_logic;
    baudEn : in std_logic;
    rxData : out std_logic_vector(7 downto 0);
    rxRdy : out std_logic
    );
end component;

component MPG is
    Port(
        btn : in std_logic;
        clk : in std_logic;
        enable : out std_logic
    );
end component;

component SSD is
    Port(
        clk : in std_logic;
        digit : in std_logic_vector (15 downto 0);
        cat : out std_logic_vector (6 downto 0);
        an : out std_logic_vector (3 downto 0)
        );
end component;

begin

inputsBRAM_i: inputsBRAM
     port map (
      BRAM_PORTA_0_addr(12 downto 0) => addressInputs,
      BRAM_PORTA_0_clk => clk,
      BRAM_PORTA_0_din(15 downto 0) => dinInputs,
      BRAM_PORTA_0_dout(15 downto 0) => doutInputs,
      BRAM_PORTA_0_we(0) => weInputs
    );

weightsBRAM_i: weightsBRAM
     port map (
      BRAM_PORTA_0_addr(12 downto 0) => addressWeights,
      BRAM_PORTA_0_clk => clk,
      BRAM_PORTA_0_din(15 downto 0) => dinWeights,
      BRAM_PORTA_0_dout(15 downto 0) => doutWeights,
      BRAM_PORTA_0_we(0) => weWeights
    );   
    

RXFSM1 : RX_FSM port map (
    clk => clk,
    rx => rx,
    rst => '0',
    baudEn => baudEnRx,
    rxData => value(7 downto 0),
    rxRdy => rxRdy
);

TXFSM1 : TX_FSM port map (
    clk => clk,
    tx_data => val,
    txEn => okTx,
    rst => '0',
    baudEn => baudEnTx,
    tx => tx,
    txRdy => txRdy
);
    
MPG1 : MPG port map (
    btn => btn(0),
    clk => clk,
    enable => en0
);
MPG2 : MPG port map (
    btn => btn(1),
    clk => clk,
    enable => en1
    );
MPG3 : MPG port map (
    btn => btn(2),
    clk => clk,
    enable => en2
    );   
    
MPG4 : MPG port map (
    btn => btn(3),
    clk => clk,
    enable => en3
    ); 
    
MPG5 : MPG port map (
    btn => btn(4),
    clk => clk,
    enable => en4
    ); 
        
SSD1 : SSD port map (
    clk => clk,
    digit => digit,
    cat => cat,
    an => an
);



process (clk,en0)
begin
    if clk = '1' and clk'event then
        if en0 = '1' then
            count1 <= count1 + 1;
        end if;
    end if;
end process;

process (clk,en1)
begin
    if clk = '1' and clk'event then
        if en1 = '1' then
            count2 <= count2 + 1;
        end if;
    end if;
end process;

process (clk,en2)
begin
    if clk = '1' and clk'event then
        if en2 = '1' then
            count3 <= count3 + 1;
        end if;
    end if;
end process;

process (clk,en3)
begin
    if clk = '1' and clk'event then
        if en3 = '1' then
            count4 <= count4 + 1;
        end if;
    end if;
end process;

process (clk,en4)
begin
    if clk = '1' and clk'event then
        if en4 = '1' then
            count5 <= count5 + 1;
            count6 <= count6 + 1;
        end if;
    end if;
end process;

process (clk,countRx)
begin
    if clk = '1' and clk'event then
        --countRx: 650 pt 9600,54 pt 115200
        if countRx = 54 then
            baudEnRx <= '1';
            countRx <= "00" & X"00";
        else
            baudEnRx <= '0';
            countRx <= countRx + 1;
        end if;   
    end if;
end process;

process (clk,state,rxRdy,okRdy,countFiles,countValuesI,countValuesW,count,countW,addressInputs,valInput,fixedPointVal,doutInputs)
variable poz : integer := 15;
variable rightI : integer := 575;
variable rightW : integer := 575;
variable pos_slv : integer := 15;
variable pos_sfixed : integer := 7;
begin
    if clk = '1' and clk'event then
        case state is
          when idle =>
                stateVal <= "00000";
                idleState(countValuesI,countValuesW,okTx,poz,rxRdy,state);
          when receive =>
                stateVal <= "00001";          
                receiveState(rxRdy,okRdy,value,weInputs,weWeights,bramValue,poz,countFiles,addressInputs,countValuesI,dinInputs,addressWeights,
                             countValuesW,dinWeights,state);
          when show =>
                stateVal <= "00010";
                showState(countFiles,numberInputs,countValuesI,numberWeights,countValuesW,state);
          when verifyFiles =>            
                stateVal <= "00011";
                verifyFilesState(countFiles,state);
          when verifyDigit =>
                stateVal <= "00100";
                verifyDigitState(counter1,state);
          when populateInputArray =>
                stateVal <= "00101";
                populateInputArrayState(pos_slv,pos_sfixed,count,rightI,addressInputs,valInput,doutInputs,state);
          when computeFixedPoint =>
                stateVal <= "00110";
                computeFixedPointState(pos_slv,state,valInput,fixedPointVal,pos_sfixed);  
          when saveValue =>
                stateVal <= "00111";
                saveValueState(inputArray,cntI,fixedPointVal,state);
          when incrementCount =>
                stateVal <= "01000";
                incrementCountState(cntI,state,count,rightI);
          when verifyWeightIndex =>
                stateVal <= "01001"; 
                verifyWeightIndexState(counter2,maxValues,counter1,labelMax,maxValue,countOutput,cntW,suma,sumaAux,state,cntI,countW,rightW);    
          when populateWeightArray =>
                stateVal <= "01010";
                populateWeightArrayState(pos_slv,pos_sfixed,countW,rightW,addressWeights,valInputW,doutWeights,state);          
          when computeFixedPointW =>
                stateVal <= "01011";
                computeFixedPointWState(pos_slv,state,valInputW,fixedPointValW,pos_sfixed);
          when saveValueW =>
                stateVal <= "01100";
                saveValueWState(weightsArray,cntW,fixedPointValW,state);
          when incrementCountW =>
                stateVal <= "01101"; 
                incrementCountWState(countW,rightW,state,cntW);
          when compute =>
                stateVal <= "01110";
                computeState(countOutput,sumaAux,suma,state,outputt,allOutputs,counter2,counter3,maxValue,labelMax);
          when saveAllOutputsValue =>
                stateVal <= "01111";
                saveAllOutputsValueState(allOutputs,counter3,suma,state);
          when computeProduct =>
                stateVal <= "10000";
                computeProductState(produs,inputArray,countOutput,weightsArray,state);
          when computeSum =>
                stateVal <= "10001";
                computeSumState(suma,produs,sumaAux,countOutput,state);
          when incrementCounterWeight =>
                stateVal <= "10010";
                incrementCounterWeightState(counter2,state);             
          when others =>
                stateVal <= "10011";
                addressInputs <= count1;
                addressWeights <= count2;
        end case;
    end if;
end process;

--Valorile din vectorul maxValues (practic cifrele din CNP: ex. 2760429264382) vor fi afisare print-o shiftare de la dreapta la stanga, cu o pozitie
--la fiecare 2 secunde. Shiftarea a fost facuta folosind un divizor de frecventa. A fost folosit un counter care numara pana la 200 000 0000, conform
--formulei T=1/f, unde frecventa este 100 MHz.

process (clk,countBarrel)
begin
    if clk = '1' and clk'event then
        countBarrel <= countBarrel + 1;
        if countBarrel = 200000000 then
            countBarrel <= (others => '0');
            if left = 9 then
                left <= "0000";
            else
                left <= left + 1;
            end if;
        end if;
    end if;
end process;

process
begin
    case sw(10 downto 7) is
        when "0000" => led <= doutInputs;
        when "0001" => led <= doutWeights;
        when "0010" => led <= to_slv(inputArray(conv_integer(count3)));
        when "0011" => led <= to_slv(weightsArray(conv_integer(count4)));
        when "0100" => led <= to_slv(outputt(conv_integer(count5)));
        when "0101" => led <= to_slv(maxValue);
        when "0110" => led <= X"000" & maxValues(conv_integer(count5));
        when "0111" => led <= to_slv(allOutputs(conv_integer(count6)));
        when others => led <= to_slv(suma);
    end case;
end process;

process
begin
    case sw(15 downto 11) is
        when "00000" => digit <= (digit'range => '0') + addressInputs;
        when "00001" => digit <= (digit'range => '0') + addressWeights;
        when "00010" => digit <= (digit'range => '0') + countValuesI;
        when "00011" => digit <= (digit'range => '0') + countValuesW;
        when "00100" => digit <= (digit'range => '0') + countFiles;
        when "00101" => digit <= (digit'range => '0') + count1;
        when "00110" => digit <= (digit'range => '0') + count2;
        when "00111" => digit <= (digit'range => '0') + numberInputs;
        when "01000" => digit <= (digit'range => '0') + numberWeights;
        when "01001" => digit <= (digit'range => '0') + count3;
        when "01010" => digit <= (digit'range => '0') + count4;
        when "01011" => digit <= X"000" & "000" & ok;
        when "01100" => digit <= (digit'range => '0') + counter2;
        when "01101" => digit <= (digit'range => '0') + count5;
        when "01110" => digit <= (digit'range => '0') + countW;
        when "01111" => digit <= (digit'range => '0') + labelMax;
        when "10000" => digit <= (digit'range => '0') + maxValues(conv_integer(count5));
        when "10001" => digit <=  maxValues(conv_integer(left)) & maxValues(conv_integer(left + 1)) & 
                                  maxValues(conv_integer(left + 2)) & maxValues(conv_integer(left + 3));
        when "10010" => digit <= (digit'range => '0') + count6;
        when others => digit <= (digit'range => '0') + stateVal;      
    end case;
end process;

end Behavioral;
