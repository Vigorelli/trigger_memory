library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity memory_cell_array is
generic(
		height: natural;
		width: natural
	);
port (	
		o_row : in std_logic_vector(height-1 downto 0);
		o_col : in std_logic_vector(width-1 downto 0);
		w_row : in std_logic_vector(height-1 downto 0);
		w_col : in std_logic_vector(width-1 downto 0);

		w_d : in std_logic;
		o_d : out std_logic
	);
end memory_cell_array;

architecture behav of memory_cell_array is

	signal d_array : std_logic_vector(height*width-1 downto 0);
	
	
begin

--for!! "think of for as a replicated structure"

	process(w_row, w_col)
	begin
		for i in 0 to height - 1 loop
			for j in 0 to width - 1 loop
				if (w_row(i) = '1' and w_col(j) = '1') then
					d_array(i*width+j) <= w_d;
				end if;
			end loop;
		end loop;
	end process;


	process(o_row, o_col)
	begin
		for i in 0 to height - 1 loop
			for j in 0 to width - 1 loop
				if (o_row(i) = '1' and o_col(j) = '1') then
					o_d <= d_array(i*width+j);
				end if;
			end loop;
		end loop;
	end process;


end behav;

architecture arch of memory_cell_array is

	type matrix is array (height-1 downto 0, width-1 downto 0)
		of std_logic;
	signal d_array : matrix;

begin
	
	column_gen:
	for i in 0 to height - 1 generate
		row_gen:
		for j in 0 to width - 1 generate
			
			o_d <=	d_array(i,j) when (w_row(i) = '1' and w_col(j) = '1') else
					'Z';
			d_array(i,j) <=	w_d when (w_row(i) = '1' and w_col(j) = '1') else
							'Z';
		end generate;
		
	end generate;

end arch;
