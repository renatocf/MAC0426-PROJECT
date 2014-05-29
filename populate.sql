INSERT INTO team(name) VALUES('team1');
INSERT INTO gamer(name, nickname, card_num, password) VALUES('gamer1', 'the1', 5, 'jhadg');
INSERT INTO gamer(name, nickname, card_num, password) VALUES('gamer2', 'the2', 5, 'jhadg');
INSERT INTO gamer(name, nickname, card_num, password) VALUES('gamer3', 'the3', 5, 'jhadg');

INSERT INTO game(title, version) VALUES('game1','v01');
INSERT INTO game(title, version) VALUES('game2','v01');
INSERT INTO game(title, version) VALUES('game3','v01');
INSERT INTO game(title, version) VALUES('game4','v01');
INSERT INTO game(title, version) VALUES('game5','v01');
INSERT INTO game(title, version) VALUES('game6','v01');

INSERT INTO rel_owns(nickname, title) VALUES('the1', 'game1');
INSERT INTO rel_owns(nickname, title) VALUES('the1', 'game2');
INSERT INTO rel_owns(nickname, title) VALUES('the1', 'game3');
INSERT INTO rel_owns(nickname, title) VALUES('the1', 'game4');

INSERT INTO rel_owns(nickname, title) VALUES('the2', 'game1');
INSERT INTO rel_owns(nickname, title) VALUES('the2', 'game2');
INSERT INTO rel_owns(nickname, title) VALUES('the2', 'game3');


INSERT INTO rel_play(teamName, gameTitle) VALUES('team1', 'game1');
INSERT INTO rel_play(teamName, gameTitle) VALUES('team1', 'game3');

INSERT INTO rel_participate(nickname,teamName) VALUES('the1', 'team1');
INSERT INTO rel_participate(nickname,teamName) VALUES('the2', 'team1');
INSERT INTO rel_participate(nickname,teamName) VALUES('the3', 'team1');


INSERT INTO rel_play(teamName, gameTitle) VALUES('team1', 'game2');
INSERT INTO rel_play(teamName, gameTitle) VALUES('team1', 'game4');
