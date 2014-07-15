//
//  RoundRobin.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "RoundRobin.h"
#import "TournamentUtilities.h"
#import "Game.h"
#import "Team.h"
#import "Score.h"

@interface RoundRobin()
@property (nonatomic, strong) TournamentUtilities* utilities;
@property (nonatomic, strong) NSMutableArray * teams;
@property (nonatomic, strong) NSMutableArray * games;

@end

@implementation RoundRobin

-(instancetype)init{
    if(self =[super init]){
        _utilities = [TournamentUtilities new];
        _teams = [NSMutableArray new];
        _games = [NSMutableArray new];
    }
    return self;
}


-(void)shiftArrayRight:(NSMutableArray *)teams {
    
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


-(NSUInteger) numberOfGamesForTeams:(NSUInteger)teamsCount{
   
    return  (teamsCount/2 ) * (teamsCount -1);
}

/**
 *  Set Teams
 *
 *  @param teams teams
 */
-(void)setTournamentTeams:(id)teams;{
    self.teams = teams;
}

/**
 *  Returns ordered games
 *
 *  @return ordered games to set
 */
-(id)getTournamentSchedule;{
    
    return [self buildBracketWithTeams:self.teams];
}
/**
 *  Build tournament bracket
 *
 *  @param teams list of teams
 */
-(NSArray *)buildBracketWithTeams:(NSArray *)teams;{
    self.teams = [teams mutableCopy];
    
    NSMutableArray * mutableTeams = [teams mutableCopy];
    NSUInteger half = teams.count/2;
   // NSLog(@"%d",(int)teams.count%2);

    
    if(teams.count%2!=0){
        half++;
        [mutableTeams addObject:[NSNull null]];
        
    }
    
    NSMutableArray * narray =[NSMutableArray new];
    __block NSUInteger back = mutableTeams.count-1;
    
    [mutableTeams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(idx<half){
            [narray addObject:mutableTeams[idx]];
        }
        else{
            [narray addObject:mutableTeams[back]];
            back--;
        }
    }];

    NSMutableArray * finalArray = [NSMutableArray new];
    
    for(int i=0; i<narray.count-1;i++){
        [self shiftArrayRight:narray];
        
        for(int i=0;i<half; i++){
            id team1 = [narray objectAtIndex:i];
            id team2 = [narray objectAtIndex:i+half];
            
            Game *g = [Game new];
            g.number = [NSNumber numberWithInteger:finalArray.count+1];
            g.team1 = team1;
            g.team2 = team2;
            [finalArray addObject:g];
        }
  
    }
    self.games = finalArray;
    
    return finalArray;
}

/**
 *  Adding score to the game
 *
 *  @param score score
 *  @param game  game
 */
-(void)setScore:(id)score game:(id)game;{
    Game * foundGame = [self searchForGame:game];
    foundGame.score = score;
    [foundGame.team1 updateStatsWithScore:score];
    [foundGame.team2 updateStatsWithScore:score];
    
//  Team * winner = [score getWinner];
//    if(winner){
//        //get parent
//        Game * parentGame = foundGame.parent;
//        if(parentGame.left == foundGame){
//            parentGame.team1 =winner;
//        }
//        if(parentGame.right == foundGame){
//            parentGame.team2 =winner;
//        }
//    }
// [self updateStats]; //update team stats//  [self.utilities getTeamsInOrder:self.teams];

    

}

-(id)getTeamsInOrder;{
    
   return  [self.utilities getTeamsInOrder:self.teams];
}


-(id)searchForGame:(Game *)game;{
    
//    NSSortDescriptor * sort =
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"number == %@", game.number];
    NSArray * a = [self.games filteredArrayUsingPredicate:predicate];
    if(a>0){
        return a[0];
    }
    
    return nil;
}


@end
