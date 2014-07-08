//
//  TournamentProtocol.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TournamentProtocol <NSObject>
@property (readonly) NSUInteger numberOfTeams;
@property (readonly) NSUInteger numberOfGames;
@property (readonly) NSUInteger numberOfLevels;

-(id)getTeamsInOrder;
-(id)getTournamentSchedule;
-(void)buildBracketWithTeams:(NSArray *)teams;
-(void)setScore:(id)score game:(id)game;
-(void)setTournamentTeams:(id)teams;
-(id)searchForGame:(id)game;

@end
