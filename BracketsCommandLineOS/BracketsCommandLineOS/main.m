//
//  main.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

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

void shiftArrayRight(NSMutableArray *teams, NSUInteger shift) {
    //get half
    //add additional team
    
    NSUInteger half = teams.count/2;
    NSLog(@"%d",(int)teams.count%2);
    
    if(teams.count%2!=0){
        half++;
        [teams addObject:[NSNull null]];
    }
    int start =1;
    id temp;
   
    while (start<half) {
        temp =teams[start + 1];
        teams[start + 1] = teams[start];
    }
    
    while (start<teams.count) {
        temp =teams[start + 1];
        teams[start + 1] = teams[start];
    }
    
    
    
    
//    for (NSUInteger i = shift; i > 0; i--) {
//    	NSObject *obj = [mutableArray lastObject];
//    	[mutableArray insertObject:obj atIndex:0];
//    	[mutableArray removeLastObject];
//    }
}


void testRoundRobin(){
    NSMutableArray * a =[ @[@1,@2,@3,@4,@5] mutableCopy];
    shiftArrayRight(a, 0);
    
//    RoundRobin * r = [RoundRobin new];
//    
//  
//    
//    Team * team =[Team new];
//    team.name =@"Janek/Taylor";
//    Team * team2 =[Team new];
//    team2.name =@"Keith/Megan";
//    Team * team3 =[Team new];
//    team3.name =@"Charlie/Chelsea";
//    Team * team4 =[Team new];
//    team4.name =@"Carl/Jane";
//    
//    NSArray * teams =  @[team,team2,team3,team4];
//   
//    
//    // [r buildBracketWithTeams:teams];
//    
//  NSLog(@"Number of games: %lu",r.numberOfGames);
    
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


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        testRoundRobin();
    
        
    }
    return 0;
}

