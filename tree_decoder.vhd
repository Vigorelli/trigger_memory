library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tree_decoder is
generic (
	size : natural;
	cell_width : natural
	);
port (
		addr: in std_logic_vector(size - 1 downto 0);
		one_hot: out std_logic_vector(2**size - 1 downto 0)
	);
end tree_decoder;


architecture arch of tree_decoder is

	type matrix is array (size/cell_width -1 downto 0) of
		std_logic_vector(2**(size-cell_width) -1 downto 0);
	
	signal p : matrix;


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



begin

	p(0)(0) <= '1';
	
	cell_gen:
	for i in 0 to (size/cell_width -2) generate
		stage_gen:
		for j in 0 to 2**(i*cell_width)-1 generate
			decoder_cell : decoder
			generic map(
				size => cell_width
			)
			port map(
				enable => p(i)(j), --previous stage one hot 
				addr => addr(size - i*cell_width -1 downto size - (i+1)*cell_width),
--sistemare qui!! dividere l'uscita tra le celle a cui serve!!
				one_hot => p(i+1)(((j+1)*2**cell_width) - 1 downto j*2**cell_width) --following stage enable
			);--(2**((i+1)*cell_width)
		end generate;
	end generate;

	last_stage:
	for j in 0 to 2**(size-cell_width)-1 generate
		decoder_cell : decoder
		generic map(
			size => cell_width
		)
		port map(
			enable => p(size/cell_width -1)(j), --previous stage one hot 
			addr => addr(cell_width-1 downto 0),
			one_hot => one_hot(((j+1)*2**cell_width) - 1 downto j*2**cell_width) -- final code
		);
	end generate;
	
end arch;
