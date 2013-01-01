--Written by Rahul Vora
--for the University of New Mexico
--rhlvora@gmail.com

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComps1nts.all;

entity lcd is
	port(
	clk, reset : in std_logic;
	SF_D : out std_logic_vector(3 downto 0);
	LCD_E, LCD_RS, LCD_RW, SF_CE0 : out std_logic;
	alu_input_a, alu_input_b, alu_output, reg_1_output, reg_2_output, reg_3_output, buf_output : in std_logic_vector(3 downto 0)
);
end lcd;

architecture behavior of lcd is

type display_state is (init, function_set, s1, entry_set, s2, set_display, s3, clr_display, s4, pause, set_addr, s5, update, s6, done);
signal cur_state : display_state := init;

type message_state_type is (msg_init, set_addr, s1, update, s2, num_addr, s3, msg_num, s4, msg_done);
signal msg_state : message_state_type := set_addr;

signal SF_D0, SF_D1 : std_logic_vector(3 downto 0);
signal LCD_E0, LCD_E1 : std_logic;
signal mux : std_logic;

type tx_sequence is (high_setup, high_hold, oneus, low_setup, low_hold, fortyus, done);
signal tx_state : tx_sequence := done;
signal tx_byte : std_logic_vector(7 downto 0);
signal tx_init : std_logic := '0';
signal tx_rdy : std_logic := '0';

type init_sequence is (idle, fifteenms, s1, s2, s3, s4, s5, s6, s7, s8, done);
signal init_state : init_sequence := idle;
signal init_init, init_done : std_logic := '0';

signal i : integer range 0 to 750000 := 0;
signal i2 : integer range 0 to 2000 := 0;
signal i3 : integer range 0 to 82000 := 0;
signal i4 : integer range 0 to 50000000 := 0;

signal inum : std_logic_vector(3 downto 0);
signal num : std_logic_vector(7 downto 0);

signal msg_tx : std_logic_vector(7 downto 0);

signal imsg : std_logic_vector(3 downto 0); --selects index into message
signal cmsg : std_logic_vector(2 downto 0); --select message
signal msg : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_0 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_1 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_2 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_3 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_4 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_5 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_6 : std_logic_vector(7 downto 0); --message tx_byte output for message
signal msg_length : std_logic_vector (3 downto 0); --how far to go

signal message_done : std_logic := '0';
signal message_start :std_logic := '0';

signal msg_tx_init :std_logic := '0';

