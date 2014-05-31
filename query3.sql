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
-- QUERY: Check if all gamers of 'team1' have 'game4'
--        (to 'team1' plays it)
--
-- Relational Algebra:
-- Team1_Gamers  ← σ_teamName='team1'(rel_participate)
-- Game4_Owners  ← σ_gameTitle='game4'(rel_owns)
-- Team1&Game4   ← Team1_Owners * Team1_Gamers
-- Gamers\Game4  ← Team1_Gamers - Team1&Game4
-- 
SELECT DISTINCT DESQ.nickname
FROM   rel_participate AS DESQ
WHERE  DESQ.teamName = 'team1'
  AND  DESQ.nickname NOT IN (
           SELECT OWNS.nickname /*1*/
           FROM   rel_participate AS PART,
                  rel_owns AS OWNS
           WHERE  PART.teamName = 'team1'
             AND  OWNS.gameTitle = 'game4'
             AND  OWNS.nickname = PART.nickname);
