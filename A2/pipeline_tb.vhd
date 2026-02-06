LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

ENTITY pipeline_tb IS
END pipeline_tb;

ARCHITECTURE behaviour OF pipeline_tb IS

COMPONENT pipeline IS
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk: STD_LOGIC := '0';
SIGNAL s_a, s_b, s_c, s_d, s_e : INTEGER := 0;
SIGNAL s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output : INTEGER := 0;

CONSTANT clk_period : time := 1 ns;

BEGIN
dut: pipeline
PORT MAP(clk, s_a, s_b, s_c, s_d, s_e, s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;


stim_process: PROCESS
variable expected1, expected2, expected3 : integer := 0;
BEGIN   
	
--	cycle 1
	REPORT "1st cycle";

	s_a <= 1; s_b <= 2; s_c <= 3; s_d <= 4; s_e <= 5;
	WAIT FOR 0 ns;
	expected1 := ((s_a+s_b)*42)-((s_c*s_d)*(s_a-s_e));
	REPORT "First batch of inputs passed into the pipeline";
	WAIT FOR clk_period;
	
--	cycle 2
	REPORT "2nd cycle";

	ASSERT (s_op1 = 3) REPORT "Test Case 1 Failed: Expected s1_op1 = 3" SEVERITY ERROR;
	
	s_a <= 10; s_b <= 10; s_c <= 2; s_d <= 2; s_e <= 5;
	WAIT FOR 0 ns;
	expected2 := ((s_a+s_b)*42)-((s_c*s_d)*(s_a-s_e));
	REPORT "Second batch of inputs passed into the pipeline";
   WAIT FOR clk_period;
	 
--	cycle 3 
	REPORT "3rd cycle";
	
	ASSERT (s_op1 = 20) REPORT "Test Case 2 Failed: Expected s_op1 = 20" SEVERITY ERROR;
	ASSERT (s_op2 = 126) REPORT "Test Case 1 Failed: Expected s_op2 = 126" SEVERITY ERROR;
	
	s_a <= 5; s_b <= 5; s_c <= 1; s_d <= 1; s_e <= 0;
	WAIT FOR 0 ns;
	expected3 := ((s_a+s_b)*42)-((s_c*s_d)*(s_a-s_e));
	REPORT "Third batch of inputs passed into the pipeline";
   WAIT FOR clk_period; 
	
-- cycle 4
	REPORT "4th cycle";
	
	ASSERT (s_op1 = 10) REPORT "Test Case 3 Failed: Expected s_op1 = 10" SEVERITY ERROR;
	ASSERT (s_op2 = 840) REPORT "Test Case 2 Failed: Expected s_op2 = 840" SEVERITY ERROR;
	ASSERT (s_op3 = 12) REPORT "Test Case 1 Failed: Expected s_op3 = 12" SEVERITY ERROR;

	
	WAIT FOR clk_period;
	
--	cycle 5
	REPORT "5th cycle";
	
	
	ASSERT (s_op2 = 420) REPORT "Test Case 3 Failed: Expected s_op2 = 420" SEVERITY ERROR;
	ASSERT (s_op3 = 4) REPORT "Test Case 2 Failed: Expected s_op3 = 4" SEVERITY ERROR;
	ASSERT (s_op4 = -4) REPORT "Test Case 1 Failed: Expected s_op4 = -4" SEVERITY ERROR;
	
	WAIT FOR clk_period;

-- cycle 6
	REPORT "6th cycle";
	
	ASSERT (s_op3 = 1) REPORT "Test Case 3 Failed: Expected s_op3 = 1" SEVERITY ERROR;
	ASSERT (s_op4 = 5) REPORT "Test Case 2 Failed: Expected s_op4 = 5" SEVERITY ERROR;
	ASSERT (s_op5 = -48) REPORT "Test Case 1 Failed: Expected s_op5 = -48" SEVERITY ERROR;
	
	WAIT FOR clk_period;	
	
--	cycle 7
	REPORT "7th cycle";
	
	ASSERT (s_op4 = 5) REPORT "Test Case 3 Failed: Expected s_op4 = 5" SEVERITY ERROR;
	ASSERT (s_op5 = 20) REPORT "Test Case 2 Failed: Expected s_op5 = 20" SEVERITY ERROR;
	ASSERT (s_final_output = expected1) REPORT "Test Case 1 Failed: Expected s_final_output = " & integer'image(expected1) & ", got:" & integer'image(s_final_output) SEVERITY ERROR;
	REPORT "Test case 1 passed sixth and last cycle";
	
	WAIT FOR clk_period;
	
--	cycle 8
	REPORT "8th cycle";
	
	ASSERT (s_op5 = 5) REPORT "Test Case 3 Failed: Expected s_op5 = 5" SEVERITY ERROR;
	ASSERT (s_final_output = expected2) REPORT "Test Case 2 Failed: Expected s_final_output = " & integer'image(expected2) & ", got:" & integer'image(s_final_output) SEVERITY ERROR;
	REPORT "Test case 2 passed sixth and last cycle";
	
	WAIT FOR clk_period;
	
--	cycle 9
	REPORT "9th cycle";
	
	ASSERT (s_final_output = expected3) REPORT "Test Case 3 Failed: Expected s_final_output = " & integer'image(expected3) & ", got:" & integer'image(s_final_output) SEVERITY ERROR;
	REPORT "Test case 3 passed sixth and last cycle";
	
	WAIT;
	
END PROCESS stim_process;
END;