begin
	SF_CE0 <= '1'; --disable intel strataflash
	LCD_RW <= '0'; --write only

	--when to transmit a command/data and when not to
	with cur_state select
		tx_init <= '1' when function_set | entry_set | set_display | clr_display | set_addr,
			msg_tx_init when s6,
			'0' when others;

	--control the bus
	with cur_state select
		mux <= '1' when init,
			'0' when others;

	--control the initialization sequence
	with cur_state select
		init_init <= '1' when init,
			'0' when others;
	
	--register select
	with cur_state select
		LCD_RS <= '0' when s1|s2|s3|s4|s5,
			'1' when others;

	with cur_state select
		tx_byte <= "00101000" when s1,
			"00000110" when s2,
			"00001100" when s3,
			"00000001" when s4,
			"10000000" when s5,
			msg_tx when s6,
			"00000000" when others;

	with cmsg select
		inum <= alu_input_a when "000",
			alu_input_b when "001",
			alu_output when "010",
			reg_1_output when "011",
			reg_2_output when "100",
			reg_3_output when "101",
			buf_output when "110",
			"0000" when others;

	--as specified by datasheet			
	with inum select
		num <= "00110000" when "0000",
			"00110001" when "0001",
			"00110010" when "0010",
			"00110011" when "0011",
			"00110100" when "0100",
			"00110101" when "0101",
			"00110110" when "0110",
			"00110111" when "0111",
			"00111000" when "1000",
			"00111001" when "1001",
			"01000001" when "1010",
			"01000010" when "1011",
			"01000011" when "1100",
			"01000100" when "1101",
			"01000101" when "1110",
			"01000110" when others;
		
	--switch messages
	counter: process(clk, reset)
	begin
		if(reset = '1') then
			cmsg <= "000";
			i4 <= 0;
		elsif(clk='1' and clk'event) then
			if(i4 = 50000000) then
				if(cmsg = "110") then
					cmsg <= "000";
				else
					cmsg <= cmsg + 1;
				end if;
				i4 <= 0;
			else
				cmsg <= cmsg;
				i4 <= i4 + 1;
			end if;
		end if;
	end process counter;
	
	with cmsg select
		msg <= msg_0 when "000",
			msg_1 when "001",
			msg_2 when "010",
			msg_3 when "011",
			msg_4 when "100",
			msg_5 when "101",
			msg_6 when "110",
			msg_0 when others;
	
	with imsg select
		msg_0 <= "01000001" when "0000",
			"01001100" when "0001",
			"01010101" when "0010",
			"00100000" when "0011",
			"01001001" when "0100",
			"01001110" when "0101",
			"01010000" when "0110",
			"01010101" when "0111",
			"01010100" when "1000",
			"00100000" when "1001",
			"01000001" when "1010",
			"00111010" when "1011",
			"00100000" when others;

	with imsg select
		msg_1 <= "01000001" when "0000",
			"01001100" when "0001",
			"01010101" when "0010",
			"00100000" when "0011",
			"01001001" when "0100",
			"01001110" when "0101",
			"01010000" when "0110",
			"01010101" when "0111",
			"01010100" when "1000",
			"00100000" when "1001",
			"01000010" when "1010",
			"00111010" when "1011",
			"00100000" when others;
			
	with imsg select
		msg_2 <= "01000001" when "0000",
			"01001100" when "0001",
			"01010101" when "0010",
			"00100000" when "0011",
			"01001111" when "0100",
			"01010101" when "0101",
			"01010100" when "0110",
			"01010000" when "0111",
			"01010101" when "1000",
			"01010100" when "1001",
			"00111010" when "1010",
			"00100000" when others;
	
	with imsg select
		msg_3 <= "01010010" when "0000",
			"01000101" when "0001",
			"01000111" when "0010",
			"00100000" when "0011",
			"00110001" when "0100",
			"00100000" when "0101",
			"01001111" when "0110",
			"01010101" when "0111",
			"01010100" when "1000",
			"01010000" when "1001",
			"01010101" when "1010",
			"01010100" when "1011",
			"00111010" when "1100",
			"00100000" when others;

		
	with imsg select
		msg_4 <= "01010010" when "0000",
			"01000101" when "0001",
			"01000111" when "0010",
			"00100000" when "0011",
			"00110010" when "0100",
			"00100000" when "0101",
			"01001111" when "0110",
			"01010101" when "0111",
			"01010100" when "1000",
			"01010000" when "1001",
			"01010101" when "1010",
			"01010100" when "1011",
			"00111010" when "1100",
			"00100000" when others;
	
	with imsg select
		msg_5 <= "01010010" when "0000",
			"01000101" when "0001",
			"01000111" when "0010",
			"00100000" when "0011",
			"00110011" when "0100",
			"00100000" when "0101",

			"01001111" when "0110",
			"01010101" when "0111",
			"01010100" when "1000",
			"01010000" when "1001",
			"01010101" when "1010",
			"01010100" when "1011",
			"00111010" when "1100",
			"00100000" when others;
		
	with imsg select
		msg_6 <= "01000010" when "0000",
			"01010101" when "0001",
			"01000110" when "0010",
			"01000110" when "0011",
			"01000101" when "0100",
			"01010010" when "0101",
			
			"00100000" when "0110",

			"01001111" when "0111",
			"01010101" when "1000",
			"01010100" when "1001",
			"01010000" when "1010",
			"01010101" when "1011",
			"01010100" when "1100",
			"00111010" when "1101",
			"00100000" when others;
		
	msg_length <= "1110";
	
	with msg_state select
		msg_tx <= --"1000" & imsg(3 downto 0) when s1,
			"10000000" when s1,
			msg when s2,
			num when s3,
			"10000000" when others;
			
	with msg_state select
		msg_tx_init <= '1' when update | num_addr | msg_num,
			'0' when others;
			
	message: process(clk, reset)
	begin
		if(reset = '1') then
			msg_state <= msg_init;
		elsif(clk='1' and clk'event) then
			case msg_state is
				when msg_init =>
					imsg <= "0000";
					message_done <= '0';
					if(message_start = '1') then
						msg_state <= set_addr;
					else
						msg_state <= msg_init;
					end if;
					
				when set_addr =>
					message_done <= '0';
					msg_state <= s1;

				when s1 =>
					message_done <= '0';
					if(tx_rdy = '1') then
						msg_state <= update;
					else
						msg_state <= s1;
					end if;
				
				when update =>
					message_done <= '0';
					msg_state <= s2;
				
				when s2 =>
					message_done <= '0';
					if(tx_rdy = '1') then
						if(imsg = msg_length) then
							msg_state <= num_addr;
							imsg <= imsg;
						else
							msg_state <= set_addr;
							imsg <= imsg + 1;
						end if;
					else
						msg_state <= s2;
					end if;
					
				when num_addr =>
					message_done <= '0';
					msg_state <= s3;
					
				when s3 =>
					message_done <= '0';
					if(tx_rdy = '1') then
						msg_state <= msg_num;
					else
						msg_state <= s3;
					end if;
					
				when msg_num =>
					message_done <= '0';
					msg_state <= s4;
					
				when s4 =>
					message_done <= '0';
					if(tx_rdy = '1') then
						msg_state <= msg_done;
					else
						msg_state <= s4;
					end if;
					
				when msg_done =>
					message_done <= '1';
					msg_state <= msg_init;
				end case;
			end if;
		end process message;
		
	with cur_state select
		message_start <= '1' when update,
			'0' when others;
	
	--main state machine
	display: process(clk, reset)
	begin
		if(reset='1') then
			cur_state <= init;
		elsif(clk='1' and clk'event) then
			case cur_state is
				when init =>
					if(init_done = '1') then
						cur_state <= function_set;
					else
						cur_state <= init;
					end if;

				when function_set =>
					cur_state <= s1;

				when s1 =>
					if(tx_rdy = '1') then
						cur_state <= entry_set;
					else
						cur_state <= s1;
					end if;	
				
				when entry_set =>
					cur_state <= s2;
				
				when s2 =>
					if(tx_rdy = '1') then
						cur_state <= set_display;
					else
						cur_state <= s2;
					end if;
				
				when set_display =>
					cur_state <= s3;
				
				when s3 =>
					if(tx_rdy = '1') then
						cur_state <= clr_display;
					else
						cur_state <= s3;
					end if;
				
				when clr_display =>
					cur_state <= s4;

				when s4 =>
					i3 <= 0;
					if(tx_rdy = '1') then
						cur_state <= pause;
					else
						cur_state <= s4;
					end if;

				when pause =>
					if(i3 = 82000) then
						cur_state <= set_addr;
						i3 <= 0;
					else
						cur_state <= pause;
						i3 <= i3 + 1;
					end if;

				when set_addr =>
					cur_state <= s5;

				when s5 =>
					if(tx_rdy = '1') then
						cur_state <= update;
					else
						cur_state <= s5;
					end if;
				
				when update =>
					cur_state <= s6;
				
				when s6 =>
					if(message_done = '1') then
						cur_state <= set_addr;
					else
						cur_state <= s6;
					end if;
				
				when done =>
					cur_state <= done;

			end case;
		end if;
	end process display;

	with mux select
		SF_D <= SF_D0 when '0', --transmit
			SF_D1 when others;	--initialize
	with mux select
		LCD_E <= LCD_E0 when '0', --transmit
			LCD_E1 when others; --initialize

	with tx_state select
		tx_rdy <= '1' when done,
			'0' when others;

	with tx_state select
		LCD_E0 <= '0' when high_setup | oneus | low_setup | fortyus | done,
			'1' when high_hold | low_hold;

	with tx_state select
		SF_D0 <= tx_byte(7 downto 4) when high_setup | high_hold | oneus,
			tx_byte(3 downto 0) when low_setup | low_hold | fortyus | done;


	--specified by datasheet
	transmit : process(clk, reset, tx_init)
	begin
		if(reset='1') then
			tx_state <= done;
		elsif(clk='1' and clk'event) then
			case tx_state is
				when high_setup => --40ns
					if(i2 = 2) then
						tx_state <= high_hold;
						i2 <= 0;
					else
						tx_state <= high_setup;
						i2 <= i2 + 1;
					end if;

				when high_hold => --230ns
					if(i2 = 12) then
						tx_state <= oneus;
						i2 <= 0;
					else
						tx_state <= high_hold;
						i2 <= i2 + 1;
					end if;

				when oneus =>
					if(i2 = 50) then
						tx_state <= low_setup;
						i2 <= 0;
					else
						tx_state <= oneus;
						i2 <= i2 + 1;
					end if;

				when low_setup =>
					if(i2 = 2) then
						tx_state <= low_hold;
						i2 <= 0;
					else
						tx_state <= low_setup;
						i2 <= i2 + 1;
					end if;

				when low_hold =>
					if(i2 = 12) then
						tx_state <= fortyus;
						i2 <= 0;
					else
						tx_state <= low_hold;
						i2 <= i2 + 1;
					end if;

				when fortyus =>
					if(i2 = 2000) then
						tx_state <= done;
						i2 <= 0;
					else
						tx_state <= fortyus;
						i2 <= i2 + 1;
					end if;

				when done =>
					if(tx_init = '1') then
						tx_state <= high_setup;
						i2 <= 0;
					else
						tx_state <= done;
						i2 <= 0;
					end if;

			end case;
		end if;
	end process transmit;

	with init_state select
		init_done <= '1' when done,
			'0' when others;
	
	with init_state select
		SF_D1 <= "0011" when s1 | s2 | s3 | s4 | s5 | s6,
			"0010" when others;

	with init_state select
		LCD_E1 <= '1' when s1 | s3 | s5 | s7,
			'0' when others;
					
	--specified by datasheet
	power_on_initialize: process(clk, reset, init_init) --power on initialization sequence
	begin
		if(reset='1') then
			init_state <= idle;
		elsif(clk='1' and clk'event) then
			case init_state is
				when idle =>	
					if(init_init = '1') then
						init_state <= fifteenms;
						i <= 0;
					else
						init_state <= idle;
						i <= i + 1;
					end if;
				
				when fifteenms =>
					if(i = 750000) then
						init_state <= s1;
						i <= 0;
					else
						init_state <= fifteenms;
						i <= i + 1;
					end if;

				when s1 =>
					if(i = 11) then
						init_state<=s2;
						i <= 0;
					else
						init_state<=s1;
						i <= i + 1;
					end if;

				when s2 =>
					if(i = 205000) then
						init_state<=s3;
						i <= 0;
					else
						init_state<=s2;
						i <= i + 1;
					end if;

				when s3 =>
					if(i = 11) then	
						init_state<=s4;
						i <= 0;
					else
						init_state<=s3;
						i <= i + 1;
					end if;

				when s4 =>
					if(i = 5000) then
						init_state<=s5;
						i <= 0;
					else
						init_state<=s4;
						i <= i + 1;
					end if;

				when s5 =>
					if(i = 11) then
						init_state<=s6;
						i <= 0;
					else
						init_state<=s5;
						i <= i + 1;
					end if;

				when s6 =>
					if(i = 2000) then
						init_state<=s7;
						i <= 0;
					else
						init_state<=s6;
						i <= i + 1;
					end if;

				when s7 =>
					if(i = 11) then
						init_state<=s8;
						i <= 0;
					else
						init_state<=s7;
						i <= i + 1;
					end if;

				when s8 =>
					if(i = 2000) then
						init_state<=done;
						i <= 0;
					else
						init_state<=s8;
						i <= i + 1;
					end if;

				when done =>
					init_state <= done;

			end case;

		end if;
	end process power_on_initialize;

end behavior;
