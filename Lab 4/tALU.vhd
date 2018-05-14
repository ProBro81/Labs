--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU

		-- Adder-Subtracter Test
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00000";	-- Control in binary (ADD and ADDI test)
		wait for 20 ns; 	-- result = 0x124578AB  and zeroOut = 0
		datain_a <= X"4F302C85";
		datain_b <= X"7A222578";
		wait for 20 ns; 	-- dataout should be 0xC95251FD
		control  <= "00001";	-- subtraction at 120nS
		wait for 20 ns;		-- dataout should be 0xD50E070D
		control  <= "00000";	-- addition at 140nS
		datain_a <= X"C0765A22";
		datain_b <= X"B4059ADD";
		wait for 20 ns; 	-- dataout should be 0x747BF4FF
		control  <= "00001";	-- subtraction at 160nS
		wait for 20 ns; 	-- dataout should be 0x0C70BF45-- Add test cases here to drive the ALU implementation

		
		-- Shift Register Test
		control  <= "00111";	-- left	
		datain_a <= X"5A5A5A5A";
		datain_b(4 DOWNTO 0) <= "00001"; -- by 1 bits should be 0xB4B4B4B4
		wait for 5 ns; 		-- at 105nS
		control  <= "10111"; 	-- right
		datain_b(4 DOWNTO 0) <= "00010"; -- by 2 bits should be 0x16969696
		wait for 5 ns; -- at 110nS
		control  <= "10111"; 	-- right again
		datain_b(4 DOWNTO 0) <= "00011"; -- by 3 bits should be 0x0B4B4B4B
		wait for 5 ns; 		-- at 115nS
		control  <= "00111"; 	-- left
		datain_b(4 DOWNTO 0) <= "00001" ; -- by 1 bits should be 0xB4B4B4B4
		wait for 5 ns; 		-- at 120nS

		-- And/Or Test
		control  <= "00100"; 	--And
		datain_a <= X"F000F00F";
		datain_b <= X"F000000F"; --out should be 0xF000000F
		wait for 5 ns; 		--wait 125
		control  <= "00110"; 	--Or
		datain_a <= X"F000F00F";
		datain_b <= X"F000000F"; --out should be 0xF000F00F
		wait for 5 ns; 		--wait 130
		control  <= "00100"; 	--And
		datain_a <= X"00000000";
		datain_b <= X"00000000"; --zero should be 1
		
		
		wait; -- will wait forever

	END PROCESS;

END;