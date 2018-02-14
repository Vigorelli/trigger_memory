library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;


entity hd_enc is
port (
		d: in std_logic_vector(14 - 1 downto 0);
		code: out std_logic_vector(20 - 1 downto 0)
	);
end hd_enc;


architecture arch of hd_enc is

	 signal p : std_logic_vector(4 downto 0);

begin

	code(0) <= p(0);
	p(0) <= d(0) xor d(1) xor d(3) xor d(4) xor d(6) xor d(8) xor d(10) xor d(11) xor d(13);
	code(1) <= p(1);
	p(1) <= d(0) xor d(2) xor d(3) xor d(5) xor d(6) xor d(9) xor d(10) xor d(12) xor d(13);
	code(2) <= d(0);
	code(3) <= p(2);
	p(2) <= d(1) xor d(2) xor d(3) xor d(7) xor d(8) xor d(9) xor d(10);
	code(4) <= d(1);
	code(5) <= d(2);
	code(6) <= d(3);
	code(7) <= p(3);
	p(3) <= d(4) xor d(5) xor d(6) xor d(7) xor d(8) xor d(9) xor d(10);
	code(8) <= d(4);
	code(9) <= d(5);
	code(10) <= d(6);
	code(11) <= d(7);
	code(12) <= d(8);
	code(13) <= d(9);
	code(14) <= d(10);
	code(15) <= p(4);
	p(4) <= d(11) xor d(12) xor d(13);
	code(16) <= d(11);
	code(17) <= d(12);
	code(18) <= d(13);
	code(19) <= d(0) xor d(1) xor d(2) xor d(3) xor d(4) xor d(5) xor d(6) xor d(7) xor d(8) xor d(9) xor d(10) xor d(11) xor d(12) xor d(13) xor p(0) xor p(1) xor p(2) xor p(3) xor p(4);
	
-- 	bit_code_gen:
-- 	for i in 0 to (19 - 1) generate
-- 	
-- 	end generate;
	
end arch;
