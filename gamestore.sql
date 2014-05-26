USE renatocf;

CREATE TABLE gamer
(
    name     varchar(255),
    nickname varchar(10),
    card_num int,
    password varchar(32),
    PRIMARY KEY(nickname)
);

CREATE TABLE team 
(
    name     varchar(40),
    PRIMARY KEY(name)
);

CREATE TABLE game
(
    title    varchar(40),
    version  varchar(10),
    PRIMARY KEY(title)
);

CREATE TABLE distributor
(
    name     varchar(255),
    fantasy  varchar(255),
    cnpj     int unsigned,
    PRIMARY KEY(cnpj)
);

CREATE TABLE challenge
(
    idChallenge BIGINT UNSIGNED,   
    title varchar(40),
    dat_beg  datetime,
    dat_end  datetime,
    name varchar(40),
    FOREIGN KEY(title)
        REFERENCES game(title),
    FOREIGN KEY(name)
        REFERENCES team(name),
    PRIMARY KEY(name,idChallenge)
);

CREATE TABLE rel_distribute
(
    cnpj int unsigned,
    title varchar(40),
    FOREIGN KEY(cnpj)
        REFERENCES distributor(cnpj),
    FOREIGN KEY(title)
        REFERENCES game(title)
);

CREATE TABLE rel_owns
(
    nickname varchar(10),
    title varchar(40),
    FOREIGN KEY(nickname)
        REFERENCES gamer(nickname),
    FOREIGN KEY(title)
        REFERENCES game(title)
);

CREATE TABLE rel_participate
(
    nickname varchar(10),
    teamName varchar(40),
    FOREIGN KEY(nickname)
        REFERENCES gamer(nickname),
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    CONSTRAINT own_any_game CHECK ( (nickname AS THIS.nick AND teamName AS THIS.team) IN ((SELECT OWN.title FROM rel_owns AS OWN WHERE OWN.nickname=THIS.nick) contains (SELECT gameTitle FROM rel_play AS PLAY WHERE PLAY.teamName=THIS.team)));
/*utilizei o exemplo desta página: "http://paginas.fe.up.pt/~jlopes/teach/2011-12/SIBD/foils/advanced_db/constraints.php". Mas precisamos fazer a busca correta, provavelmente com division Cara inventei um bocado. não tenho ideia se funciona*/

CREATE TABLE rel_play
(
    teamName varchar(40),
    gameTitle varchar(40),
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(gameTitle)
        REFERENCES game(title)
);

CREATE TABLE rel_dispute
(
    teamName varchar(40),
    gameTitle varchar(40),
    idChallenge varchar(40),    
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(gameTitle,idChallenge)
        REFERENCES challenge(title,idChallenge)
);

CREATE TABLE rel_win
    teamName varchar(40),
    gameTitle varchar(40),
    idChallenge varchar(40),
	victoryTeamName varchar(40),
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(gameTitle,idChallenge)
        REFERENCES challenge(title,idChallenge)
);
