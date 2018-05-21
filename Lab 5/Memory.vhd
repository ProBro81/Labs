--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	register8: For i in 0 to 7 generate
		bi: bitstorage PORT MAP(datain(i), enout, writein, dataout(i));
	end generate;
end architecture memmy;
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type;
   signal intAddress: integer range 0 to 127;

begin

  RamProc: process(Clock, Reset, OE, WE, Address) is

  begin
    intAddress <= to_integer(unsigned(Address));
    if Reset = '1' then
      for i in 0 to 127 loop   
          i_ram(i) <= X"00000000";
      end loop;
    end if;

    if falling_edge(Clock) then
	-- Add code to write data to RAM
	-- Use to_integer(unsigned(Address)) to index the i_ram array
	if WE = '1' then
		i_ram(intAddress) <= DataIn;
	end if;
	
    end if;

	-- Rest of the RAM implementation
    if OE = '0' then
	DataOut <= i_ram(intAddress);
    else
	DataOut <= (others => 'Z');
    end if;

  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
		     enout:  in std_logic;
		     writein: in std_logic;
		     dataout: out std_logic_vector( 7 downto 0));
	end component;
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
	Signal a_sig,b_sig,c_sig,d_sig, e_1, e_2, e_3, e_4 : STD_LOGIC;
	
begin
		a_sig <= writein32;
		b_sig <= writein32;
		c_sig <= writein16 or writein32;
		d_sig <= writein8 or writein16 or writein32;
		e_1   <= enout32;
		e_2   <= enout32;
		e_3   <= enout16 and enout32;
		e_4   <= enout8  and enout16 and enout32;
	r1: register8 PORT MAP(datain(7 downto 0), e_4, d_sig, dataout(7 downto 0));
	r2: register8 PORT MAP(datain(15 downto 8), e_3, c_sig, dataout(15 downto 8));
	r3: register8 PORT MAP(datain(23 downto 16), e_2, b_sig, dataout(23 downto 16));
	r4: register8 PORT MAP(datain(31 downto 24), e_1, a_sig, dataout(31 downto 24));
end architecture biggermem;

--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;
	Signal a0,a1,a2,a3,a4,a5,a6,a7,x0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	Signal w: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
begin
    	x0 <= (OTHERS => '0');

	reg0: register32 PORT MAP(WriteData,'0','1','1',w(0),'0','0',a0);
	reg1: register32 PORT MAP(WriteData,'0','1','1',w(1),'0','0',a1);
	reg2: register32 PORT MAP(WriteData,'0','1','1',w(2),'0','0',a2);
	reg3: register32 PORT MAP(WriteData,'0','1','1',w(3),'0','0',a3);
	reg4: register32 PORT MAP(WriteData,'0','1','1',w(4),'0','0',a4);
	reg5: register32 PORT MAP(WriteData,'0','1','1',w(5),'0','0',a5);
	reg6: register32 PORT MAP(WriteData,'0','1','1',w(6),'0','0',a6);
	reg7: register32 PORT MAP(WriteData,'0','1','1',w(7),'0','0',a7);
	
	WITH ReadReg1 SELECT ReadData1 <=
		a0 WHEN "01010",
		a1 WHEN "01011",
		a2 WHEN "01100",
		a3 WHEN "01101",
		a4 WHEN "01110",
		a5 WHEN "01111",
		a6 WHEN "10000",
		a7 WHEN "10001",
		x0 WHEN OTHERS;

	WITH ReadReg2 SELECT ReadData2 <=
		a0 WHEN "01010",
		a1 WHEN "01011",
		a2 WHEN "01100",
		a3 WHEN "01101",
		a4 WHEN "01110",
		a5 WHEN "01111",
		a6 WHEN "10000",
		a7 WHEN "10001",
		x0 WHEN OTHERS;

	WITH WriteCmd & WriteReg SELECT w <=
		"00000001" WHEN "101010",
		"00000010" WHEN "101011",
		"00000100" WHEN "101100",
		"00001000" WHEN "101101",
		"00010000" WHEN "101110",
		"00100000" WHEN "101111",
		"01000000" WHEN "110000",
		"10000000" WHEN "110001",
		"00000000" WHEN OTHERS;
	
end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
