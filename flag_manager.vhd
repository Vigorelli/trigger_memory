library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity flag_manager is
port (
		clock :in std_logic;
		flag : in std_logic_vector(16-1 downto 0); 
		read_flag : out std_logic;
		read_addr : out std_logic_vector(4 - 1 downto 0)
	);
end flag_manager;

architecture arch of flag_manager is
	
	component priority_enc
	port(
		flag : in std_logic_vector(4-1 downto 0); 
		block_flag : out std_logic;
		b : out std_logic_vector(2 - 1 downto 0)
	);
	end component;

	signal flag_1 : std_logic_vector(4-1 downto 0);
	signal flag_2 : std_logic;
	signal b_1 : std_logic_vector(8-1 downto 0);
	signal b_2 : std_logic_vector(2-1 downto 0);

begin

	pc_start: process(clock)
	begin
		if rising_edge(clock) then
			read_flag <= flag_2;
			--o_start <= i_start;
			--if i_start = '1' and o_start = '0' and engaged = '0' and pre_ready = '0' then
			--	c_start <= counter;
			--	engaged <= '1';
			--end if;
		end if;
	end process;

	
	comp_gen:
 	for i in 0 to 3 generate
		
		enc : priority_enc
		port map (
			flag => flag(4*i+3 downto 4*i),
			block_flag => flag_1(i),
			b => b_1(i*2+1 downto i*2)
		);
		
	end generate;
	
	enc_f : priority_enc
	port map (
		flag => flag_1,
		block_flag => flag_2,
		b => b_2
	);
	
	--read_flag <= flag_2;
	read_addr(3 downto 2) <= b_2;
	read_addr(1 downto 0) <= b_1(7 downto 6) when (b_2 = "11") else
							 b_1(5 downto 4) when (b_2 = "10") else
							 b_1(3 downto 2) when (b_2 = "01") else
							 b_1(1 downto 0);
	
	
end arch;