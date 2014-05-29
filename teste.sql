SELECT DISTINCT PLAY.teamName FROM rel_play AS PLAY
            WHERE PLAY.teamName='team1'
            AND PLAY.gameTitle NOT IN(
                SELECT OWNS.title
                FROM rel_owns AS OWNS
                WHERE OWNS.nickname='the3');
