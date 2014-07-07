//
//  Tournament.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
@import CoreLocation;
#import <Foundation/Foundation.h>


typedef enum {
    kRoundRobin,
    kSingleElimination,
    kDoubleElimination
}TournamentMode;


@interface Tournament : NSObject

@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) NSString * name;
@property (nonatomic, strong) CLLocation * location;
@property (nonatomic, readonly) TournamentMode tournamentMode;


//initializer
-(instancetype)initWithNumberOfTeams:(int)numberofteams;

//teams
-(void)addTeam:(NSString *)team;
-(void)removeTeam:(id)team;

//-(NSUInteger)numberOfGamesForTeamsNumber:(NSUInteger)teamsNumber andMode:(TournamentMode)mode;
//-(void)displayBracket;

-(void)buildBracketFor:(TournamentMode)mode;

-(void)setTournamentMode:(TournamentMode)tournamentMode;
-(id)searchForGame:(id)game;
-(void)setScore:(id)score game:(id)game;

//Public Methods
-(NSUInteger)getTotalNumberOfTeams;
-(NSUInteger)getNumberOfGames;
-(NSString *)getTournamentId;

//-(void)updateStats;
-(id)getStatsForTeam:(id)team;
-(id)getTeamsInOrder;
-(id)getTournamentSchedule;




@end
