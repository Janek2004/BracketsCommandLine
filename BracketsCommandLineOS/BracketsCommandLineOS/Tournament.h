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



//games
-(void)addGame:(id)team;
-(void)removeGame:(id)team;

//teams
-(void)addTeam:(id)team;
-(void)removeTeam:(id)team;

//players
-(void)addPlayer:(id)player;
-(void)removePlayer:(id)player;

-(void)addScore:(id)team1 andTeam2:(id)team2 winner:(id)team score1:(id)team1 score2:(id)team2;
-(void)displayBracket;
-(void)setTournamentMode:(TournamentMode)tournamentMode;





@end
