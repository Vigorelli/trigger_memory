library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity word_ram_tb is
--  Port ( );
end word_ram_tb;

architecture behavioral of word_ram_tb is

	COMPONENT word_ram
	generic(
		cols: natural;
		rows: natural;
		length: natural
		);
	port (
		ce : in std_logic;
		we : in std_logic;
		oe : in std_logic;

		w_addr : in std_logic_vector(rows+cols-1 downto 0);
		o_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic_vector(length - 1 downto 0);
          
		o_data : out std_logic_vector(length - 1 downto 0)
		);
	END COMPONENT;
	
	
	--Inputs
	
	signal ce_sym : std_logic := '0';
	signal we_sym : std_logic := '0';
	signal oe_sym : std_logic := '0';
	
	
	signal w_addr_sym : std_logic_vector(4-1 downto 0) := "0000";
	signal o_addr_sym : std_logic_vector(4-1 downto 0) := "0000";

	signal w_data_sym : std_logic_vector(3-1 downto 0) := "000";
	
	--Outputs
	signal o_data_sym : std_logic_vector(3-1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : word_ram
	generic map(
		cols => 2,
		rows => 2,
		length => 3
	)
	port map (
		ce => ce_sym,
		we => we_sym,
		oe => oe_sym,
		
		w_addr => w_addr_sym,
		o_addr => o_addr_sym,
		
		w_data => w_data_sym,
		o_data => o_data_sym
	);

   -- Stimulus process
	stim_proc: process
	begin
		ce_sym <= '1';
		we_sym <= '1';
		oe_sym <= '1';
		w_addr_sym <= "0101";
		w_data_sym <= "100";
		
	wait for 50 ns;
		w_addr_sym <= "1000";
		w_data_sym <= "000";
		
	wait for 2 ns;
		o_addr_sym <= "0101";
		
	wait for 50 ns;	--102ns
		o_addr_sym <= "1000";
		
	wait for 40 ns; --142ns
		w_addr_sym <= "0110";
		w_data_sym <= "010";
		
	wait for 4 ns; --146ns
		w_addr_sym <= "0100";
		w_data_sym <= "001";
		
	wait for 40 ns;	--186ns
		o_addr_sym <= "0110";
		
	wait for 20 ns;	--206ns
		o_addr_sym <= "0100";

	
	wait for 40 ns; --246ns
	end process;

end behavioral;
