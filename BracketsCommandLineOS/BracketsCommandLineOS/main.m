//
//  main.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
/*
 
 1-
   - Game 1
 2-
 
 3-
   - Game 2
 4-
 
L1-
    - Game 3
L2-
 
 

 */

/*
Tournament
Mode:
 Round-Robin
 Single-Elimination
 Double-Elimination

 Adding Teams/Players 
 Specify Number of Groups 
 Specify Number of stages (round robin + single/double elimination)
 
    Common elements
        Game Schedule
        Teams in order
 
    //Add
    Stage 1:
        Round-Robin 
        Pick Number of rounds
 
 or
        Single/Double Elimination
 
 
    Stage 2:
        Tournament
        Pick single/double
 or
 
 
 */


#import <Foundation/Foundation.h>
#import "Tournament.h"
#import "Game.h"
#import "Stats.h"
#import "Score.h"
#import "Team.h"
#import "RoundRobin.h"

NSUInteger totalNumberOfLosersDistributed=0;
NSUInteger totalNumberOfLosers =0;
 NSUInteger gameCount =0;

void distributeTeams(NSMutableArray * lastLevelLoserNodes, NSMutableArray* loserTeamsToDistribute){

    NSUInteger losersCount =loserTeamsToDistribute.count;
    NSMutableArray * newLastLevelLoserNodes = [NSMutableArray new];
   
    
    for(Game * gl in lastLevelLoserNodes){
        
      
        //Case 1: we have one losing team
        if(losersCount == 1){

            //adding a teams that has bye
            if(!gl.team1)
            {
                gl.team1 = [loserTeamsToDistribute lastObject];
                [loserTeamsToDistribute removeLastObject];
                totalNumberOfLosersDistributed++;
                losersCount --;

            }
            else if(!gl.team2){
                gl.team2 = [loserTeamsToDistribute lastObject];
                [loserTeamsToDistribute removeLastObject];
                totalNumberOfLosersDistributed++;
                losersCount --;
            }
            
            //Make sure that there are still additional teams to be distributed
            if(totalNumberOfLosersDistributed == totalNumberOfLosers){
                //End of the story
                break;
            }
            else{
                //add a new game
                Game *ng = [Game new];
                ng.parent = gl;
                gl.right = ng;
                ng.gameId = @(gameCount);
                gameCount ++;
                [newLastLevelLoserNodes addObject:ng];

           }
        }
        
        //Case 2 multiple teams to distribute
        //Adding game or just a team?
        
        //so it depends
        // if we have one team left or more  let's say we have only one
        if(losersCount>1){

            NSUInteger losersLeft =  totalNumberOfLosersDistributed - totalNumberOfLosers;
            if(losersLeft == 1){ // that contradicts with if losersCount > 1
             
            }
            
            if(losersLeft == 2){
                //check if it is available
                if(!gl.team1)
                {
                    gl.team1 = [loserTeamsToDistribute lastObject];
                    [loserTeamsToDistribute removeLastObject];
                    totalNumberOfLosersDistributed++;
                }
                else if(!gl.team2){
                    gl.team2 = [loserTeamsToDistribute lastObject];
                    [loserTeamsToDistribute removeLastObject];
                    totalNumberOfLosersDistributed++;
                    losersCount --;
                }

            }
            
            if(losersLeft == 3){
                //check if it is available
                if(!gl.team1)
                {
                    gl.team1 = [loserTeamsToDistribute lastObject];
                    [loserTeamsToDistribute removeLastObject];
                    totalNumberOfLosersDistributed++;
                    //create a new game
                    Game *ng = [Game new];
                    ng.parent = gl;
                    gl.right = ng;
                    ng.gameId = @(gameCount);
                    gameCount ++;
                    
                    [newLastLevelLoserNodes addObject:ng];
                    
                    
                }
                else if(!gl.team2){
                    gl.team2 = [loserTeamsToDistribute lastObject];
                    [loserTeamsToDistribute removeLastObject];
                    totalNumberOfLosersDistributed++;
                    losersCount --;
                
                    //create a new game
                    Game *ng = [Game new];
                    ng.parent = gl;
                    gl.left = ng;
                    
                    ng.gameId = @(gameCount);
                    gameCount ++;
                    
                    [newLastLevelLoserNodes addObject:ng];
                }
 
            }
            if(losersLeft >= 4){
                Game *ng = [Game new];
                ng.parent = gl;
                gl.right = ng;
                ng.team1 =[loserTeamsToDistribute lastObject];
                [loserTeamsToDistribute removeLastObject];
                 [newLastLevelLoserNodes addObject:ng];
                
                Game *ng1 = [Game new];
                ng.parent = gl;
                gl.left = ng1;
                
                ng.gameId = @(gameCount);
                gameCount ++;

                ng1.gameId = @(gameCount);
                gameCount ++;
                ng1.team2 =[loserTeamsToDistribute lastObject];
                [loserTeamsToDistribute removeLastObject];
                [newLastLevelLoserNodes addObject:ng1];
            }
        }
        
        
        if(totalNumberOfLosersDistributed == totalNumberOfLosers){
            //End of the story
            break;
        }
    }
    lastLevelLoserNodes = newLastLevelLoserNodes;
    
}


