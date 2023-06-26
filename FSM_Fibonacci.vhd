library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_Fibonacci is
  port (
    clk, rst   :   in   std_logic;
    display    :   out   std_logic_vector(0 to 41);
    keyEntries :   in std_logic_vector(0 to 9)
  ) ;
end FSM_Fibonacci;

architecture fsm of FSM_Fibonacci is
    type    estado is (A, B, C, D, E); 
    signal  estado_atual, estado_futuro  :   estado;
    signal fibo2out  : integer :=0;
    signal disp1value, disp2value, disp3value, disp4value, disp5value, disp6value : integer;
    signal needCouting : integer :=0;
    signal oneSecGone: integer :=0;
    signal auxCouting: integer :=0;
    signal value_to_count : integer :=1;
begin
    conv : entity work.binToDec(rtl) port map(fibo2out, disp1value, disp2value, disp3value, disp4value, disp5value, disp6value);

    generate_display1 : entity work.decod7seg(logic) port map (disp1value, display(0 to 6));
    generate_display2 : entity work.decod7seg(logic) port map (disp2value, display(7 to 13));
    generate_display3 : entity work.decod7seg(logic) port map (disp3value, display(14 to 20));
    generate_display4 : entity work.decod7seg(logic) port map (disp4value, display(21 to 27));
    generate_display5 : entity work.decod7seg(logic) port map (disp5value, display(28 to 34));
    generate_display6 : entity work.decod7seg(logic) port map (disp6value, display(35 to 41));

    atualiza_estado : process( clk, rst, estado_futuro )
    begin
        if rst = '0' then 
            estado_atual <= A;
        elsif rising_edge(clk) then
            estado_atual <= estado_futuro;
        end if;      
    end process ; -- atualiza_estado

    comb : process(estado_atual)
        variable fibo0, fibo1, fibo2 : integer;
    begin
        case( estado_atual ) is
            when A =>
                fibo0 := 1;
                fibo1 := 1;
                fibo2 := 0;
                estado_futuro <= B;
            when B =>
                
                fibo2:=fibo1+fibo0;

                estado_futuro<=C;    

            when C =>
                fibo0:=fibo1;
                estado_futuro<=D;   

            when D =>
                fibo1:=fibo2;
                estado_futuro<=E;  

            when E =>
                fibo2out<= fibo2;
                needCouting <= 1;
                while oneSecGone = 0 loop
                    null;
                end loop;
                needCouting <= 0;
					 oneSecGone <= 0;
                if (fibo2*2) > 999999 then
                    estado_futuro<=A;  
                else
                    estado_futuro<=B;
                end if;
            when others => fibo2<=999999;
        
        end case ;
    end process ; -- comb

    countTime : process (clk, needCouting)
    begin
        if needCouting = 0 then
            auxCouting <= 0;
        elsif rising_edge(clk) then
            auxCouting <= auxCouting + 1;
            if auxCouting = value_to_count then
                oneSecGone <= 1;
                auxCouting <= 0;
				end if;
		  end if;
    end process;

end fsm ; -- fsm