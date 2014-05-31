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

USE gamestore;

--
-- QUERY: List best players of `game1`
--
-- Relational Algebra:
-- Game1Victory  ← σ_gameTitle='game1' (rel_win)
-- Game1WinMatch ← Game1Victory * challenge
-- Game1Winners  ← rel_participate * Game1WinMatch
-- BestPlayers   ← π_nickname,idChallenge (Game1Winners)
-- GBestPlayers  ← ε_groupby(nickname) (GBestPlayers)
-- SGBestPlayers ← ε_sort(count(idChallenge)) (SBestPlayers)
-- 
SELECT DISTINCT PART.nickname, COUNT(WIN.idChallenge)
FROM   rel_participate AS PART,
       rel_win AS WIN,
       challenge AS MATCHES
WHERE  WIN.gameTitle = 'game1'
  AND  PART.teamName = WIN.teamName
  AND  WIN.gameTitle = MATCHES.gameTitle
  AND  WIN.idChallenge = MATCHES.id
GROUP BY PART.nickname
ORDER BY COUNT(WIN.idChallenge) DESC;
