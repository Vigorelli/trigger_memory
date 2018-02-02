
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity tree_decoder_tb is
--  Port ( );
end tree_decoder_tb;

architecture behavioral of tree_decoder_tb is

	COMPONENT tree_decoder
	generic(
		size : natural;
		cell_width : natural
	);
	port (
		addr: in std_logic_vector(size - 1 downto 0);
		one_hot: out std_logic_vector(2**size - 1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs

	signal addr_sym : std_logic_vector(4-1 downto 0);
	
	--Outputs
	signal one_hot_sym : std_logic_vector(2**4 - 1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : tree_decoder
	generic map(
		size => 4,
		cell_width => 2
	)
	port map (
		addr => addr_sym,
		one_hot => one_hot_sym
	);

   -- Stimulus process
	stim_proc: process
	begin		
			addr_sym <= "0000";
		wait for 50 ns;
			addr_sym <= "1000";
		wait for 50 ns;	--100ns
			addr_sym <= "0100";
		wait for 40 ns; --140ns
			addr_sym <= "1100";
		wait for 40 ns;	--180ns
			addr_sym <= "0101";
		wait for 20 ns;	--200ns
			addr_sym <= "0111";
		wait for 30 ns; --230ns
			addr_sym <= "1001";
			
-- 		wait for 30 ns; --260ns
-- 			ae_sym <= '0';
-- 
-- 		wait for 40 ns; --300ns
-- 			be_sym <= '1';

		wait for 40 ns; --340ns
	end process;

end behavioral;
