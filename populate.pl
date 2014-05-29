#!/usr/bin/perl
use v5.10;

# Pragmas
use strict;
use warnings;

for my $id (1 .. 10) {
    print "INSERT INTO team(name) VALUES('test$id');", "\n";
}
#INSERT INTO team(name) VALUES('test1');
#INSERT INTO gamer(name, nickname, card_num, password) VALUES('test1');
#INSERT INTO game(title, version) VALUES('test1');
#INSERT INTO rel_owns(nickname, title) VALUES('test1');
#INSERT INTO rel_play(teamName, gameTitle) VALUES('test1');
