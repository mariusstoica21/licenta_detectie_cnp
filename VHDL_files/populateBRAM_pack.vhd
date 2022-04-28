library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.types_pack.all;


package populateBRAM_pack is

procedure idleState (signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal okTx : inout std_logic;
                    variable poz : inout integer;
                    signal rxRdy : inout std_logic;
                    signal state : inout state_type
                    );

procedure receiveState (signal rxRdy :  inout std_logic;
                    signal okRdy : inout std_logic;
                    signal value : inout std_logic_vector(7 downto 0);
                    signal weInputs : inout std_logic;
                    signal weWeights : inout std_logic;
                    signal bramValue : inout std_logic_vector (15 downto 0);
                    variable poz : inout integer;
                    signal countFiles : inout std_logic_vector (1 downto 0);
                    signal addressInputs : inout std_logic_vector(12 downto 0);
                    signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal dinInputs: inout std_logic_vector(15 downto 0);
                    signal addressWeights : inout std_logic_vector(12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal dinWeights: inout std_logic_vector(15 downto 0);
                    signal state : inout state_type
                    );
procedure showState (signal countFiles : inout std_logic_vector (1 downto 0);
                    signal numberInputs : inout std_logic_vector (12 downto 0);
                    signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal numberWeights : inout std_logic_vector (12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal state : inout state_type
                    );

procedure verifyFilesState (signal countFiles : inout std_logic_vector (1 downto 0);
                    signal state : inout state_type
                    );
   
end package populateBRAM_pack;

-- Package Body Section
package body populateBRAM_pack is

--Procedura 'idleState' initializeaza cu 0 variabilele countValuesI (folosita pentru a numara input-urile: 576 * 13 = 7488),
--countValuesW (folosita pentru a numara weights-urile: 576 * 10 = 5760) si trece in starea receive daca este semnalata
--primirea datelor pe linia RX (rxRdy devine '1').

procedure idleState(
                    signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal okTx : inout std_logic;
                    variable poz : inout integer;
                    signal rxRdy : inout std_logic;
                    signal state : inout state_type
                    ) is
begin
    countValuesI <= (others => '0');
    countValuesW <= (others => '0');
    okTx <= '0';
    poz := 15;
    if rxRdy = '1' then
        state <= receive;
    end if;
end procedure;

--Procedura 'receiveState' are rolul de a salva valorile in memoriile aditionale de input (inputArray) sau de weights-uri (weightsArray).
--Input-urile si weights-urile vin sub forma sirurilor de caractere (ex. "1000100000010001 1010101010101010"). Scopul acestei stari este
--de a prelua fiecare byte (0 sau 1) si de a-l stoca intr-un vector. La citirea caracterului spatiu, se va salva vectorul in memoria de
--input/weights si se va trece la formarea urmatorului vector. Daca variabila countFiles este 0, se va salva in memoria de input-uri,
--iar daca countFiles este 1, se va salva in memoria de weights-uri.
--Daca rxRdy este '1' (s-a primit un byte pe linia RX), atunci se verfica valoarea acelui byte: byte-ul poate fi o cifra (0 sau 1) 
--(cod ascii 48 sau 49) sau spatiu (cod ascii 32). Daca este cifra, se va salva la pozitia corespunzatoare din vectorul aflat in proces
--de formare. Pozitiile sunt de la 15 la 0. Vectorul se va salva la adresa determinata de variabilele countValuesI, respectiv countValuesW.
--Scrierea in memoriile de input-uri si weights-uri se face cand weInputs/weWeights (semnal write enable) este '1'.

procedure receiveState(
                    signal rxRdy :  inout std_logic;
                    signal okRdy : inout std_logic;
                    signal value : inout std_logic_vector(7 downto 0);
                    signal weInputs : inout std_logic;
                    signal weWeights : inout std_logic;
                    signal bramValue : inout std_logic_vector (15 downto 0);
                    variable poz : inout integer;
                    signal countFiles : inout std_logic_vector (1 downto 0);
                    signal addressInputs : inout std_logic_vector(12 downto 0);
                    signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal dinInputs: inout std_logic_vector(15 downto 0);
                    signal addressWeights : inout std_logic_vector(12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal dinWeights: inout std_logic_vector(15 downto 0);
                    signal state : inout state_type
                    ) is
begin
    if rxRdy = '1' and okRdy = '0' then
        if conv_integer(value) >= 48 and conv_integer(value) <= 57 then
            weInputs <= '0';
            weWeights <= '0';
            if conv_integer(value) = 48 then
                bramValue(poz) <= '0';
                --fixedPointVal(poz) <= '0';
            else
                bramValue(poz) <= '1'; 
                --fixedPointVal(poz) <= '1';
            end if;
            poz := poz - 1;
        elsif conv_integer(value) = 32 then
            if countFiles = "00" then
                addressInputs <= countValuesI;
                dinInputs <= bramValue; 
                weInputs <= '1';
                countValuesI <= countValuesI + 1; 
            elsif countFiles = "01" then
                addressWeights <= countValuesW;
                dinWeights <= bramValue; 
                weWeights <= '1';
                countValuesW <= countValuesW + 1;    
            end if;    
            poz := 15;
        end if;        
        okRdy <= '1';
    elsif rxRdy = '0' then
        okRdy <= '0';
    end if;     
    if countValuesI = 7488 or countValuesW = 5760 then
        weInputs <= '0';
        weWeights <= '0';
        state <= show;
    end if;
end procedure;

--Procedura 'showState' este apelata atunci cand se incheie procesul de transmitere a input-urilor (countValuesI egal cu 7488) sau al weights-urilor
--(countValuesW egal cu 5760). Daca countFiles este 0, numberInputs va primi valoarea lui countValuesI, iar daca countFiles este 1, numberWeights
--va primi valoarea lui countValuesW. Scopul acestei proceduri este de a salva numarul total de input-uri si numarul total de weights-uri in 
--variabilele numberInputs si numberWeights, pentru a verifica daca au fost primite toate datele necesare.

procedure showState(
                    signal countFiles : inout std_logic_vector (1 downto 0);
                    signal numberInputs : inout std_logic_vector (12 downto 0);
                    signal countValuesI :  inout std_logic_vector (12 downto 0);
                    signal numberWeights : inout std_logic_vector (12 downto 0);
                    signal countValuesW : inout std_logic_vector (12 downto 0);
                    signal state : inout state_type
                    ) is
begin
    if countFiles = "00" then
        numberInputs <= countValuesI;
    elsif countFiles = "01" then
        numberWeights <= countValuesW;   
    end if;
    countFiles <= countFiles + 1;
    state <= verifyFiles; 
end procedure;

--Procedura 'verifyFilesState' are rolul de a comuta automatul de stari catre starea verifyDigit, in cazul in care memoriile de input-uri si
--weights-uri au fost populate (countFiles = 2). Daca countFiles este 0 sau 1, inseamna ca memoriile nu au fost populate,astfel incat se 
--tranzitioneaza spre starea idle, care asteapta primirea datelor.  

procedure verifyFilesState(
                    signal countFiles : inout std_logic_vector (1 downto 0);
                    signal state : inout state_type
                    ) is
begin
    if (countFiles = 2) then
        state <= verifyDigit;
    else
        state <= idle; 
    end if; 
end procedure;



end package body populateBRAM_pack;
