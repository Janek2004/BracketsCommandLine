//
//  RoundRobin.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TournamentProtocol.h"
@interface RoundRobin : NSObject<TournamentProtocol>
@property (readonly) NSUInteger numberOfTeams;
@property (readonly) NSUInteger numberOfGames;
@property (readonly) NSUInteger numberOfLevels;


-(id)getTeamsInOrder;
-(id)getTournamentSchedule;
-(id)buildBracketWithTeams:(NSArray *)teams;
-(void)setScore:(id)score game:(id)game;
-(id)searchForGame:(id)game;
-(NSUInteger) numberOfGamesForTeams:(NSUInteger)teamsCount;


@end
