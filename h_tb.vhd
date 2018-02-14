library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity h_tb is
--  Port ( );
end h_tb;

architecture behavioral of h_tb is

	COMPONENT h_enc
	port (
		d : in std_logic_vector(14 - 1 downto 0);
		code : out std_logic_vector(19 - 1 downto 0)
	);
	END COMPONENT;

	COMPONENT h_dec
	port (
		code : in std_logic_vector(19 - 1 downto 0);
		corrected : out std_logic_vector(19 - 1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs

	signal d_sym : std_logic_vector(14-1 downto 0);
	
	--Outputs
	signal corrected_sym : std_logic_vector(19-1 downto 0);

	-- IO
	signal pre_code_sym : std_logic_vector(19-1 downto 0);
	signal post_code_sym : std_logic_vector(19-1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	enc_ut : h_enc
	port map (
		d => d_sym,
		code => pre_code_sym
	);

	
	dec_ut : h_dec
	port map (
		code => post_code_sym,
		corrected => corrected_sym
	);

	post_code_sym <= pre_code_sym xor "0000000001000010000";

   -- Stimulus process
	stim_proc: process
	begin		
			d_sym <= "00000000000000";
			
		wait for 10 ns;
			d_sym <= "00000000000001";
		wait for 10 ns;
			d_sym <= "00000000000010";
		wait for 10 ns;
			d_sym <= "00000000000100";
		wait for 10 ns;
			d_sym <= "00000000001000";
		wait for 10 ns;
			d_sym <= "00000000010000";
		wait for 10 ns;
			d_sym <= "00000000100000";
		wait for 10 ns;
			d_sym <= "00000001000000";
		wait for 10 ns;
			d_sym <= "00000010000000";
		wait for 10 ns;
			d_sym <= "00000100000000";
		wait for 10 ns;
			d_sym <= "00001000000000";
			
-- 		wait for 30 ns;
-- 			ae_sym <= '0';
-- 
-- 		wait for 40 ns;
-- 			be_sym <= '1';

		wait for 10 ns;
	end process;

end behavioral;
