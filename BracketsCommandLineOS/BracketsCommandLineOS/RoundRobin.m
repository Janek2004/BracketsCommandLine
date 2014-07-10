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
   
    
    
    return  (self.teams.count/2 ) * (self.teams.count -1);
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
    self.teams = [teams mutableCopy];
    
    NSMutableArray * mutableTeams = [teams mutableCopy];
    NSUInteger half = teams.count/2;
    NSLog(@"%d",(int)teams.count%2);

    
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
       //  NSUInteger pivotIndex =0;
         NSUInteger lastElementIndex = narray.count-1;
        //round1
        //NSMutableArray * array = [NSMutableArray new];
        id temp = nil;
        
        while(lastElementIndex>0){
            if(!temp){
                temp = [narray objectAtIndex:lastElementIndex-1];
                [narray replaceObjectAtIndex:lastElementIndex-1 withObject:[narray objectAtIndex:lastElementIndex]];
                lastElementIndex--;
            }
            
            else{
                id temptemp = [narray objectAtIndex:lastElementIndex-1];
                [narray replaceObjectAtIndex:lastElementIndex-1 withObject:temp];
                temp = temptemp;
                lastElementIndex--;
            }
        }
        NSLog(@"NARRAY %@",narray);
        
        //get teams from array
        NSLog(@"___________________________________________________");
        for(int i=0;i<half; i++){
            id team1 = [narray objectAtIndex:i];
            id team2 = [narray objectAtIndex:i+half];
            
            Game *g = [Game new];
            g.team1 = team1;
            g.team2 = team2;
            [finalArray addObject:g];
        }
        
        NSLog(@"%@",finalArray);
        
    }
    

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
