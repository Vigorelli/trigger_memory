library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

entity hd_dec is
port (
		code : in std_logic_vector(20 - 1 downto 0);
		corrected : out std_logic_vector(20 - 1 downto 0);
		err : out std_logic
	);
end hd_dec;


architecture arch of hd_dec is
	
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
	
	signal p : std_logic_vector(5 downto 0);
	signal s : std_logic_vector(4 downto 0);
	signal corr : std_logic_vector(31 downto 0);
--	signal pre_corr : std_logic_vector(20-1 downto 0);
--	signal correction : std_logic;
			
begin

	p(0) <= code(2) xor code(4) xor code(6) xor code(8) xor code(10) xor code(12) xor code(14) xor code(16) xor code(18);
	p(1) <= code(2) xor code(5) xor code(6) xor code(9) xor code(10) xor code(13) xor code(14) xor code(17) xor code(18);
	p(2) <= code(4) xor code(5) xor code(6) xor code(11) xor code(12) xor code(13) xor code(14);
	p(3) <= code(8) xor code(9) xor code(10) xor code(11) xor code(12) xor code(13) xor code(14); 
	p(4) <= code(16) xor code(17) xor code(18);
	p(5) <= code(0) xor code(1) xor code(2) xor code(3) xor code(4) xor code(5) xor code(6) xor code(7) xor code(8) xor code(9) xor code(10) xor code(11) xor code(12) xor code(13) xor code(14) xor code(15) xor code(16) xor code(17) xor code(18);
	
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
		addr => s(4 downto 0),
		one_hot => corr
	);
	
	corrected(18 downto 0) <= code(18 downto 0) xor corr(19 downto 1);
	--pre_corr(19) <= pre_corr(0) xor pre_corr(1) xor pre_corr(2) xor pre_corr(3) xor pre_corr(4) xor pre_corr(5) xor pre_corr(6) xor pre_corr(7) xor pre_corr(8) xor pre_corr(9) xor pre_corr(10) xor pre_corr(11) xor pre_corr(12) xor pre_corr(13) xor pre_corr(14) xor pre_corr(15) xor pre_corr(16) xor pre_corr(17) xor pre_corr(18);
	
--	corrected <= pre_corr;
--	correction <= not (corr(0));
	err <= (not corr(0)) and (not(code(19) xor p(5)));
	corrected(19) <= p(5) xor (not corr(0));
end arch;
