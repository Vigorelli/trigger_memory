library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity priority_enc_tb is
--  Port ( );
end priority_enc_tb;

architecture behavioral of priority_enc_tb is

	COMPONENT priority_enc
	port (
		flag : in std_logic_vector(4-1 downto 0);
		block_flag : out std_logic;
		b : out std_logic_vector(2-1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs

	signal flag_sym : std_logic_vector(4-1 downto 0);
	signal block_flag_sym : std_logic;
	
	--Outputs
	signal b_sym : std_logic_vector(2-1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : priority_enc
	port map (
		flag => flag_sym,
		block_flag => block_flag_sym,
		b => b_sym
	);

   -- Stimulus process
	stim_proc: process
	begin		
			flag_sym <= "0000";
		wait for 10 ns;
			flag_sym <= "0001";
		wait for 10 ns;
			flag_sym <= "0010";
		wait for 10 ns;
			flag_sym <= "0100";
		wait for 10 ns;
			flag_sym <= "1000";
		wait for 10 ns;
			flag_sym <= "0011";
		wait for 10 ns;
			flag_sym <= "0101";
		wait for 10 ns;
			flag_sym <= "0110";
		wait for 10 ns;
			flag_sym <= "0111";
		wait for 10 ns;
			flag_sym <= "1001";
		wait for 10 ns;
			flag_sym <= "1010";
		wait for 10 ns;
			flag_sym <= "1011";
		wait for 10 ns;
			flag_sym <= "1100";
		wait for 10 ns;
			flag_sym <= "1101";
		wait for 10 ns;
			flag_sym <= "1110";
		wait for 10 ns;
			flag_sym <= "1111";
		wait for 10 ns;
	end process;

end behavioral;