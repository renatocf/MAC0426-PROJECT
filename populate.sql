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

-- gamer
INSERT INTO gamer(name, nickname, card_num, password) VALUES
('gamer1', 'the1', 5, 'jhadg'),
('gamer2', 'the2', 5, 'jhadg'),
('gamer3', 'the3', 5, 'jhadg');

-- team
INSERT INTO team(name) VALUES
('team1');

-- game
INSERT INTO game(title, version) VALUES
('game1','v01'),
('game2','v01'),
('game3','v01'),
('game4','v01'),
('game5','v01'),
('game6','v01');

-- distributor

-- challenge
-- INSERT INTO challenge(1,'game4',)

-- rel_distributes

-- rel_owns
INSERT INTO rel_owns(nickname, title) VALUES
('the1', 'game1'),
('the1', 'game2'),
('the1', 'game3'),
('the1', 'game4'),
('the2', 'game1'),
('the2', 'game2'),
('the2', 'game3');

-- rel_play
INSERT INTO rel_play(teamName, gameTitle) VALUES
('team1', 'game1'),
('team1', 'game2'),
('team1', 'game3');

-- rel_participate
INSERT INTO rel_participate(nickname,teamName) VALUES
('the1', 'team1'),
('the2', 'team1');

-- rel_dispute
-- INSERT INTO rel_dispute(teamName,gameTitle,idChallenge) VALUES
-- ('team1','game4',1);

-- rel_win
