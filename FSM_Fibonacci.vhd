library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.display.all -- Importando todas as funções da biblioteca display

entity FibonacciFSM is -- Declaração da entidade FibonacciFSM
  port (
    clk, reset   :   in   std_logic; -- Sinais de clock e reset
    displayOut   :   out   std_logic_vector(0 to 41); -- Vetor de saída para o display
    keyInputs    :   in std_logic_vector(0 to 9) -- Vetor de entrada para as chaves
  ) ;
end FibonacciFSM;

architecture fsm of FibonacciFSM is
    type    state is (s0, s1, s2, s3, s4);  -- Tipos de estados
    signal  currentState, nextState  :   state; -- Sinais para o estado atual e o próximo estado
    signal fibonacciOut  : integer :=0; -- Saída da sequência de Fibonacci
    signal disp1, disp2, disp3, disp4, disp5, disp6 : integer; -- Variáveis para exibir o valor
    signal counterFlag : integer :=0; -- Variável que indica se a contagem precisa ser feita
    signal secondPassed: integer :=0; -- Variável para sinalizar que um segundo passou
    signal auxCounter: integer :=0; -- Variável auxiliar para contagem
    signal counterValue : integer :=1; -- Valor que deve ser contado

begin
    binToDecConvert : entity work.binToDec(rtl) port map(fibonacciOut, disp1, disp2, disp3, disp4, disp5, disp6); -- Conversão de binário para decimal

    display1 : entity work.decod7seg(logic) port map (disp1, displayOut(0 to 6)); -- Decodificando valor para o display 1
    display2 : entity work.decod7seg(logic) port map (disp2, displayOut(7 to 13)); -- Decodificando valor para o display 2
    display3 : entity work.decod7seg(logic) port map (disp3, displayOut(14 to 20)); -- Decodificando valor para o display 3
    display4 : entity work.decod7seg(logic) port map (disp4, displayOut(21 to 27)); -- Decodificando valor para o display 4
    display5 : entity work.decod7seg(logic) port map (disp5, displayOut(28 to 34)); -- Decodificando valor para o display 5
    display6 : entity work.decod7seg(logic) port map (disp6, displayOut(35 to 41)); -- Decodificando valor para o display 6

    stateUpdate : process( clk, reset, nextState ) -- Processo para atualizar o estado atual
    begin
        if reset = '0' then 
            currentState <= s0; -- Resetar para o estado s0
        elsif rising_edge(clk) then
            currentState <= nextState; -- Mudança para o próximo estado na borda de subida do clock
        end if;      
    end process ; -- stateUpdate

    comb : process(currentState) -- Processo comb
        variable fib0, fib1, fib2 : integer; -- Variáveis da sequência de Fibonacci
    begin
        case( currentState ) is
            when s0 =>
                fib0 := 1; -- Inicializando a sequência de Fibonacci
                fib1 := 1; 
                fib2 := 0;
                nextState <= s1;
            when s1 =>
                fib2:=fib1+fib0; -- Gerando o próximo número da sequência de Fibonacci
                nextState<=s2;    

            when s2 =>
                fib0:=fib1; -- Atualizando o primeiro número da sequência
                nextState<=s3;   

            when s3 =>
                fib1:=fib2; -- Atualizando o segundo número da sequência
                nextState<=s4;  

            when s4 =>
                fibonacciOut<= fib2; -- Atualizando a saída da sequência de Fibonacci
                counterFlag <= 1; -- Indicando que a contagem precisa ser feita
                while secondPassed = 0 loop
                    null; -- Aguardando até que um segundo passe
                end loop;
                counterFlag <= 0; -- Indicando que a contagem foi concluída
                secondPassed <= 0;
                if (fib2*2) > 99999 then
                    nextState<=s0;  -- Resetando para o estado s0 se o valor da sequência for muito grande
                else
                    nextState<=s1;
                end if;
            when others => fib2<=99999; -- Limitando o valor de fib2
        
        end case ;
    end process ; -- comb

    timeCounter : process (clk, counterFlag) -- Processo para contar o tempo
    begin
        if counterFlag = 0 then
            auxCounter <= 0;
        elsif rising_edge(clk) then
            auxCounter <= auxCounter + 1;
            if auxCounter = counterValue then
                auxCounter <= 0; -- Resetando a contagem
                secondPassed <= 1; -- Indicando que um segundo passou
				end if;
		  end if;
    end process;

end fsm ;
