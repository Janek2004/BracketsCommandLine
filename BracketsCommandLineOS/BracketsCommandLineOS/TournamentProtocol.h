//
//  TournamentProtocol.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TournamentProtocol <NSObject>
-(id)getTeamsInOrder;
-(id)getTournamentSchedule;
-(void)buildBracketWithTeams:(NSArray *)teams;
/**
 Methods for setting score for the game
 */
-(void)setScore:(id)score game:(id)game;
-(id)searchForGame:(id)game;

@end
