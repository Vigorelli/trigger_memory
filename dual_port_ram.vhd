library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity dual_port_ram is
generic(
		cols: natural;
		rows: natural
	);
port (	
		ce : in std_logic;
		we : in std_logic;
		oe : in std_logic;

		w_addr : in std_logic_vector(rows+cols-1 downto 0);
		o_addr : in std_logic_vector(rows+cols-1 downto 0);

		w_data : in std_logic;
          
		o_data : out std_logic
	);
end dual_port_ram;

architecture arch of dual_port_ram is

	signal w_col : std_logic_vector(2**cols - 1 downto 0);
	signal w_row : std_logic_vector(2**rows - 1 downto 0);
	signal o_col : std_logic_vector(2**cols - 1 downto 0);
	signal o_row : std_logic_vector(2**rows - 1 downto 0);

	signal w_array : std_logic;
	signal o_array : std_logic;
	
	
	component decoder
	generic(
		size : natural
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
		o_row : in std_logic_vector(height -1 downto 0);
		o_col : in std_logic_vector(width -1 downto 0);
		w_row : in std_logic_vector(height -1 downto 0);
		w_col : in std_logic_vector(width -1 downto 0);
		w_d : in std_logic;
		o_d : out std_logic
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

	w_col_dec : decoder
	generic map(size=>cols)
	port map(
		addr => w_addr(rows+cols-1 downto rows),
		one_hot => w_col
	);

	o_col_dec : decoder
	generic map(size=>cols)
	port map(
		addr => o_addr(rows+cols-1 downto rows),
		one_hot => o_col
	);
	
	w_row_dec : decoder
	generic map(size=>rows)
	port map(
		addr => w_addr(rows-1 downto 0),
		one_hot => w_row
	);

	o_row_dec : decoder
	generic map(size=>rows)
	port map
		(
		addr => o_addr(rows-1 downto 0),
		one_hot => o_row
	);


	cell_array : memory_cell_array
	generic map(
		height => 2**rows,
		width => 2**cols
	)
	port map(
		o_row => o_row,
		o_col => o_col,
		w_row => w_row,
		w_col => w_col,
		w_d => w_data,
		o_d => o_data
	);


	o_enabler : enabler
	port map(
		ae => ce,
		be => oe,
		data_in => o_array,
		data_out => o_data
	);

	w_enabler : enabler
	port map(
		ae => ce,
		be => we,
		data_in => w_data,
		data_out => w_array
	);
	
end arch;
