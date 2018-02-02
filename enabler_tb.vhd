----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2015 04:59:21 PM
-- Design Name: 
-- Module Name: TDC_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity enabler_tb is
--  Port ( );
end enabler_tb;

architecture behavioral of enabler_tb is

	COMPONENT enabler
	Port (
		ae : in std_logic;
		be : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic
	);
	END COMPONENT;
	
	
	--Inputs

	signal ae_sym : std_logic := '0';
	signal be_sym : std_logic := '0';
	signal data_in_sym : std_logic := '0';
	
	--Outputs
	signal data_out_sym : std_logic;
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : enabler
	port map (
		ae => ae_sym,
		be => be_sym,
		data_in => data_in_sym,
		data_out => data_out_sym
	);

	--Clock process definitions
-- 	clk100_process :process
-- 	begin
-- 			clk_100 <= '1';
-- 		wait for clk_100_period/2;
-- 			clk_100 <= '0';
-- 		wait for clk_100_period/2;
-- 	end process;
--  
    -- Clock process definitions
--   clk40_process :process
--   begin
--		clk40 <= '1';
--		wait for clk40_period/2;
--		clk40 <= '0';
--		wait for clk40_period/2;
--   end process;

   -- Stimulus process
	stim_proc: process
	begin		
			ae_sym <= '0';
			be_sym <= '1';
		wait for 50 ns;
			ae_sym <= '1';
			data_in_sym <= '1';
		wait for 50 ns;	--100ns
			ae_sym <= '0';
			be_sym <= '0';
		wait for 40 ns; --140ns
			be_sym <= '1';

		wait for 40 ns;	--180ns
			be_sym <= '0';
			data_in_sym <= '0';

		wait for 20 ns;	--200ns
			ae_sym <= '1';
			
		wait for 30 ns; --230ns
			data_in_sym <= '1';
			
		wait for 30 ns; --260ns
			ae_sym <= '0';

		wait for 40 ns; --300ns
			be_sym <= '1';

		wait for 40 ns; --340ns
	end process;

end behavioral;
