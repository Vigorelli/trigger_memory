library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity dual_port_ram_tb is
--  Port ( );
end dual_port_ram_tb;

architecture behavioral of dual_port_ram_tb is

	COMPONENT dual_port_ram
	generic(
		cols: natural;
		rows: natural
		);
	port (
		ce : in std_logic;
		we : in std_logic;
		oe : in std_logic;

		w_addr : in std_logic_vector(rows+cols-1 downto 0);
		o_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic;
          
		o_data : out std_logic
		);
	END COMPONENT;
	
	
	--Inputs
	
	signal ce_sym : std_logic := '0';
	signal we_sym : std_logic := '0';
	signal oe_sym : std_logic := '0';
	
	
	signal w_addr_sym : std_logic_vector(4-1 downto 0) := "0000";
	signal o_addr_sym : std_logic_vector(4-1 downto 0) := "0000";

	signal w_data_sym : std_logic := '0';
	
	--Outputs
	signal o_data_sym : std_logic;
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : dual_port_ram
	generic map(
		cols => 2,
		rows => 2
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
		w_data_sym <= '1';
		
	wait for 50 ns;
		w_addr_sym <= "1000";
		w_data_sym <= '0';
		
	wait for 2 ns;
		o_addr_sym <= "0101";
		
	wait for 50 ns;	--102ns
		o_addr_sym <= "1000";
		
	wait for 40 ns; --142ns
		w_addr_sym <= "0110";
		w_data_sym <= '1';
		
	wait for 4 ns; --146ns
		w_addr_sym <= "0100";
		w_data_sym <= '0';
		
	wait for 40 ns;	--186ns
		o_addr_sym <= "0110";
		
	wait for 20 ns;	--206ns
		o_addr_sym <= "0100";

	
	wait for 40 ns; --246ns
	end process;

end behavioral;