Game* buildLoserBracket(){
    Game * lroot = [Game new];// final loser's game
    lroot.gameId = @(gameCount);
    gameCount++;
    
    // I think I should loop through the winners bracket...:
    //
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];

    
    
//    [t addTeam:@"Jack/Michelle"];
//    [t addTeam:@"Ian/Patchi"];
//    [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];

    Game * rroot = [t getTournamentTree];
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    [queue addObject:rroot];
    
    NSUInteger nodesInNextLevel = 0;
    NSUInteger nodesInCurrentLevel = 1;
    NSUInteger currentLevel = 0;
   // NSUInteger totalNumberOfNodes =0;
    totalNumberOfLosers = [t getNumberOfGames];
  
    // NSUInteger totalNumberOfLosersDistributed = 0;
    
    NSMutableArray * currentLevelNodes = [NSMutableArray new];
    NSMutableArray * loserTeamsToDistribute = [NSMutableArray new];
    
    NSMutableArray * nextLevelLoserNodes = [NSMutableArray new];
    [currentLevelNodes addObject: lroot];
    
    while(queue.count>0){
        Game * g= queue.lastObject;
//        NSLog(@"Game g %@",g);
        [queue removeLastObject];
        nodesInCurrentLevel--;
        
        //loop through all games at this level probably it can be called after the level is traversed
  
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }

        NSArray *nodes =   g.getChildrenNodes;

        for(Game * child in nodes){
            [queue insertObject:child atIndex:0];
            nodesInNextLevel++;
            [nextLevelLoserNodes addObject:child];
        }
        
        if(nodesInCurrentLevel == 0){
            //here we know all the nodes on current level so we should determine what to do with the losers

            for (Game * gl in currentLevelNodes){
                //create a list of losers to redistribute
                Team * t = [Team new];
                t.name = [NSString stringWithFormat:@"L%@",gl.number];
                [loserTeamsToDistribute addObject:t];
            }
            
            //[currentLevelNodes removeAllObjects];
            [currentLevelNodes addObjectsFromArray:nextLevelLoserNodes];
            [nextLevelLoserNodes removeAllObjects];

            distributeTeams(currentLevelNodes, loserTeamsToDistribute);

            nodesInCurrentLevel = nodesInNextLevel;
           // totalNumberOfNodes = nodesInNextLevel;
            nodesInNextLevel = 0;
            currentLevel++;

            
        }
    }
    
    return lroot;
}


void displayBracket(Game * root){
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    NSUInteger nodesInNextLevel = 0;
    NSUInteger nodesInCurrentLevel = 0;

    
    [queue addObject:root];

    
    while(queue.count>0){
        Game * g= queue.lastObject;
        NSLog(@"Game %@ ",g);

        [queue removeLastObject];
        nodesInCurrentLevel--;
        
        //loop through all games at this level probably it can be called after the level is traversed
        
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        
        for(Game * child in nodes){
            [queue insertObject:child atIndex:0];
            nodesInNextLevel++;
        }
        
        if(nodesInCurrentLevel == 0){
            //here we know all the nodes on current level so we should determine what to do with the losers
            NSLog(@"_______");
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            
        }
    }


}





int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
       //testRoundRobin();
        NSLog(@"Start");
        Game * g= buildLoserBracket();
        displayBracket(g);
        
    }
    return 0;
}

void shiftArrayRight(NSMutableArray *teams) {
    
    NSUInteger half = teams.count/2;
    if(teams.count%2!=0){
        half++;
        [teams addObject:[NSNull null]];
    }
    int start =1;
    id temp=[NSNull null];
    
    while (start<half) {
        id temp2 = teams[start];
        teams[start] =temp;
        temp =temp2;
        
        start++;
    }
    
    int end = (int)teams.count -1;
    while (end>=half) {
        id temp2 = teams[end];
        teams[end] = temp;
        temp = temp2;
        end--;
    }
    teams[1]=temp;
    
    // NSLog(@"Teams %@",teams);
    
}


