library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;


entity h_dec is
port (
		code : in std_logic_vector(19 - 1 downto 0);
		corrected : out std_logic_vector(19 - 1 downto 0)
	);
end h_dec;


architecture arch of h_dec is
	
	component decoder
	generic(
		size : natural
	);
	port(
		enable : in std_logic;
		addr: in std_logic_vector(size - 1 downto 0);
		one_hot: out std_logic_vector(2**size - 1 downto 0)
	);
	end component;
	
	signal p : std_logic_vector(4 downto 0);
	signal s : std_logic_vector(4 downto 0);
	signal corr : std_logic_vector(31 downto 0);
			
begin

	p(0) <= code(2) xor code(4) xor code(6) xor code(8) xor code(10) xor code(12) xor code(14) xor code(16) xor code(18);
	p(1) <= code(2) xor code(5) xor code(6) xor code(9) xor code(10) xor code(13) xor code(14) xor code(17) xor code(18);
	p(2) <= code(4) xor code(5) xor code(6) xor code(11) xor code(12) xor code(13) xor code(14);
	p(3) <= code(8) xor code(9) xor code(10) xor code(11) xor code(12) xor code(13) xor code(14); 
	p(4) <= code(16) xor code(17) xor code(18);
	
	s(0) <= p(0) xor code(0);
	s(1) <= p(1) xor code(1);
	s(2) <= p(2) xor code(3);
	s(3) <= p(3) xor code(7);
	s(4) <= p(4) xor code(15);
	
	syndrome_decoder : decoder
	generic map(
		size => 5
	)
	port map(
		enable => '1',
		addr => s,
		one_hot => corr
	);
	
	corrected <= code xor corr(19 - 1 downto 0);
	
	 
-- 	code(0) <= d(0) xor d(1) xor d(3) xor d(4) xor d(6) xor d(8) xor d(10) xor d(11) xor d(13);
-- 	code(1) <= d(0) xor d(2) xor d(3) xor d(5) xor d(6) xor d(9) xor d(10) xor d(12) xor d(13);
-- 	code(2) <= d(0);
-- 	code(3) <= d(1) xor d(2) xor d(3) xor d(7) xor d(8) xor d(9) xor d(10);
-- 	code(4) <= d(1);
-- 	code(5) <= d(2);
-- 	code(6) <= d(3);
-- 	code(7) <= d(4) xor d(5) xor d(6) xor d(7) xor d(8) xor d(9) xor d(10);
-- 	code(8) <= d(4);
-- 	code(9) <= d(5);
-- 	code(10) <= d(6);
-- 	code(11) <= d(7);
-- 	code(12) <= d(8);
-- 	code(13) <= d(9);
-- 	code(14) <= d(10);
-- 	code(15) <= d(11) xor d(12) xor d(13);
-- 	code(16) <= d(11);
-- 	code(17) <= d(12);
-- 	code(18) <= d(13);
-- 	
	
-- 	bit_code_gen:
-- 	for i in 0 to (19 - 1) generate
-- 	
-- 	end generate;
	
end arch;
