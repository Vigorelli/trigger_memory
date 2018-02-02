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

entity controller_tb is
--  Port ( );
end controller_tb;

architecture behavioral of controller_tb is

	COMPONENT controller
	Port (
		ce : in std_logic;
		owe : in std_logic;
		control : out std_logic
	);
	END COMPONENT;
	
	
	--Inputs

	signal ce_sym : std_logic := '0';
	signal owe_sym : std_logic := '0';
	
	--Outputs
	signal control_sym : std_logic;
	
	-- Clock period definitions
-- 	constant clk_100_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	
	uut : controller
	port map (
		ce => ce_sym,
		owe => owe_sym,
		control => control_sym
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
			ce_sym <= '0';
			owe_sym <= '1';
		wait for 500 ns;
			owe_sym <= '0';

		wait for 500 ns;	

		wait for 40 ns;
			owe_sym <= '1';

		wait for 40 ns;	
			owe_sym <= '0';
			ce_sym <= '1';

		wait for 5 ns;	
			owe_sym <= '1';

		wait for 126 ns;
			ce_sym <= '0';

		wait for 40 ns;	
			owe_sym <= '0';

		wait for 40 ns;
	end process;

end behavioral;
