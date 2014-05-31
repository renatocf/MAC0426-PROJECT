MAC0426-PROJECT
===============

MAC0426   -  Sistemas de Banco de Dados  
IME-USP   -  Primeiro Semestre de 2014   
Turma 45  -  João Eduardo Ferreira       
                                      
Evandro Augusto Nunes Sanches - 5388861  
Renato Cordeiro Ferreira      - 7990933  

Este projeto é composto dos seguintes arquivos:  

* **Description.txt:**  
    Descrição da proposta do Banco de Dados: uma 
    plataforma web de comercialização e uso de jogos.

* **Conceptual\_model.txt:**   
    Diagrama Entidade Relacionamento para o modelo 
    conceitual do Banco de Dados *gamestore*. O modelo 
    foi feito **sem o uso da ferramenta BrModelo**.

* **Logical\_model.txt:**   
    Desenho esquemático do modelo lógico do Banco de 
    Dados *gamestore*. A passagem do Diagrama Entidade
    Relacionamento (DER) para o modelo relacional foi 
    feita **sem o uso da ferramenta BrModelo**.
    
* **gamestore.sql:**  
    Arquivo principal para construção do Banco de Dados
    *gamestore* em um banco de dados [MySQL][1].

* **populate.sql:**  
    Arquivo para popular Banco de Dados de exemplo, 
    cujos dados podem ser usados para testar as 
    restrições (*triggers*) e consultas (*queries*).

* **test_triggers.sql:**  
    Realiza inserções inválidas no banco, para testar
    as restrições semânticas impostas no modelo 
    conceitual e implementadas por meio de *triggers*.

* **query1.sql:**  
    Realiza a consulta:  
    *Todas as partidas vencidas por __The1__, ordenadas por
    data.*

* **query2.sql:**  
    Realiza a consulta:  
    *Lista dos melhores jogadores do __game1__.*

* **query3.sql:**  
    Realiza a consulta:  
    *Checa se todos os jogadores do __team1__ possuem o
    __game4__ (para o __team1__ poder jogá-lo).*

* **deleteAll.sql:**  
    Limpa todos os dados contidos no Banco de Dados
    *gamestore*, sem apagar sua estrutura. Reinicia o
    gerador automático de ids para a entidade-fraca 
    *challenge*.

* **LICENSE:**    
    Licensa para este Banco de Dados.

* **NOTICE**  
    Notificação da Licensa para este Banco de Dados.

* **README.md**  
    Este arquivo de documentação

**Observação**:

Uma *trigger* extra, especial, foi implementada para 
manter a relação 1:N *rel\_win* com a aridade do modelo
conceitual. Este relacionamento foi implementado como 
um relacionamento M:N, e o Banco pode ser facilmente 
extendido para aceitar alianças entre equipes (o que
permitiria múltiplos times vitoriosos).

[1]: http://dev.mysql.com/
