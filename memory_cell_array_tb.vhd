library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity memory_cell_array_tb is
--  Port ( );
end memory_cell_array_tb;

architecture behavioral of memory_cell_array_tb is

	COMPONENT memory_cell_array
	generic(
		height: natural;
		width: natural
		);
	port (
		o_row : in std_logic_vector(height-1 downto 0);
		o_col : in std_logic_vector(width-1 downto 0);
		w_row : in std_logic_vector(height-1 downto 0);
		w_col : in std_logic_vector(width-1 downto 0);

		w_d : in std_logic;
		o_d : out std_logic
		);
	END COMPONENT;
	
	
	--Inputs
	signal o_row_sym : std_logic_vector(4-1 downto 0);
	signal o_col_sym : std_logic_vector(4-1 downto 0);
	signal w_row_sym : std_logic_vector(4-1 downto 0);
	signal w_col_sym : std_logic_vector(4-1 downto 0);

	signal w_d_sym : std_logic;
	
	--Outputs
	signal o_d_sym : std_logic;
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : memory_cell_array
	generic map(
		height => 4,
		width => 4
	)
	port map (
		o_row => o_row_sym,
		o_col => o_col_sym, 
		w_row => w_row_sym,
		w_col => w_col_sym,

		w_d => w_d_sym,
		o_d => o_d_sym
	);

   -- Stimulus process
	stim_proc: process
	begin		
			w_row_sym <= "0100";
			w_col_sym <= "0010";
			w_d_sym <= '1';
		wait for 50 ns;
			w_row_sym <= "1000";
			w_col_sym <= "0010";
			w_d_sym <= '0';
		wait for 2 ns;
			o_row_sym <= "0100";
			o_col_sym <= "0010";
		wait for 50 ns;	--102ns
			o_row_sym <= "1000";
			o_col_sym <= "0010";
		wait for 40 ns; --142ns
			w_row_sym <= "0100";
			w_col_sym <= "0010";
			w_d_sym <= '0';
		wait for 4 ns; --146ns
			w_row_sym <= "0100";
			w_col_sym <= "0100";
			w_d_sym <= '0';
		wait for 40 ns;	--186ns
			o_row_sym <= "0100";
			o_col_sym <= "0010";
		wait for 20 ns;	--206ns
			o_row_sym <= "0100";
			o_col_sym <= "0100";


--		wait for 30 ns; --230ns
			
-- 		wait for 30 ns; --260ns
-- 			ae_sym <= '0';
-- 
-- 		wait for 40 ns; --300ns
-- 			be_sym <= '1';

		wait for 40 ns; --246ns
	end process;

end behavioral;
