library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity priority_enc is
port (
		flag : in std_logic_vector(4-1 downto 0); 
		block_flag : out std_logic;
		b : out std_logic_vector(2 - 1 downto 0)
	);
end priority_enc;

architecture arch of priority_enc is

	signal pre_b1 : std_logic;

begin

	block_flag <= flag(0) or flag(1) or pre_b1;

	pre_b1 <= flag(3) or flag(2);
	b(1) <= pre_b1;

	b(0) <= flag(3) or (flag(1) and (not flag(2)));
	
	
	
-- 	comp_gen:
-- 	for i in 0 to (2**size - 1) generate
-- 		one_hot(i) <= 	'1' when i = unsigned(addr) and enable='1' else
-- 						'0';
-- 	end generate;

end arch;