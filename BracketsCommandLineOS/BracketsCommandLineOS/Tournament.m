
//  Tournament.m
//  BracketsCommandLineOS

//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
// http://stackoverflow.com/questions/22859730/generate-a-single-elimination-tournament

#import "Tournament.h"
#import "Game.h"
#import "Team.h"
#import "Score.h"
#import "TournamentProtocol.h"
#import "TournamentUtilities.h"

@interface Tournament()
    @property (nonatomic,strong)NSMutableArray * teams;
    @property (nonatomic,strong)NSMutableArray * winningTeams;
    @property (nonatomic,strong)NSMutableArray * losingTeams;
    @property (nonatomic,strong)NSMutableArray * players;
    @property NSUInteger numberOfGames;
    @property NSUInteger numberOfLevels;
    @property NSUInteger numberOfTeams;
    @property NSUInteger numberOfFirstRoundGames;
    @property (nonatomic,strong) NSString *  tournamentId;
    @property (nonatomic,strong) id<TournamentProtocol> tournament;
    

@end


@implementation Tournament
/**
 *  Default init method
 *
 *  @return instance of the tournament class
 */
-(instancetype)init{
    if(self = [ super init]){
        _teams   = [NSMutableArray new];
        _players = [NSMutableArray new];
        _winningTeams = [NSMutableArray new];
        _losingTeams = [NSMutableArray new];
        _tournamentId = [[NSUUID UUID]UUIDString];
        
    }
    return self;
}

#pragma mark public methods
-(NSUInteger)getTotalNumberOfTeams;{
    return self.numberOfTeams;
}


-(NSUInteger)getNumberOfGames{
    return self.numberOfGames;
}

-(NSString *)getTournamentId;{
    return _tournamentId;
}

-(id)getTournamentSchedule;{
  return  [self.tournament getTournamentSchedule];
    
}


-(void)buildBracketFor:(TournamentMode)mode;{
    
    switch (mode) {
        case kSingleElimination:
            [self.tournament buildBracketWithTeams:self.teams];
            break;
        case kDoubleElimination:
            
            break;
        case kRoundRobin:
            
            break;
            
        default:
            break;
    }
}

/** Tournament Mode */
-(void)setTournamentMode:(TournamentMode)tournamentMode{
    _tournamentMode = tournamentMode;
}


-(instancetype)initWithNumberOfTeams:(int)numberofteams{
    self = [self init];
   
    
    
    
    return self;
}





-(void)addTeam:(NSString *)teamName{
    Team * team = [Team new];
    team.name = teamName;

    //reset bracket
    [self.teams addObject:team];
    int i =1;
    for(id team in self.teams){
        [team setSeed:[NSNumber numberWithInt:i]];
        i++;
    }
    
    [self.tournament buildBracketWithTeams:self.teams];
    
    //recalculate bracket
    //[self.tournament displayBracket];
}

-(void)removeTeam:(id)team{
    [self.teams removeObject:team];
    
    [self.teams enumerateObjectsUsingBlock:^(Team * team, NSUInteger idx, BOOL *stop) {
         [team setSeed:[NSNumber numberWithInteger:idx]];
    }];

    [self.tournament buildBracketWithTeams:self.teams];
}


/**
 Methods for setting score for the game
*/
-(void)setScore:(id)score game:(id)game{
    [self.tournament setScore:score game:game];
}


-(id)getStatsForTeam:(id)team{
    if([self.teams containsObject:team]){
        return [team stats];
    }
    
    return NULL;
}



#pragma mark utilities

-(id)searchForGame:(id)game;{
    return [self.tournament searchForGame:(id)game];
}

-(id)getTeamsInOrder;{

    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"stats" ascending:NO];
    [self.teams sortUsingDescriptors:@[sort]];
    
    return self.teams;
}


@end
