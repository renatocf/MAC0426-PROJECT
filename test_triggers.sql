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

-- Error: restriction_play
INSERT INTO rel_play(teamName, gameTitle) VALUES
('team1', 'game4');

-- Error: restriction_participate
INSERT INTO rel_participate(nickname,teamName) VALUES
('the3', 'team1');

-- Error: restriction_dispute

-- Error: restriction_win
