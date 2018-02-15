library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity word_ram is
generic(
		cols: natural;
		rows: natural;
		length: natural
		);
port (	
		ce : in std_logic;
		we : in std_logic;
		re : in std_logic;

		w_addr : in std_logic_vector(rows+cols-1 downto 0);
		r_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic_vector(length-1 downto 0);
		
		r_data : out std_logic_vector(length-1 downto 0)
	);
end word_ram;

architecture separate_mems of word_ram is

	signal w_col : std_logic_vector(2**cols - 1 downto 0);
	signal w_row : std_logic_vector(2**rows - 1 downto 0);
	signal r_col : std_logic_vector(2**cols - 1 downto 0);
	signal r_row : std_logic_vector(2**rows - 1 downto 0);

	signal w_array : std_logic_vector(length -1 downto 0);
	signal r_array : std_logic_vector(length -1 downto 0);
	
	
	component keeper
	generic(
		size : natural
	);
	port(
		data_in : in std_logic_vector(size-1 downto 0);
		data_out : out std_logic_vector(size-1 downto 0)
	);
	end component;
		
	component tree_decoder
	generic(
		size : natural;
		cell_width : natural
	);
	port(
		addr: in std_logic_vector(size - 1 downto 0);
		one_hot: out std_logic_vector(2**size - 1 downto 0)
	);
	end component;


	component memory_cell_array
	generic(
		height : natural;
		width : natural
	);
	port(
		r_row : in std_logic_vector(height -1 downto 0);
		r_col : in std_logic_vector(width -1 downto 0);
		w_row : in std_logic_vector(height -1 downto 0);
		w_col : in std_logic_vector(width -1 downto 0);
		w_d : in std_logic;
		r_d : out std_logic
		);
	end component;

	component enabler
	port(
		ae : in std_logic;
		be : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic
		);
	end component;

begin

	w_driver : keeper
	generic map(
		size => length
	)
	port map(
		data_in => w_data,
		data_out => w_array
	);

	w_col_dec : tree_decoder
	generic map(
		size => cols,
		cell_width => 2
	)
	port map(
		enable => ce and we,
		addr => w_addr(rows+cols-1 downto rows),
		one_hot => w_col
	);

	r_col_dec : tree_decoder
	generic map(
		size => cols,
		cell_width => 2
	)
	port map(
		enable => ce and re,
		addr => r_addr(rows+cols-1 downto rows),
		one_hot => r_col
	);
	
	w_row_dec : tree_decoder
	generic map(
		size => rows,
		cell_width => 2
	)
	port map(
		enable => ce and we,
		addr => w_addr(rows-1 downto 0),
		one_hot => w_row
	);

	r_row_dec : tree_decoder
	generic map(
		size => rows,
		cell_width => 2
	)
	port map(
		enable => ce and re,
		addr => r_addr(rows-1 downto 0),
		one_hot => r_row
	);

	
	
	word_memory:
	for i in 0 to (length-1) generate

-- 		r_enabler : enabler
-- 		port map(
-- 			ae => ce,
-- 			be => re,
-- 			data_in => r_array(i),
-- 			data_out => r_data(i)
-- 		);
-- 
-- 		w_enabler : enabler
-- 		port map(
-- 			ae => ce,
-- 			be => we,
-- 			data_in => w_data(i),
-- 			data_out => w_array(i)
-- 		);

		cell_array : memory_cell_array
		generic map(
			height => 2**rows,
			width => 2**cols
		)
		port map(
			r_row => r_row,
			r_col => r_col,
			w_row => w_row,
			w_col => w_col,
			w_d => w_array(i),
			r_d => r_array(i)
		);
	end generate;

	
end separate_mems;
