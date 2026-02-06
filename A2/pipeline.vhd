library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;

architecture behavioral of pipeline is
	signal s1_op1, s1_a, s1_c, s1_d, s1_e: integer := 0;
	signal s2_op2, s2_a, s2_c, s2_d, s2_e: integer := 0;
	signal s3_op2, s3_op3, s3_a, s3_e: integer := 0;
	signal s4_op2, s4_op3, s4_op4: integer := 0;
	signal s5_op2, s5_op5: integer := 0;
	signal s6_final: integer := 0;
	
	
begin
-- todo: complete this
process (clk)
	begin
		if rising_edge(clk) then
	--		stage 1
			s1_op1 <= a + b;
			s1_a <= a;
			s1_c <= c;
			s1_d <= d;
			s1_e <= e;
			
	--		stage 2
			s2_op2 <= s1_op1 * 42;
			s2_a <= s1_a;
			s2_c <= s1_c;
			s2_d <= s1_d;
			s2_e <= s1_e;
			
	--		stage 3
			s3_op2 <= s2_op2;
			s3_op3 <= s2_c * s2_d;
			s3_a <= s2_a;
			s3_e <= s2_e;
			
	--		stage 4
			s4_op2 <= s3_op2;
			s4_op3 <= s3_op3;
			s4_op4 <= s3_a - s3_e;
			
	--		stage 5
			s5_op2 <= s4_op2;
			s5_op5 <= s4_op3 * s4_op4;
			
	--		stage 6
			s6_final <= s5_op2 - s5_op5;
			
		end if;
	end process;
	
	op1 <= s1_op1;
	op2 <= s2_op2;
	op3 <= s3_op3;
	op4 <= s4_op4;
	op5 <= s5_op5;
	final_output <= s6_final;

end behavioral;