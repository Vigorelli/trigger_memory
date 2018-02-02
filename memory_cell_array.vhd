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
		r_row : in std_logic_vector(height-1 downto 0);
		r_col : in std_logic_vector(width-1 downto 0);
		w_row : in std_logic_vector(height-1 downto 0);
		w_col : in std_logic_vector(width-1 downto 0);

		w_d : in std_logic;
		r_d : out std_logic
	);
end memory_cell_array;

architecture behav of memory_cell_array is

	type matrix is array (height-1 downto 0, width-1 downto 0)
		of std_logic;
	signal d_array : matrix;
		
begin

--for!! "think of for as a replicated structure"

	process(w_row, w_col, d_array)
	begin
		for i in 0 to height - 1 loop
			for j in 0 to width - 1 loop
				if (w_row(i) = '1' and w_col(j) = '1') then
					d_array(i,j) <= w_d;
				end if;
			end loop;
		end loop;
	end process;


	process(r_row, r_col, d_array)
	begin
		for i in 0 to height - 1 loop
			for j in 0 to width - 1 loop
				if (r_row(i) = '1' and r_col(j) = '1') then
					r_d <= d_array(i,j);
				end if;
			end loop;
		end loop;
	end process;


end behav;
-- 
-- architecture arch of memory_cell_array is
-- 
-- 	type matrix is array (height-1 downto 0, width-1 downto 0)
-- 		of std_logic;
-- 	signal d_array : matrix;
-- 
-- begin
-- 	
-- 	column_gen:
-- 	for i in 0 to height - 1 generate
-- 		row_gen:
-- 		for j in 0 to width - 1 generate
-- 			
-- 			o_d <=	d_array(i,j) when (o_row(i) = '1' and o_col(j) = '1');
-- 			d_array(i,j) <=	w_d when (w_row(i) = '1' and w_col(j) = '1');
-- 		end generate;
-- 		
-- 	end generate;
-- 
-- end arch;
