CREATE TABLE user
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

CREATE TABLE match
(
    id_match BIGINT UNSIGNED,
    FOREIGN KEY(title)
        REFERENCES game(title),
    dat_beg  datetime,
    dat_end  datetime,
    FOREIGN KEY(name)
        REFERENCES team(name),
    PRIMARY KEY(name,id_match)
);

CREATE TABLE rel_distribute
(
    FOREIGN_KEY(cnpj)
        REFERENCES distributor(cnpj),
    FOREIGN_KEY(title)
        REFERENCES game(title)
);

CREATE TABLE rel_owns
(
    FOREIGN_KEY(nickname)
        REFERENCES user(nickname),
    FOREIGN_KEY(title)
        REFERENCES game(title)
);

CREATE TABLE rel_participate
(
    FOREIGN_KEY(nickname)
        REFERENCES user(nickname),
    FOREIGN_KEY(name)
        REFERENCES team(name)
);

CREATE TABLE rel_play
(
    FOREIGN_KEY(name)
        REFERENCES team(name),
    FOREIGN_KEY(title)
        REFERENCES game(title)
);

CREATE TABLE rel_dispute
(
    FOREIGN_KEY(name)
        REFERENCES team(name),
    FOREIGN_KEY(title,id_match)
        REFERENCES match(title,id_match)
);
