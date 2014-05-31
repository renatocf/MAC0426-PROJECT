/**************************************************************/
/*                                                            */
/* Copyright 2014 MAC0426-PROJECT                             */
/*                                                            */
/* Licensed under the Apache License, Version 2.0             */
/* (the "License"); you may not use this file except in       */
/* compliance with the License. You may obtain a copy of the  */
/* License at                                                 */
/*                                                            */
/*     http://www.apache.org/licenses/LICENSE-2.0             */
/*                                                            */
/* Unless required by applicable law or agreed to in writing, */
/* software distributed under the License is distributed on   */
/* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY  */
/* KIND, either express or implied.                           */
/* See the License for the specific language governing        */
/* permissions and limitations under the License.             */
/*                                                            */
/**************************************************************/

CREATE DATABASE IF NOT EXISTS gamestore;

USE gamestore;

/*
//////////////////////////////////////////////////////////////
-------------------------------------------------------------
                           ENTITIES
-------------------------------------------------------------
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/ 

CREATE TABLE IF NOT EXISTS gamer
(
    name     varchar(255),
    nickname varchar(10),
    card_num int,
    password varchar(32),
    PRIMARY KEY(nickname)
);

CREATE TABLE IF NOT EXISTS team 
(
    name    varchar(40),
    PRIMARY KEY(name)
);

CREATE TABLE IF NOT EXISTS game
(
    title    varchar(40),
    version  varchar(10),
    PRIMARY KEY(title)
);

CREATE TABLE IF NOT EXISTS distributor
(
    name     varchar(255),
    fantasy  varchar(255),
    cnpj     int unsigned,
    PRIMARY KEY(cnpj)
);

CREATE TABLE IF NOT EXISTS challenge
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

/*
//////////////////////////////////////////////////////////////
-------------------------------------------------------------
                        RELATIONSHIPS
-------------------------------------------------------------
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/ 

CREATE TABLE IF NOT EXISTS rel_distribute
(
    cnpj  int unsigned,
    title varchar(40),
    
    FOREIGN KEY(cnpj)
        REFERENCES distributor(cnpj),
    FOREIGN KEY(title)
        REFERENCES game(title)
);

CREATE TABLE IF NOT EXISTS rel_owns
(
    nickname varchar(10),
    title    varchar(40),
    
    FOREIGN KEY(nickname)
        REFERENCES gamer(nickname),
    FOREIGN KEY(title)
        REFERENCES game(title)
);

CREATE TABLE IF NOT EXISTS rel_play
(
    teamName  varchar(40),
    gameTitle varchar(40),
    
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(gameTitle)
        REFERENCES game(title)
);

CREATE TABLE IF NOT EXISTS rel_participate
(
    nickname varchar(10),
    teamName varchar(40),
    
    FOREIGN KEY(nickname)
        REFERENCES gamer(nickname),
    FOREIGN KEY(teamName)
        REFERENCES team(name)
);

CREATE TABLE IF NOT EXISTS rel_dispute
(
    teamName    varchar(40),
    gameTitle   varchar(40),
    idChallenge bigint unsigned,
    
    FOREIGN KEY(teamName)
        REFERENCES team(name),
    FOREIGN KEY(idChallenge,gameTitle)
        REFERENCES challenge(id,title)
);

CREATE TABLE IF NOT EXISTS rel_win
(
    teamName    varchar(40),
    gameTitle   varchar(40),
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

-- 
-- TRIGGER: restriction_play
-- Can only play a game if all players own it.
-- 
CREATE TRIGGER restriction_play
BEFORE INSERT ON rel_play FOR EACH ROW
BEGIN
    IF EXISTS(
        SELECT DESQ.nickname /*2*/
        FROM  rel_participate AS DESQ
        WHERE DESQ.nickname NOT IN(
            SELECT OWNS.nickname /*1*/
            FROM  rel_participate AS PART,
                  rel_owns AS OWNS
            WHERE OWNS.title = NEW.gameTitle 
                  AND PART.teamName = NEW.teamName
            )
        )
        -- Let A := rel_participate
        --     B := rel_owns
        -- 1: Nicknames of the players of the team which 
        --    have the title to be inserted (A ∩ B)
        -- 2: Nicknames of the players of the team wich 
        --    does not have the title to be inserted
        --    (A - A ∩ B)
        THEN SIGNAL SQLSTATE '31415'
             SET MESSAGE_TEXT = 
             'All players must own the game';
        END IF;
    END;
$$

--
-- TRIGGER: restriction_participate
-- Avoid a player participating from a team if he
-- does not have all the games played by the team.
--
CREATE TRIGGER restriction_participate
BEFORE INSERT ON rel_participate FOR EACH ROW
BEGIN
    IF NOT
        (SELECT DISTINCT PLAY.teamName FROM rel_play AS PLAY
            WHERE PLAY.teamName=NEW.teamName
            AND PLAY.gameTitle NOT IN(
                SELECT OWNS.title
                FROM rel_owns AS OWNS
                WHERE OWNS.nickname=NEW.nickname
                )
           )
        THEN SIGNAL SQLSTATE '27182'
             SET MESSAGE_TEXT = 
             'Player must own all team games';
        END IF;
    END;
$$

-- 
-- TRIGGER: restriction_dispute
-- Avoid the team disputing a match if the team does
-- not play the game of the match.
-- 
CREATE TRIGGER restriction_dispute
BEFORE INSERT ON rel_dispute FOR EACH ROW
BEGIN
    IF  (NEW.gameTitle NOT IN(
                SELECT PLAY.gameTitle
                FROM  rel_play AS PLAY
                WHERE NEW.teamName=PLAY.teamName
            )
        )
        THEN SIGNAL SQLSTATE '17320'
             SET MESSAGE_TEXT = 
             'Team must play this game';
        END IF;
    END;
$$

-- 
-- TRIGGER: restriction_win
-- A team may only win a challenge disputed by this team
-- 
CREATE TRIGGER restriction_win
BEFORE INSERT ON rel_win FOR EACH ROW
BEGIN
    IF NOT (
            SELECT DISPUTE.teamName
            FROM  rel_dispute AS DISPUTE
            WHERE NEW.teamName = DISPUTE.teamName
              AND NEW.gameTitle = DISPUTE.gameTitle
              AND NEW.idChallenge = DISPUTE.idChallenge
        )
        THEN SIGNAL SQLSTATE '14142'
             SET MESSAGE_TEXT = 
             'Team can only win a challenge it has disputed';
        END IF;
    END;
$$

DELIMITER ;
