GRUPO : BARUC NOGAROL, CARLOS MIRANDA e LUIZ EDUARDO LUIZ

*Sequência de Fibonacci em VHDL no kit De10 lite*

Objetivo: Implementar um código que imprima a sequência de Fibonacci nos displays de sete segmentos do kit de10 lite utilizando máquina de estados.

Descrição: Nesta atividade, você implementará um código VHDL para controlar um display de sete segmentos no kit DE10-Lite, que exibirá a sequência de Fibonacci. A sequência de Fibonacci é uma série em que cada número é a soma dos dois anteriores, começando por 0 e 1, com a sequência prosseguindo como 1, 2, 3, 5, 8, 13, 21, etc. Será necessário criar um contador em VHDL que calcule esses valores. A complexidade deste projeto requer o uso de uma máquina de estados para controlar o fluxo do programa e garantir que os números sejam calculados e exibidos corretamente. Este é um excelente exercício para consolidar seus conhecimentos em VHDL, máquinas de estados e programação FPGA.


Máquinas de estados finitos em VHDL: Veja o material on-line: VHDL_6_MC_FSM_v2 (unicamp.br); assim como o material do livro texto: Minha Biblioteca: VHDL - Descrição e Síntese de Circuitos Digitais, 2ª edição

Tarefas:

Crie uma entidade-arquitetura em VHDL que imprima a sequência de Fibonacci nos displays de sete segmentos do kit de10 lite utilizando máquina de estados. Utilize o pacote display discutido em aulas anteriores: https://github.com/fpfrimer/turma2022-2_vhdl/blob/main/display_package/display.vhd.

Faça o código de modo que cada número da sequência de Fibonacci permaneça um segundo no display;

Utilize os seis displays e reinicie a sequência, após ser mostrado o maior valor possível (832040);
