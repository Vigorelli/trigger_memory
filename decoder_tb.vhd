library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity decoder_tb is
--  Port ( );
end decoder_tb;

architecture behavioral of decoder_tb is

	COMPONENT decoder
	generic(size : natural);
	port (
		enable : in std_logic;
		addr : in std_logic_vector(size - 1 downto 0);
		one_hot : out std_logic_vector(2**size - 1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs

	signal addr_sym : std_logic_vector(2-1 downto 0);
	signal enable_sym : std_logic;
	
	--Outputs
	signal one_hot_sym : std_logic_vector(2**2 - 1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : decoder
	generic map(size => 2)
	port map (
		enable => enable_sym,
		addr => addr_sym,
		one_hot => one_hot_sym
	);

   -- Stimulus process
	stim_proc: process
	begin		
			addr_sym <= "00";
			enable_sym <= '1';
		wait for 50 ns;
			addr_sym <= "10";
		wait for 50 ns;	--100ns
			enable_sym <= '0';
			addr_sym <= "01";
		wait for 40 ns; --140ns
			addr_sym <= "11";
		wait for 40 ns;	--180ns
			enable_sym <= '1';
			addr_sym <= "01";
		wait for 20 ns;	--200ns
			addr_sym <= "00";
		wait for 30 ns; --230ns
			enable_sym <= '0';
			addr_sym <= "10";
			
-- 		wait for 30 ns; --260ns
-- 			ae_sym <= '0';
-- 
-- 		wait for 40 ns; --300ns
-- 			be_sym <= '1';

		wait for 40 ns; --340ns
	end process;

end behavioral;
