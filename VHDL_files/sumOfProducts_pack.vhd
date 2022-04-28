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



package sumOfProducts_pack is

procedure computeState (signal countOutput : inout std_logic_vector(9 downto 0);
                        signal sumaAux : inout sfixed(7 downto -8);
                        signal suma : inout sfixed(7 downto -8);
                        signal state : inout state_type;
                        signal outputt : inout FixedPointArray (0 to 9);
                        signal allOutputs : inout FixedPointArray (0 to 129);
                        signal counter2 : inout std_logic_vector (3 downto 0);
                        signal counter3 : inout std_logic_vector (7 downto 0);
                        signal maxValue: inout sfixed(7 downto -8);
                        signal labelMax : inout std_logic_vector (3 downto 0)
                    );
procedure computeProductState ( signal produs: inout sfixed(7 downto -8);
                                signal inputArray : inout FixedPointArray (0 to 575);
                                signal countOutput : inout std_logic_vector(9 downto 0);
                                signal weightsArray : inout FixedPointArray (0 to 575);
                                signal state : inout state_type
                    );
                    
procedure computeSumState ( signal suma : inout sfixed(7 downto -8);
                            signal produs: inout sfixed(7 downto -8);
                            signal sumaAux : inout sfixed(7 downto -8);
                            signal countOutput : inout std_logic_vector(9 downto 0);
                            signal state : inout state_type
                    );
 
procedure saveAllOutputsValueState (signal allOutputs : inout FixedPointArray (0 to 129);
                                    signal counter3 : inout std_logic_vector (7 downto 0);
                                    signal suma : inout sfixed(7 downto -8);           
                                    signal state : inout state_type
                    );
 
   
end package sumOfProducts_pack;

-- Package Body Section
package body sumOfProducts_pack is

--Procedura 'computeState' are rolul de a tranzitiona catre starea computeProduct daca nu au fost realizate inmultirile input-urilor cu weights-urile 
--corespunzatoare, sau de a salva output-ul corespunzator valorii variabilei counter2, in cazul in care s-a realizat suma tuturor celor 576 de produse
--Daca suma este mai mare decat valoarea maxima inregistrata de output-urile uneia dintre cifrele de input, atunci acea valoare va deveni maxValue.
--Exemplu: Pentru prima cifra din CNP (cifra 2), al treilea output (output 2) va avea valoarea cea mai mare. Variabila labelMax are scopul de a 
--salva indexul valorii maxime.

procedure computeState( signal countOutput : inout std_logic_vector(9 downto 0);
                        signal sumaAux : inout sfixed(7 downto -8);
                        signal suma : inout sfixed(7 downto -8);
                        signal state : inout state_type;
                        signal outputt : inout FixedPointArray (0 to 9);
                        signal allOutputs : inout FixedPointArray (0 to 129);
                        signal counter2 : inout std_logic_vector (3 downto 0);
                        signal counter3 : inout std_logic_vector (7 downto 0);
                        signal maxValue: inout sfixed(7 downto -8);
                        signal labelMax : inout std_logic_vector (3 downto 0)                  
                    ) is
begin
    if countOutput <= 575 then
        sumaAux <= suma;
        state <= computeProduct;
    else
        outputt(conv_integer(counter2)) <= suma;
        if suma > maxValue then
            maxValue <= suma;
            labelMax <= counter2;
        end if;
        state <= saveAllOutputsValue;
    end if;  
end procedure;

--Procedura 'computeProductState' are rolul de a inmulti input-ul de la indexul countOutput cu weight-ul de la indexul countOutput, iar rezultatul
--va fi stocat in variabila produs.

procedure computeProductState(  signal produs: inout sfixed(7 downto -8);
                                signal inputArray : inout FixedPointArray (0 to 575);
                                signal countOutput : inout std_logic_vector(9 downto 0);
                                signal weightsArray : inout FixedPointArray (0 to 575);
                                signal state : inout state_type                  
                    ) is
begin
    produs <= resize(arg=>(inputArray(conv_integer(countOutput)) * weightsArray(conv_integer(countOutput))),size_res=>produs,overflow_style=>fixed_saturate,round_style=>fixed_round);
    state <= computeSum;  
end procedure;

--Procedura 'computeSumState' are rolul de a aduna la suma corespunzatoare unui output, produsul corespunzator inmultirii dintre input-ul de la 
--indexul countOutput si weights-ului de la indexul countOutput.

procedure computeSumState( signal suma : inout sfixed(7 downto -8);
                           signal produs: inout sfixed(7 downto -8);
                           signal sumaAux : inout sfixed(7 downto -8);
                           signal countOutput : inout std_logic_vector(9 downto 0);
                           signal state : inout state_type             
                    ) is
begin
    suma <= resize(arg=>(produs + sumaAux),size_res=>suma,overflow_style=>fixed_saturate,round_style=>fixed_round);
    countOutput <= countOutput + 1;
    state <= compute;  
end procedure;

--Procedura 'saveAllOutputsValueState' are menirea de a salva output-ul pentru fiecare cifra in array-ul allOutputs (FixedPointArray). Astfel,
--allOutputs va avea 130 de output-uri (13 cifre in CNP, fiecare cu cate 10 output-uri, de la 0 la 9)

procedure saveAllOutputsValueState( signal allOutputs : inout FixedPointArray (0 to 129);                                    
                                    signal counter3 : inout std_logic_vector (7 downto 0);
                                    signal suma : inout sfixed(7 downto -8);
                                    signal state : inout state_type                  
                    ) is
begin
    allOutputs(conv_integer(counter3)) <= suma;
    counter3 <= counter3 + 1; 
    state <= incrementCounterWeight; 
end procedure;



end package body sumOfProducts_pack;