void testRoundRobin(){
    // NSMutableArray * a =[ @[@1,@2,@3,@4,@5] mutableCopy];
    //123
    //45N
    //142
    //5N3
    
    // shiftArrayRight(a);
    
    RoundRobin * r = [RoundRobin new];
    assert([r numberOfGamesForTeams:2]==1);
    assert([r numberOfGamesForTeams:3]==2);
    assert([r numberOfGamesForTeams:4]==6);
    
    
    Team * team =[Team new];
    team.name =@"Janek/Taylor";
    Team * team2 =[Team new];
    team2.name =@"Keith/Megan";
    Team * team3 =[Team new];
    team3.name =@"Charlie/Chelsea";
    Team * team4 =[Team new];
    team4.name =@"Carl/Jane";
    
    NSArray * teams =  @[team,team2,team3,team4];
    
    [r buildBracketWithTeams:teams];
    
    Game * g1 = [Game new];
    g1.number =@1;
    
    Game * g2 = [Game new];
    g2.number =@2;
    
    Game * g3 = [Game new];
    g3.number =@3;
    
    Game * game = [r searchForGame: g1];
    //  Game * game2 = [r searchForGame: g2];
    Game * game3 = [r searchForGame: g3];
    
    
    Score * s = [Score new];
    
    [s setScore:@21 andScore:@13 betweenTeam:game.team1 andTeam2:game.team2 final:YES];
    [s setScore:@15 andScore:@21 betweenTeam:game.team1 andTeam2:game.team2 final:YES];
    
    [r setScore:s game:game];
    
    // [game setScore:s];
    
    assert([s getPointsForTeam:game.team1 won:YES] == 36);
    assert([s getPointsForTeam:game.team1 won:NO] == 34);
    assert([s getSetsForTeam:game.team1 won:YES]==1);
    assert([s getSetsForTeam:game.team2 won:NO]==1);
    
    [s setScore:@21 andScore:@19 betweenTeam:game.team1 andTeam2:game.team2 final:YES];
    [r setScore:s game:game];
    
    assert([s getSetsForTeam:game.team1 won:YES]==2);
    
    Score * s2 = [Score new];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 final:YES];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 final:YES];
    
    
    NSLog(@"Stats of the team %@ %@", [game.team1 name], [game.team1 stats]);
    
    NSLog(@"Teams in order: %@ ",[r getTeamsInOrder]);
    
    NSLog(@"Get Schedule: %@", [r getTournamentSchedule]);
    
    
}

void testMainTournament(){
    
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];
    
    assert([t getTotalNumberOfTeams] == 7 );
    
    
    Game * g1 = [Game new];
    g1.number =@1;
    
    Game * g2 = [Game new];
    g2.number =@2;
    
    Game * g3 = [Game new];
    g3.number =@3;
    
    Game * game = [t searchForGame: g1];
    Game * game2 = [t searchForGame: g2];
    Game * game3 = [t searchForGame: g3];
    
    NSLog(@"Game is: %@",game);
    
    Score * s = [Score new];
    
    [s setScore:@21 andScore:@13 betweenTeam:game.team1 andTeam2:game.team2 final:YES];
    [s setScore:@15 andScore:@21 betweenTeam:game.team1 andTeam2:game.team2 final:NO];
    
    [t setScore:s game:game];
    
    // [game setScore:s];
    
    assert([s getPointsForTeam:game.team1 won:YES] == 36);
    assert([s getPointsForTeam:game.team1 won:NO] == 34);
    assert([s getSetsForTeam:game.team1 won:YES]==1);
    assert([s getSetsForTeam:game.team2 won:NO]==1);
    
    
    [s setScore:@21 andScore:@19 betweenTeam:game.team1 andTeam2:game.team2 final:YES];
    [t setScore:s game:game];
    
    assert([s getSetsForTeam:game.team1 won:YES]==2);
    // [t updateStats];
    
    NSLog(@"Stats of the team %@ %@", [game.team1 name], [game.team1 stats]);
    NSLog(@"Stats of the team %@ %@", [game.team2 name], [game.team2 stats]);
    
    id winner = [s getWinner];
    NSLog(@"Winner is: %@ ",winner);
    
    //Testing Order
    assert([[game.team1 stats] compare:[game.team2 stats]]== NSOrderedDescending);
    assert([[game.team2 stats] compare:[game.team1 stats]]== NSOrderedAscending);
    assert([[game2.team2 stats] compare:[game.team2 stats]]== NSOrderedAscending);
    assert([[game2.team2 stats] compare:[game2.team1 stats]]== NSOrderedSame);
    
    Score * s1 = [Score new];
    
    [s1 setScore:@21 andScore:@11 betweenTeam:game2.team1 andTeam2:game2.team2 final:YES];
    [s1 setScore:@21 andScore:@15 betweenTeam:game2.team1 andTeam2:game2.team2 final:YES];
    
    [t setScore:s1 game:game2];
    
    Score * s2 = [Score new];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 final:YES];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 final:YES];
    
    [t setScore:s2 game:game3];
    
    
    NSLog(@"Stats of the team %@ %@", [game2.team1 name], [game2.team1 stats]);
    //get teams
    //NSLog(@"Teams in order: %@ ",[t getTeamsInOrder]);
    
    NSLog(@"Get Schedule: %@", [t getTournamentSchedule]);
    
    
}



