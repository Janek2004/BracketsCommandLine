//
//  Score.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/4/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Score.h"

@implementation Score
-(instancetype)init{
    self = [super init];
    if(self)
    {
        _sets = [NSMutableArray new];
    }
    return self;
}


-(void)setScore:(id)score1 andScore:(id)score2 betweenTeam:(id)team1 andTeam2:(id)team2;{
    
     NSMutableDictionary * dict = [NSMutableDictionary new];
     [dict setObject:score1 forKey:@"score1"];
     [dict setObject:score2 forKey:@"score2"];
     [dict setObject:team1 forKey:@"team1"];
     [dict setObject:team2 forKey:@"team2"];
    
    [_sets addObject:dict];
    
}


@end
