//
//  Stats.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/2/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Stats.h"
@interface Stats()

@end

@implementation Stats


-(instancetype)initWithTournamentId:(id)tournament{
    self = [super init];
    if(self)
    {
    
    }
    return self;
}


-(id)getStatsForTournament:(id)tournament;{
    return nil;
}

-(id)getLifetimeStatsForTeam:(id)team;{
    return nil;
}


-(void)addGameResult:(id)game between:(id)team1 and:(id)team2 score:(id)score tournament:(id)tournament;{
    //persist it somehow
    
    
}



@end
