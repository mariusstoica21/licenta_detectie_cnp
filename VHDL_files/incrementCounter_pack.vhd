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



package incrementCounter_pack is

procedure incrementCountState (signal cntI : inout std_logic_vector(9 downto 0);
                               signal state : inout state_type;
                               signal count : inout std_logic_vector(12 downto 0);
                               variable rightI : inout integer       
                    ); 
                    
procedure incrementCountWState (signal countW : inout std_logic_vector(12 downto 0);
                                variable rightW : inout integer;  
                                signal state : inout state_type;
                                signal cntW: inout std_logic_vector(9 downto 0)    
                    ); 
                    
procedure incrementCounterWeightState(signal counter2 : inout std_logic_vector (3 downto 0);
                                      signal state : inout state_type   
                    ); 
 
   
end package incrementCounter_pack;

-- Package Body Section
package body incrementCounter_pack is

--Procedura 'incrementCountState' are rolul de a tranzitiona in starea populateInputArray in cazul in care array-ul inputArray nu a fost pe deplin
--populat. De exemplu, pentru cifra 2 (prima din CNP), se vor lua primele 576 de input-uri din memoria de inputs si vor fi salvate in inputsArray.
--Odata incheiat procesul pentru cifra 2 (s-au determinat ponderile celor 10 output-uri), se va trece la urmatoarea cifra din CNP, 7, si se va 
--repeta procesul pentru cele 576 de input-uri ale cifrei 7. 

procedure incrementCountState(
                                   signal cntI : inout std_logic_vector(9 downto 0);
                                   signal state : inout state_type;
                                   signal count : inout std_logic_vector(12 downto 0);
                                   variable rightI : inout integer 
                                  ) is
begin
    if cntI = 575 then
        state <= verifyWeightIndex;
        --cntI <= cntI + 1;
        count <= count + 1;
        rightI := rightI + 576;
    else
        count <= count + 1;
        cntI <= cntI + 1;
        state <= populateInputArray;
    end if;     
end procedure;

--Procedura 'incrementCountWState' are rolul de a tranzitiona in starea populateWeightArray in cazul in care array-ul weightsArray nu a fost pe deplin
--populat. De exemplu, pentru output-ul 0 al cifrei 2 (prima din CNP), se vor lua primele 576 de weights-uri din memoria de weights si vor fi salvate 
--in weightsArray. Odata incheiat procesul pentru output-ul 0 al cifrei 2, se va trece la output-ul 1 (urmatoarele 576 weights-uri), pana se ajunge la 
--ultimul output (output 9).

procedure incrementCountWState(
                                signal countW : inout std_logic_vector(12 downto 0);
                                variable rightW : inout integer;  
                                signal state : inout state_type;
                                signal cntW: inout std_logic_vector(9 downto 0)    
                                  ) is
begin
    if countW = rightW then
        state <= compute;
        countW <= countW + 1;
        cntW <= cntW + 1;
        rightW := rightW + 576;
    else
        countW <= countW + 1;
        cntW <= cntW + 1;
        state <= populateWeightArray;
    end if;    
end procedure;

--Procedurea 'incrementCounterWeightState' incrementeaza variabila counter2 (corespunzatoare index-ului output-ului care se vrea a fi calculat).
--De exemplu, daca pentru cifra 2 am calculat output 0, atunci counter2 se va incrementa, pentru a putea calcula output 1.

procedure incrementCounterWeightState(
                                      signal counter2 : inout std_logic_vector (3 downto 0);
                                      signal state : inout state_type    
                                  ) is
begin
    counter2 <= counter2 + 1;
    state <= verifyWeightIndex; 
end procedure;



end package body incrementCounter_pack;
