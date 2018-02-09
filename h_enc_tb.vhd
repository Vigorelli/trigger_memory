library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity h_enc_tb is
--  Port ( );
end h_enc_tb;

architecture behavioral of h_enc_tb is

	COMPONENT h_enc
	port (
		d : in std_logic_vector(14 - 1 downto 0);
		code : out std_logic_vector(19 - 1 downto 0)
	);
	END COMPONENT;
	
	
	--Inputs

	signal d_sym : std_logic_vector(14-1 downto 0);
	
	--Outputs
	signal code_sym : std_logic_vector(19-1 downto 0);
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : h_enc
	port map (
		d => d_sym,
		code => code_sym
	);

   -- Stimulus process
	stim_proc: process
	begin		
			d_sym <= "00000000000000";
		wait for 10 ns;
			d_sym <= "00000000000001";
		wait for 10 ns;
			d_sym <= "00000000000010";
		wait for 10 ns;	--100ns
			d_sym <= "00000000000100";
		wait for 10 ns;
			d_sym <= "00000000001000";
		wait for 10 ns; --140ns
			d_sym <= "00000000010000";
		wait for 10 ns;	--180ns
			d_sym <= "00000000100000";
		wait for 10 ns;
			d_sym <= "00000001000000";
		wait for 10 ns;	--200ns
			d_sym <= "00000010000000";
		wait for 10 ns; --230ns
			d_sym <= "00000100000000";
		wait for 10 ns;
			d_sym <= "00001000000000";
			
-- 		wait for 30 ns; --260ns
-- 			ae_sym <= '0';
-- 
-- 		wait for 40 ns; --300ns
-- 			be_sym <= '1';

		wait for 10 ns; --340ns
	end process;

end behavioral;
