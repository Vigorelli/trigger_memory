library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity 19_bit_h_word_ram is
generic(
		cols: natural;
		rows: natural;
		);
port (	
		ce : in std_logic;
		we : in std_logic;
		re : in std_logic;

--address shouldn't be necessary
--		w_addr : in std_logic_vector(rows+cols-1 downto 0);
--		r_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic_vector(19-1 downto 0);
		
		r_data : out std_logic_vector(19-1 downto 0)
	);
end 19_bit_h_word_ram;

architecture arch of 19_bit_h_word_ram is

	signal w_col : std_logic_vector(2**cols - 1 downto 0);
	signal w_row : std_logic_vector(2**rows - 1 downto 0);
	signal r_col : std_logic_vector(2**cols - 1 downto 0);
	signal r_row : std_logic_vector(2**rows - 1 downto 0);

	signal w_array : std_logic_vector(length -1 downto 0);
	signal r_array : std_logic_vector(length -1 downto 0);
	
	
	component word_ram
	generic(
		cols: natural;
		rows: natural;
		length: natural
		);
	port(
		ce : in std_logic;
		we : in std_logic;
		re : in std_logic;

		w_addr : in std_logic_vector(rows+cols-1 downto 0);
		r_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic_vector(length - 1 downto 0);
          
		r_data : out std_logic_vector(length - 1 downto 0)
		);
	end component;
	
	component 19_h_encoder
	
	port(
		
	
begin
	
	19_ram : word_ram
	generic map(
		cols => cols,
		rows => rows,
		length => 19
	)
	port map(
		ce => ce,
		we => we,
		re => re,
		
		
		
	);
	
	
	
end arch;
