LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY fsm_tb IS
END fsm_tb;

ARCHITECTURE behaviour OF fsm_tb IS

COMPONENT comments_fsm IS
PORT (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, s_reset, s_output: STD_LOGIC := '0';
SIGNAL s_input: std_logic_vector(7 downto 0) := (others => '0');

CONSTANT clk_period : time := 1 ns;
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";
CONSTANT MEANINGLESS_CHARACTER : std_logic_vector(7 downto 0) := "01011000";

BEGIN
dut: comments_fsm
PORT MAP(clk, s_reset, s_input, s_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 
--TODO: Thoroughly test your FSM
stim_process: PROCESS
BEGIN    
	
	-- reset the fsm
	s_reset <= '1';
	WAIT FOR clk_period/2;
	s_reset <= '0';

	
	REPORT "NOT_IN: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0', and next_state should be 'NOT_IN'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "NOT_IN: reading a slash character";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a slash character, the output should be '0', and next_state should be 'ENTERING'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "ENTERING: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0', and next_state should be 'NOT_IN'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "NOT_IN: reading a slash character";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a slash character, the output should be '0', and next_state should be 'ENTERING'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "ENTERING: reading a slash character";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a slash character, the output should be '0', and next_state should be 'IN_SHORT'" SEVERITY ERROR;
	REPORT "_______________________";

	REPORT "IN_SHORT: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character, the output should be '1', and next_state should be 'IN_SHORT'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "IN_SHORT: reading a newline character";
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a newline character, the output should be '1', and next_state should be 'NOT_IN'" SEVERITY ERROR;
	REPORT "_______________________";
	
	
	
	REPORT "NOT_IN: reading a slash character";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a slash character, the output should be '0', and next_state should be 'ENTERING'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "ENTERING: reading a star character";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a star character, the output should be '0', and next_state should be 'IN_LONG'" SEVERITY ERROR;
	REPORT "_______________________";

	REPORT "IN_LONG: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character, the output should be '1', and next_state should be 'IN_LONG'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "IN_LONG: reading a star character";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a star character, the output should be '1', and next_state should be 'EXIT_LONG'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "EXIT_LONG: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character, the output should be '1', and next_state should be 'IN_LONG'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "IN_LONG: reading a star character";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a star character, the output should be '1', and next_state should be 'EXIT_LONG'" SEVERITY ERROR;
	REPORT "_______________________";
	
	REPORT "EXIT_LONG: reading a slash character";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a slash character, the output should be '1', and next_state should be 'NOT_IN'" SEVERITY ERROR;
	REPORT "_______________________";	
	
	REPORT "NOT_IN: reading a meaningless character";
	s_input <= MEANINGLESS_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0', and next_state should be 'NOT_IN'" SEVERITY ERROR;
	REPORT "_______________________";	
	
	
	WAIT;
END PROCESS stim_process;
END;
