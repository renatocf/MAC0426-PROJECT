/* USE evnsan; */

CREATE DATABASE IF NOT EXISTS gamestore;

USE gamestore;

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
    name    varchar(40),
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
    id       bigint unsigned,   
    title    varchar(40),
    dat_beg  datetime,
    dat_end  datetime,
    name     varchar(40),
    PRIMARY KEY(id,title),
    FOREIGN KEY(title)
        REFERENCES game(title),
    FOREIGN KEY(name)
        REFERENCES team(name)
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

CREATE TABLE rel_play
(
    teamName varchar(40),
    gameTitle varchar(40),
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(gameTitle)
        REFERENCES game(title)
);

CREATE TABLE rel_participate
(
    nickname varchar(10),
    teamName varchar(40),
    FOREIGN KEY(nickname)
        REFERENCES gamer(nickname),
    FOREIGN KEY(teamName)
        REFERENCES team(name)
);

CREATE TABLE rel_dispute
(
    teamName varchar(40),
    gameTitle varchar(40),
    idChallenge bigint unsigned,
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(idChallenge,gameTitle)
        REFERENCES challenge(id,title)
);

CREATE TABLE rel_win
(
    teamName varchar(40),
    gameTitle varchar(40),
    idChallenge bigint unsigned,
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(idChallenge,gameTitle)
        REFERENCES challenge(id,title)
);

/*
//////////////////////////////////////////////////////////////
-------------------------------------------------------------
                           TRIGGERS
-------------------------------------------------------------
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/ 

DELIMITER $$

/**
 * TRIGGER: restriction_play
 * Can only play a game if all players own it.
 */
/*CREATE TRIGGER restriction_play
BEFORE INSERT ON rel_play FOR EACH ROW
BEGIN
    IF (SELECT HYPH.nickname 
        FROM (SELECT PART.nickname,OWNS.title
              FROM  rel_participate AS PART,rel_owns AS OWNS
              WHERE PART.teamName=NEW.teamName
                    AND OWNS.title=NEW.gametitle) AS HYPH
        WHERE HYPH.nickname NOT IN 
              (SELECT PART.nickname,OWNS.title
               FROM  rel_participate AS PART,rel_owns AS OWNS
               WHERE PART.teamName=NEW.teamName)
        )
        THEN SIGNAL SQLSTATE '42000'
             SET MESSAGE_TEXT='Player must own all team games';
        END IF;
    END;
$$*/

/**
 * TRIGGER: restriction_participate
 * Avoid a player participating from a team if he
 * does not have all the games played by the team.
 */
CREATE TRIGGER restriction_participate
BEFORE INSERT ON rel_participate FOR EACH ROW
BEGIN
    IF NOT
        (SELECT PLAY.teamName FROM rel_play AS PLAY
            WHERE PLAY.teamName=NEW.teamName
            AND NOT PLAY.gameTitle IN(
                SELECT OWNS.title
                FROM rel_owns AS OWNS
                WHERE OWNS.nickname=NEW.nickname
                )
           )
        THEN SIGNAL SQLSTATE '42000'
             SET MESSAGE_TEXT='Player must own all team games';
        END IF;
    END;
$$

DELIMITER ;
