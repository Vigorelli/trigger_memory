library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity flag_manager_tb is
--  Port ( );
end flag_manager_tb;

architecture behavioral of flag_manager_tb is

	COMPONENT flag_manager
	port (
		clock :in std_logic;
		flag : in std_logic_vector(16-1 downto 0); 
		read_flag : out std_logic;
		read_addr : out std_logic_vector(4 - 1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs
	signal clk_100 : std_logic := '0';
	signal flag_sym : std_logic_vector(16-1 downto 0);
	signal read_flag_sym : std_logic;
	
	--Outputs
	signal read_addr_sym : std_logic_vector(4-1 downto 0);
	
	-- Clock period definitions
 	constant clk_100_period : time := 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut : flag_manager
	port map (
		clock => clk_100,
		flag => flag_sym,
		read_flag => read_flag_sym,
		read_addr => read_addr_sym
	);

	-- Clock process definitions
	clk100_process :process
	begin
			clk_100 <= '1';
		wait for clk_100_period/2;
			clk_100 <= '0';
		wait for clk_100_period/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin		
			flag_sym <= "0000000000000000";
		wait for 10 ns;
			flag_sym <= "0000000100000000";
		wait for 10 ns;
			flag_sym <= "0010000000000000";
		wait for 10 ns;
			flag_sym <= "0000000000000100";
		wait for 10 ns;
			flag_sym <= "0000100000000000";
		wait for 10 ns;
			flag_sym <= "0000000000000011";
		wait for 10 ns;
			flag_sym <= "0000010100000000";
		wait for 10 ns;
			flag_sym <= "0110000000000000";
		wait for 10 ns;
			flag_sym <= "0000000001110000";
		wait for 10 ns;
			flag_sym <= "1001000000000000";
		wait for 10 ns;
			flag_sym <= "0000101000000000";
		wait for 10 ns;
			flag_sym <= "0000000000001011";
		wait for 10 ns;
			flag_sym <= "0000110000000000";
		wait for 10 ns;
			flag_sym <= "0000000011010000";
		wait for 10 ns;
			flag_sym <= "0000000000001110";
		wait for 10 ns;
			flag_sym <= "0000111100000000";
		wait for 10 ns;
	end process;

end behavioral;