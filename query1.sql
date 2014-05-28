SELECT G_teams.teamName, dat_beg, dat_end
FROM rel_win, challenge, (SELECT * FROM rel_participate AS RP WHERE RP.nickname="the1") AS G_teams
ORDER BY dat_beg DESC;

