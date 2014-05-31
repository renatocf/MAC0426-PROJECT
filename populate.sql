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

-- 
-- Sample database
-- =======================
-- 
-- * 4 gamers
-- |- gamer1
-- |  |- 4 games: game1/game2/game3/game4
-- |  '- 1 team:  team1/team3
-- |- gamer2
-- |  |- 3 games: game1/game2/game3
-- |  '- 1 team:  team1
-- |- gamer3
-- |  |- 1 game: game2
-- |  '- 1 team: team2
-- '- gamer4
--    |- 1 game: game2
--    '- 1 team: team2
-- 
-- * 2 distributors
-- |- company1
-- |  '- 3 games: game1/game3/game5
-- '- limited2
--    '- 3 games: game2/game4/game6
--
-- * 3 teams
-- |- team1
-- |  '- 3 matches disputed
-- |- team2
-- |  '- 1 match disputed
-- '- team3
--    '- 0 matches disputed
--

-- 1: gamer
INSERT INTO gamer(name, nickname, card_num, password) VALUES
('gamer1', 'the1', 35897932, 'jhadg'),
('gamer2', 'the2', 38462643, 'jhadg'),
('gamer3', 'the3', 38327950, 'jhadg'),
('gamer4', 'the4', 28841971, 'jhadg');

-- 2: team
INSERT INTO team(name) VALUES
('team1'),
('team2'),
('team3');

-- 3: game
INSERT INTO game(title, version, price) VALUES
('game1','v01.0',   5),
('game2','v03.5',  10),
('game3','v02.3',  15),
('game4','v01.7',  12),
('game5','v00.9',  15),
('game6','v01.2', 100);

-- 4: distributor
INSERT INTO distributor(name,fantasy,cnpj) VALUES
('company1','first and brothers co.',314159265),
('limited2','second and sons lmtd.',271828182);

-- 5: challenge
INSERT INTO challenge(gameTitle,dat_beg,dat_end) VALUES
('game1','2014-01-06 22:44:35','2014-01-07 02:03:15'),
('game1','2014-01-07 11:05:12','2014-01-07 13:00:23'),
('game2','2014-05-10 18:00:17','2014-05-12 19:30:53'),
('game3','2014-05-11 09:15:21','2014-05-11 09:17:35');

-- 6: rel_distribute
INSERT INTO rel_distribute(cnpj,gameTitle) VALUES
(314159265,'game1'),
(314159265,'game3'),
(314159265,'game5'),
(271828182,'game2'),
(271828182,'game4'),
(271828182,'game6');

-- 7: rel_owns
INSERT INTO rel_owns(nickname, gameTitle) VALUES
('the1', 'game1'),
('the1', 'game2'),
('the1', 'game3'),
('the1', 'game4'),
('the2', 'game1'),
('the2', 'game2'),
('the2', 'game3'),
('the3', 'game2'),
('the4', 'game2');

-- 8: rel_play
INSERT INTO rel_play(teamName, gameTitle) VALUES
('team1', 'game1'),
('team1', 'game2'),
('team1', 'game3'),
('team2', 'game2'),
('team3', 'game1');

-- 9: rel_participate
INSERT INTO rel_participate(nickname,teamName) VALUES
('the1', 'team1'),
('the1', 'team3'),
('the2', 'team1'),
('the3', 'team2'),
('the4', 'team2');

-- 10: rel_dispute
INSERT INTO rel_dispute(teamName,gameTitle,idChallenge) VALUES
('team1','game1',1),
('team3','game1',2),
('team1','game2',3),
('team2','game2',3),
('team1','game3',4);

-- 11: rel_win
INSERT INTO rel_win(teamName,gameTitle,idChallenge) VALUES
('team1','game1',1),
('team3','game1',2),
('team2','game2',3);
