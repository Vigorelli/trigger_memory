library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity decoder is
generic (size : natural);
port (
		enable : in std_logic; 
		addr : in std_logic_vector(size - 1 downto 0);
		one_hot : out std_logic_vector(2**size - 1 downto 0)
	);
end decoder;


architecture arch of decoder is

begin

	comp_gen:
	for i in 0 to (2**size - 1) generate
		one_hot(i) <= 	'1' when i = unsigned(addr) and enable='1' else
						'0';
	end generate;

end arch;

architecture behav of decoder is

begin

--for!! "think of for as a replicated structure"

	process(addr, enable)
	begin
		for i in 0 to 2**size - 1 loop
			if (unsigned(addr) = i and enable = '1') then
				one_hot(i) <= '1';
			else
				one_hot(i) <= '0';
			end if;
		end loop;
	end process;

end behav;