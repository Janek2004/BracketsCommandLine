//
//  RoundRobin.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "RoundRobin.h"
#import "TournamentUtilities.h"
@interface RoundRobin()
@property (nonatomic, strong) TournamentUtilities* utilities;
@property (nonatomic, strong) NSMutableArray * teams;
@end

@implementation RoundRobin

-(instancetype)init{
    if(self =[super init]){
        _utilities = [TournamentUtilities new];
        _teams = [NSMutableArray new];
    }
    return self;
}


-(NSUInteger) numberOfGames{
    
    return 0;
}

/**
 *  Set Teams
 *
 *  @param teams teams
 */
-(void)setTournamentTeams:(id)teams;{
    
}

/**
 *  Used for showing statistics
 *
 *  @return list of the teams in order
 */
-(id)getTeamsInOrder;{
  
    return nil;
}

/**
 *  Returns ordered games
 *
 *  @return ordered games to set
 */
-(id)getTournamentSchedule;{
    
    return nil;
}
/**
 *  Build tournament bracket
 *
 *  @param teams list of teams
 */
-(void)buildBracketWithTeams:(NSArray *)teams;{
  
    NSUInteger half = self.teams.count/2;
    if(self.teams.count %2>0){
        half++;
       // [self.teams addObject:[Team new]];
        
    }
  __block  NSUInteger lastElementIndex = self.teams.count-1;
  __block  NSUInteger pivotIndex = 0;
    
    [teams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //choose pivot
        pivotIndex =0;
        //round1
        while(pivotIndex<half){
            id team  = [teams objectAtIndex:pivotIndex];
            id team2 = [teams objectAtIndex:lastElementIndex];
             pivotIndex++;
             lastElementIndex--;
            
        }
        
        
        //move array
        
        
    }];
    
    
}
/**
 *  Adding score to the game
 *
 *  @param score score
 *  @param game  game
 */
-(void)setScore:(id)score game:(id)game;{
    
}


-(id)searchForGame:(id)game;{

    return nil;
}


@end
