library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity enabler is
port (
		ae : in std_logic;
		be : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic
	);
end enabler;

architecture arch of enabler is

	signal control : std_logic;

begin

	control <= not ae and not be;
	
	data_out <=	data_in when (control='1') else
				'Z';
	
end arch;
