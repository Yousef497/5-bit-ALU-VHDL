--				4-bit ALU
--	sel		Operation				Unit
--	0000		increment a
--	0001		decrement a
--	0010		transfer b
--	0011		increment b				Aritmetic
--	0100		decrement b
--	0101		transfer a
--	0110		add a and b
--	0111		multiply a by 2

--	1000		complement a (1s complement)
--	1001		complement b
--	1010		AND
--	1011		OR
--	1100		XOR					Logic
--	1101		XNOR
--	1110		NAND
--	1111		NOR

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU is 
port(
		a,b,sel: IN  STD_LOGIC_VECTOR(3 downto 0);
		y : out STD_LOGIC_VECTOR(4 downto 0)
);
end ALU;

architecture Alu of Alu is

begin
process(a,b,sel)
Variable yav : STD_LOGIC_VECTOR(4 downto 0);						-- variable to hold the output in arithmetic operations
variable ylv : STD_LOGIC_VECTOR(3 downto 0);						-- variable to hold the output in logic operations
variable temp : STD_LOGIC_VECTOR(4 downto 0);


begin

	
									-- Arithmetic Operations
	
		if (sel = "0000") then													--Increment a
					temp(4 downto 0) := ("00000" + a + "0001");
					yav := temp;		
					
		elsif (sel = "0001") then 												-- decrement a
					temp(4 downto 0) := ("00000" + a + "1111");
					yav := temp;		
					
		elsif (sel = "0010") then												-- transfer b
					yav := ("00000" + b);				
					
		elsif (sel = "0011") then												-- increment b
					temp(4 downto 0) := ("00000" + b + "0001");
					yav := temp;
					
		elsif (sel = "0100") then												-- decrement b
					temp(4 downto 0) := ("00000" + b + "1111");
					yav := temp;
					
		elsif (sel = "0101") then												-- transfer a
					yav := "00000" + a;
					
		elsif (sel = "0110") then												-- Add a and b
					temp(4 downto 0) := ("00000" + a + b);
					yav := temp;
					
		elsif (sel = "0111") then												-- multiply (a) by 2 or shift left 1 bit
					temp(4 downto 0) := ("00000" + a + a);
					yav := temp;
					
					
										-- Logic Operations
								
		elsif (sel = "1000") then												-- 1's complement of a (invert a)
					ylv := NOT a;
		
		elsif (sel = "1001") then												-- 1's complement of b (invert b)
					ylv := NOT b;
		
		elsif (sel = "1010") then												-- a AND b
					ylv := (a AND b);
		
		elsif (sel = "1011") then												-- a OR b
					ylv := (a OR b);
		
		elsif (sel = "1100") then												-- a XOR b
					ylv := (a XOR b);
		
		elsif (sel = "1101") then												-- a XNOR b
					ylv := (a XNOR b);
		
		elsif (sel = "1110") then												-- a NAND b
					ylv := (a NAND b);
		
		elsif (sel = "1111") then												-- a NOR b
					ylv := (a NOR b);
								
		end if;
		

		if (sel(3) = '0') then
					y <= yav;
		elsif (sel(3) = '1') then
					y <= ("0" & ylv);
		end if;

end process;
end Alu;