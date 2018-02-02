library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
Port (
		ce : in std_logic;
		owe : in std_logic;
		control : out std_logic
	);
end controller;

architecture arch of controller is

begin

	control <= not ce and not owe;

end arch;
