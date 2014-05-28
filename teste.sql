select *
from (SELECT teamName
            FROM rel_play AS PLAY
            WHERE PLAY.teamName='team1'
            AND PLAY.gameTitle NOT IN(
                SELECT OWNS.title
                FROM rel_owns AS OWNS
                WHERE OWNS.nickname='the1'
                ))
                where not teamName = 'team1'
