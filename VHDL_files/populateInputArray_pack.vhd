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



package populateInputArray_pack is

procedure verifyDigitState (signal counter1 :inout std_logic_vector (3 downto 0);
                            signal state : inout state_type
                    ); 
                    
procedure populateInputArrayState (variable pos_slv : inout integer;
                                   variable pos_sfixed : inout integer;
                                   signal count : inout std_logic_vector(12 downto 0);
                                   variable rightI : inout integer;
                                   signal addressInputs : inout std_logic_vector(12 downto 0);
                                   signal valInput: inout std_logic_vector (15 downto 0);
                                   signal doutInputs: std_logic_vector (15 downto 0);
                                   signal state : inout state_type
                    ); 
                    
procedure computeFixedPointState  (variable pos_slv : inout integer;
                                   signal state : inout state_type;
                                   signal valInput: inout std_logic_vector (15 downto 0);
                                   signal fixedPointVal: inout sfixed(7 downto -8);
                                   variable pos_sfixed : inout integer
                    ); 
                    
procedure saveValueState(signal inputArray : inout FixedPointArray (0 to 575);
                         signal cntI : inout std_logic_vector(9 downto 0);
                         signal fixedPointVal: inout sfixed(7 downto -8);
                         signal state : inout state_type
                    ); 
   
end package populateInputArray_pack;

-- Package Body Section
package body populateInputArray_pack is

--Procedura 'verifyDigitState' verifica valoarea variabile counter1, folosite pentru a marca indexul cifrei din CNP care este introdusa in
--reteaua neuronala artificiala. De ex. pentru CNP (2760429264382), daca cifra 7 este cea introdusa in ANN, valoarea counter1 va fi 1. 
--Daca counter1 are valoarea 13, inseamna ca toate cifrele au fost introduse in ANN, iar automatul va comuta in ultima stare (finala).
--Altfel, se va comuta in starea 'populateInputArray'. 

procedure verifyDigitState(
                    signal counter1 :inout std_logic_vector (3 downto 0);
                    signal state : inout state_type
                    ) is
begin
    if counter1 = 13 then
        state <= final;
    else
        state <= populateInputArray;
     end if; 
end procedure;

--Procedura 'populateInputArrayState' preia vectorul de input de la adresa addressInputs si il salveaza in valInput. Adresa de input este 
--determinata de valoarea variabile count. Se face tranzitia catre starea 'computeFixedPoint'. 

procedure populateInputArrayState(
                                   variable pos_slv : inout integer;
                                   variable pos_sfixed : inout integer;
                                   signal count : inout std_logic_vector(12 downto 0);
                                   variable rightI : inout integer;
                                   signal addressInputs : inout std_logic_vector(12 downto 0);
                                   signal valInput: inout std_logic_vector (15 downto 0);
                                   signal doutInputs: std_logic_vector (15 downto 0);
                                   signal state : inout state_type
                                  ) is
begin
    pos_slv := 15;
    pos_sfixed := 7;
    if count <= rightI then
       addressInputs <= count;
       valInput(15 downto 0) <= doutInputs(15 downto 0);
       state <= computeFixedPoint;  
    end if; 
end procedure;

--Procedura 'computeFixedPointState' are rolul de a converti valoarea din vectorul valInput, care este std_logic_vector(15 downto 0),
--intr-un vector de tipul fixed point (7 downto -8). Pozitia 15 din vectorul std_logic_vector corespunde pozitiei 7 din fixed point vector,
--iar aceasta se decrementeaza, pana cand se ajunge la pozitia 0 in std_logic_vector, respectiv pozitia -8 din fixed point vector.
--In vectorul fixed point, pozitiile de la 7 la 0 sunt alocate partii intregi, iar pozitiile -1 pana la -8 sunt alocate partii fractionale.
--Astfel, valoarea 1.5 va fi reprezentata ca 0000 0001 1000 0000, unde 0000 0001 este partea intreaga, si 1000 0000 este partea fractionala.
--In momentul in care vectorul fixed point este populat, se va trece la starea saveValue.  

procedure computeFixedPointState(
                                   variable pos_slv : inout integer;
                                   signal state : inout state_type;
                                   signal valInput: inout std_logic_vector (15 downto 0);
                                   signal fixedPointVal: inout sfixed(7 downto -8);
                                   variable pos_sfixed : inout integer
                                  ) is
begin
    if pos_slv < 0 then 
        state <= saveValue;
    else
        if valInput(pos_slv) = '0' then
            fixedPointVal(pos_sfixed) <= '0';
        else
            fixedPointVal(pos_sfixed) <= '1'; 
        end if; 
        pos_slv := pos_slv - 1;
        pos_sfixed := pos_sfixed - 1;
        state <= computeFixedPoint;   
    end if;    
end procedure;

--Procedurea 'saveValueState' are menirea de a salva vectorul fixed point in array-ul de fixed point values, numit inputArray, la pozitia 
--determinata de valoarea cntI. 

procedure saveValueState(
                         signal inputArray : inout FixedPointArray (0 to 575);
                         signal cntI : inout std_logic_vector(9 downto 0);
                         signal fixedPointVal: inout sfixed(7 downto -8);
                         signal state : inout state_type
                    ) is
begin
    inputArray(conv_integer(cntI-1)) <= fixedPointVal;
    state <= incrementCount;
end procedure;



end package body populateInputArray_pack;
