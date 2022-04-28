library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
use ieee.std_logic_textio.all;
use work.types_pack.all;

library std;
use std.textio.all;



package populateWeightArray_pack is

procedure verifyWeightIndexState(signal counter2 : inout std_logic_vector (3 downto 0);
                                 signal maxValues : inout ram_array;  
                                 signal counter1 : inout std_logic_vector (3 downto 0);
                                 signal labelMax : inout std_logic_vector (3 downto 0);   
                                 signal maxValue: inout sfixed(7 downto -8);
                                 signal countOutput : inout std_logic_vector(9 downto 0);
                                 signal cntW: inout std_logic_vector(9 downto 0);
                                 signal suma : inout sfixed(7 downto -8);
                                 signal sumaAux : inout sfixed(7 downto -8);
                                 signal state : inout state_type;
                                 signal cntI : inout std_logic_vector(9 downto 0);
                                 signal countW : inout std_logic_vector(12 downto 0);
                                 variable rightW : inout integer 
                    ); 
                    
procedure populateWeightArrayState(  variable pos_slv : inout integer;
                                     variable pos_sfixed : inout integer;  
                                     signal countW : inout std_logic_vector(12 downto 0);
                                     variable rightW : inout integer;   
                                     signal addressWeights : inout std_logic_vector(12 downto 0);
                                     signal valInputW: inout std_logic_vector (15 downto 0);
                                     signal doutWeights: inout std_logic_vector (15 downto 0); 
                                     signal state : inout state_type                  
                    ); 

procedure computeFixedPointWState(   variable pos_slv : inout integer;
                                     signal state : inout state_type; 
                                     signal valInputW: inout std_logic_vector (15 downto 0);
                                     signal fixedPointValW: inout sfixed(7 downto -8);
                                     variable pos_sfixed : inout integer  
                    ); 
                    
procedure saveValueWState(           signal weightsArray : inout FixedPointArray (0 to 575);
                                     signal cntW: inout std_logic_vector(9 downto 0);
                                     signal fixedPointValW: inout sfixed(7 downto -8);
                                     signal state : inout state_type
                    ); 
   
end package populateWeightArray_pack;

-- Package Body Section
package body populateWeightArray_pack is

--Procedura 'verifyWeightIndexState' verifica valoarea variabilei counter2, si in functie de aceasta, comuta automatul de stari catre starea 
--corespunzatoare. Variabila counter2 este folosita pentru a urmari care este valoarea weights-urilor din weightsArray (576 weights-uri).
--Pentru prima cifra din CNP (cifra 2), se vor lua input-urile aferente si vor fi stocare in inputsArray. Apoi, pentru fiecare valoarea a counter2
--(de la 0 la 9), se vor stoca in weightsArray, cele 576 de weights-uri corespunzatoare output-ului aferent counter2. De exemplu, pentru a crea
--output-ul 0 al cifrei 2, se vor stoca in weightsArray weights-urile corespunzatoare output 0. Ulterior se va face suma produselor pentru fiecare 
--index al inputsArray si weightsArray, iar suma respectiva va reprezenta output 0. Counter2 se va incrementa, si se va relua procesul pentru 
--output-ul 1, pastrand acelasi inputArray (aferent cifrei 2 din CNP). Procesul pentru prima cifra din CNP se va incheia cabd counter2 va avea
--valoarea 10 (astfel cele 10 output-uri vor fi deja construite iar valoarea maxima a sumelor va reprezenta cifra corespunzatoare din CNP).
 

procedure verifyWeightIndexState(
                                 signal counter2 : inout std_logic_vector (3 downto 0);
                                 signal maxValues : inout ram_array;  
                                 signal counter1 : inout std_logic_vector (3 downto 0);
                                 signal labelMax : inout std_logic_vector (3 downto 0);   
                                 signal maxValue: inout sfixed(7 downto -8);
                                 signal countOutput : inout std_logic_vector(9 downto 0);
                                 signal cntW: inout std_logic_vector(9 downto 0);
                                 signal suma : inout sfixed(7 downto -8);
                                 signal sumaAux : inout sfixed(7 downto -8);
                                 signal state : inout state_type;
                                 signal cntI : inout std_logic_vector(9 downto 0);
                                 signal countW : inout std_logic_vector(12 downto 0);
                                 variable rightW : inout integer 
                                  ) is
