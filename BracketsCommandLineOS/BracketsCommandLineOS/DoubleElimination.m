//
//  DoubleElimination.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "DoubleElimination.h"
#import "SingleElimination.h"
/**
 This variation of the tournament will have two nodes of tournament
  * winners - winners will have original number of teams let's say n
  * losers - will have half of the teams 
 
  How do we deal with buys
 
 Winners:
  a-
    1 a-
  b-     2-a
      c-
                Final: a -b
 
  Losers
   b-----
          3-b
        c-
 
 
 http://www.aropupu.fi/bracket/
 
 */

#import "Game.h"
#import "Team.h"

@interface DoubleElimination()

 @property (nonatomic,strong) id finalGame;
 @property (nonatomic,strong) NSMutableArray * teams;

@end

@implementation DoubleElimination

-(NSUInteger)numberOfGames{
    switch (self.numberOfTeams) {
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}
/**
 *  Setting up teams
 *
 *  @param teams teams
 */
-(void)setTournamentTeams:(id)teams{
    self.teams = teams;
}



Game * createDDBracket(NSUInteger nrteams){
    Game * secondFinalGame = [Game new];
    Game * finalGame = [Game new];
    Game * losers = [Game new];
    Game * winners = [Game new];
    
    Team  *t0 = [Team new];
    secondFinalGame.team2  = t0;
    
    
    
    
    switch (nrteams) {
        case 3:
        {
            secondFinalGame.number = @5;
            finalGame.number = @4;
            losers.number= @3;
            winners.number =@2;
            
            Game *g = [Game new];
            g.number = @1;
            winners.right = g;
            g.parent = winners;
            
            t0.loserteamId = @"L4";
            
            Team  *t1 = [Team new];
            t1.loserteamId = @"L1";
            Team  *t2 = [Team new];
            t2.loserteamId = @"L2";
            losers.team1 = t1;
            losers.team2 = t2;
            
        }
            break;
            
        case 4:
        {
            secondFinalGame.number = @7;
            finalGame.number = @6;
            losers.number= @5;
            winners.number =@3;
            
            Game *wg = [Game new];
            wg.number = @1;
            
            Game *wg1 = [Game new];
            wg1.number = @1;
            
            winners.right = wg;
            winners.left = wg1;
            
            
            t0.loserteamId = @"L6";
            
            Team  *t3 = [Team new];
            t3.loserteamId = @"L3";
            Team  *t2 = [Team new];
            t2.loserteamId = @"L2";
            Team  *t1 = [Team new];
            t2.loserteamId = @"L2";
            
            losers.team1 = t3;
            
            Game * lg = [Game new];
            lg.number = @4;
            lg.team1  = t1;
            lg.team2  = t2;
            
        }
            break;
        default:
            break;
    }
    
    secondFinalGame.left = finalGame;
    finalGame.parent = secondFinalGame;
    finalGame.left = winners;
    finalGame.right =losers;
    
    winners.parent = finalGame;
    losers.parent = finalGame;
    
    
    
    return secondFinalGame;
    
}



@end
