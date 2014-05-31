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
-- QUERY: All the challenges won by `the1`, sorted by date
-- 
-- Relational Algebra:
-- The1_Teams      ← σ_nickname='the1' (rel_participate)
-- The1_Wins       ← The1_Teams * rel_win
-- The1_WinMatches ← The1_Wins  * rel_challenges 
-- The1_Victories  ← π_teamName,dat_beg,dat_end(The1_WinMatches)
-- The1_SVictories ← ε_sort(dat_beg,dat_end) (The1_SVictories)
-- 
SELECT DISTINCT PART.teamName, MATCHES.dat_beg, MATCHES.dat_end
FROM   rel_participate AS PART,
       rel_win AS WIN,
       challenge AS MATCHES
WHERE  PART.nickname = 'the1'
  AND  PART.teamName = WIN.teamName
  AND  WIN.gameTitle = MATCHES.gameTitle
  AND  WIN.idChallenge = MATCHES.id
ORDER BY dat_beg, dat_end DESC;