begin
    if counter2 = 10 then
        --counter1 <= counter1 + 1;
        --state <= verifyDigit;
        maxValues(conv_integer(counter1)) <= labelMax;
        maxValue <= "1011111100000000";
        counter1 <= counter1 + 1;  
        counter2 <= (others => '0');
        countOutput <= (others => '0');
        cntW <= (others => '0');
        suma <= (others => '0');
        sumaAux <= (others => '0');
        state <= verifyDigit;
        cntI <= (others => '0');
        countW <= (others => '0');
        rightW := 575;
        --state <= final;
    else
        state <= populateWeightArray;
        suma <= (others => '0');
        sumaAux <= (others => '0');
        countOutput <= (others => '0');  
        cntW <= (others => '0');             
   end if;         
end procedure;

--Procedura 'populateWeightArrayState' are rolul de a prelua valoarea weights-urilor din memoria aditioanala de weights-uri de la adresa determinata
--de valoarea variabilei countW.

procedure populateWeightArrayState(
                                     variable pos_slv : inout integer;
                                     variable pos_sfixed : inout integer;  
                                     signal countW : inout std_logic_vector(12 downto 0);
                                     variable rightW : inout integer;   
                                     signal addressWeights : inout std_logic_vector(12 downto 0);
                                     signal valInputW: inout std_logic_vector (15 downto 0);
                                     signal doutWeights: inout std_logic_vector (15 downto 0); 
                                     signal state : inout state_type
                                  ) is
begin
   pos_slv := 15;
   pos_sfixed := 7;
   if countW <= rightW then
       addressWeights <= countW;
       valInputW(15 downto 0) <= doutWeights(15 downto 0);
       state <= computeFixedPointW; 
   end if;
end procedure;

--Procedura computeFixedPointWState, in oglinda cu procedura computeFixedPointState, are rolul de a converti valoarea din vectorul valInputW
--care este std_logic_vector(15 downto 0), intr-un vector de tipul fixed point (7 downto -8). Pozitia 15 din vectorul std_logic_vector corespunde 
--pozitiei 7 din fixed point vector, iar aceasta se decrementeaza, pana cand se ajunge la pozitia 0 in std_logic_vector, respectiv pozitia -8 din 
--fixed point vector. In vectorul fixed point, pozitiile de la 7 la 0 sunt alocate partii intregi, iar pozitiile -1 pana la -8 sunt alocate partii 
--fractionale. Astfel, valoarea 1.5 va fi reprezentata ca 0000 0001 1000 0000, unde 0000 0001 este partea intreaga, si 1000 0000 este partea 
--fractionala. In momentul in care vectorul fixed point este populat, se va trece la starea saveValueW.
  
procedure computeFixedPointWState(
                                     variable pos_slv : inout integer;
                                     signal state : inout state_type; 
                                     signal valInputW: inout std_logic_vector (15 downto 0);
                                     signal fixedPointValW: inout sfixed(7 downto -8);
                                     variable pos_sfixed : inout integer
                                  ) is
begin
    if pos_slv = -1 then 
        state <= saveValueW;
    else
        if valInputW(pos_slv) = '0' then
            fixedPointValW(pos_sfixed) <= '0';
        else
            fixedPointValW(pos_sfixed) <= '1'; 
        end if; 
        pos_slv := pos_slv - 1;
        pos_sfixed := pos_sfixed - 1;
        state <= computeFixedPointW;   
    end if;  
end procedure;

--Procedura saveValueWState are menirea de a salva vectorul fixed point in array-ul de fixed point values, numit weightsArray, la pozitia 
--determinata de valoarea cntW.

procedure saveValueWState(
                                     signal weightsArray :inout FixedPointArray (0 to 575);
                                     signal cntW: inout std_logic_vector(9 downto 0);
                                     signal fixedPointValW: inout sfixed(7 downto -8);
                                     signal state : inout state_type
                                  ) is
begin
    weightsArray(conv_integer(cntW-1)) <= fixedPointValW;
    state <= incrementCountW;
end procedure;


end package body populateWeightArray_pack;
