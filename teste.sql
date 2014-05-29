SELECT DISTINCT HYPH.nickname 
        FROM (SELECT PART.nickname,OWNS.title
              FROM  rel_participate AS PART,rel_owns AS OWNS
              WHERE PART.teamName='team1'
                    AND OWNS.title='game4') AS HYPH
        WHERE HYPH.nickname NOT IN 
              (SELECT OWNS.nickname
               FROM  rel_participate AS PART,rel_owns AS OWNS
               WHERE PART.teamName='team1')
               
               

