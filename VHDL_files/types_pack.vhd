library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;


-------------------------------------------TYPES_PACK-------------------------------------------
--  Fisierul 'types_pack.vhd' contine declarari ale principalelor structuri de date folosite
--in cadrul proiectului. Entitatile care folosesc aceste tipuri de date (aproape toate) contin
--in antet 'use work.types_pack.all'.
-------------------------------------------------------------------------------------------------

package types_pack is

type FixedPointArray is ARRAY (NATURAL RANGE <>) of sfixed(7 downto -8);
type state_type is (idle,receive,show,verifyFiles,verifyDigit,populateInputArray,computeFixedPoint,saveValue,incrementCount,verifyWeightIndex,
populateWeightArray,computeFixedPointW,saveValueW,compute,incrementCountW,incrementCounterWeight,computeProduct,computeSum,saveAllOutputsValue,final);
type ram_array is array (0 to 12) of std_logic_vector(3 downto 0);
 
   
end package types_pack;

-- Package Body Section
package body types_pack is

end package body types_pack;
