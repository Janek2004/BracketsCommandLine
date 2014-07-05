//
//  Stats.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/2/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stats : NSObject

@property (nonatomic, assign) NSInteger * numberOfVictories;
@property (nonatomic, assign) NSInteger * numberOfLosses;
@property (nonatomic, assign) NSInteger * numberOfPointsWon;
@property (nonatomic, assign) NSInteger * numberOfPointsLost;
@property (nonatomic, assign) NSInteger * numberOfPointsDifference;

-(void)addGameResult:(id)game between:(id)team1 and:(id)team2 score:(id)score tournament:(id)tournament;
-(id)getStatsForTournament:(id)tournament;
-(id)getLifetimeStatsForTeam:(id)team;



@end
