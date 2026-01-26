library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

-- FSM states
type state_type is (NOT_IN, ENTERING, IN_LONG, IN_SHORT, EXIT_LONG);
signal state : state_type;
signal next_state : state_type;

begin

-- Insert your processes here
-- clock and reset
process (clk, reset)
begin
    if reset = '1' then
    	state <= NOT_IN;
    elsif rising_edge(clk) then
    	state <= next_state;
    end if;
end process;

-- state changes
process (state, input)
begin
	output <= '0';
	case state is
	
		when NOT_IN =>
			if input = SLASH_CHARACTER then
				next_state <= ENTERING;
			else
				next_state <= NOT_IN;
			end if;
			
		when ENTERING =>
			if input = SLASH_CHARACTER then
				next_state <= IN_SHORT;
			elsif input = STAR_CHARACTER then
				next_state <= IN_LONG;
			else
				next_state <= NOT_IN;
			end if;
			
		when IN_LONG =>
			output <= '1';
			if input = STAR_CHARACTER then
				next_state <= EXIT_LONG;
			else
				next_state <= IN_LONG;
			end if;
		
		when IN_SHORT =>
			output <= '1';
			if input = NEW_LINE_CHARACTER then
				next_state <= NOT_IN;
			else
				next_state <= IN_SHORT;
			end if;
		
		when EXIT_LONG =>
			output <= '1';
			if input = SLASH_CHARACTER then
				next_state <= NOT_IN;
			else
				next_state <= IN_LONG;
			end if;
		end case;
end process;

end behavioral;